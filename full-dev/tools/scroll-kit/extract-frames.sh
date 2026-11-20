#!/usr/bin/env bash
# extract-frames.sh — turn a video into a numbered image sequence for a
# scroll-driven <canvas> (the "Apple product page" technique).
#
# Why frames instead of video: drawing a decoded image to a canvas is instant
# and exact on every browser (including iOS Safari), at the cost of bandwidth.
# Rule of thumb: 60–150 frames, ≤ 1600 px wide on desktop, ≤ 800 px on mobile,
# WebP q≈70 (≈40–120 KB/frame). Total budget: ~4–8 MB desktop, ~2–3 MB mobile,
# loaded progressively (see image-sequence-canvas.html).
#
# Outputs:
#   OUT_DIR/desktop/frame_0001.webp …   (and/or .avif)
#   OUT_DIR/mobile/frame_0001.webp …    (when MOBILE_W > 0)
#   OUT_DIR/manifest.json               {count, ext, pad, desktop:{w,h,path}, mobile:{…}}
#
# Usage:
#   ./extract-frames.sh input.mp4 [OUT_DIR] [COUNT]
# Env overrides (defaults in brackets):
#   WIDTH [1600]  MOBILE_W [800, 0 = skip]  FORMAT [webp | avif | both]  QUALITY [70]  AVIF_CRF [32]
set -euo pipefail

# ── 1. Arguments and checks ──────────────────────────────────────────────────
IN="${1:-}"
if [[ -z "$IN" || ! -f "$IN" ]]; then
  echo "usage: $0 input-video [out-dir] [frame-count]" >&2; exit 1
fi
OUT_DIR="${2:-./frames-out}"
COUNT="${3:-120}"
WIDTH="${WIDTH:-1600}"
MOBILE_W="${MOBILE_W:-800}"
FORMAT="${FORMAT:-webp}"
QUALITY="${QUALITY:-70}"
AVIF_CRF="${AVIF_CRF:-32}"
command -v ffmpeg >/dev/null && command -v ffprobe >/dev/null || { echo "ffmpeg/ffprobe not found" >&2; exit 1; }
[[ "$COUNT" =~ ^[0-9]+$ && "$COUNT" -ge 2 ]] || { echo "frame count must be an integer ≥ 2" >&2; exit 1; }

# ── 2. Work out the sampling rate that yields exactly COUNT frames ───────────
DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$IN")
RATE=$(awk -v c="$COUNT" -v d="$DUR" 'BEGIN{ printf "%.6f", c/d }')
echo "→ $IN: ${DUR}s → $COUNT frames (sampling ${RATE} fps), format=$FORMAT"

extract() { # $1 width  $2 dir
  local w="$1" dir="$2"
  mkdir -p "$dir"
  if [[ "$FORMAT" == webp || "$FORMAT" == both ]]; then
    ffmpeg -hide_banner -loglevel error -y -i "$IN" -an \
      -vf "fps=${RATE},scale=${w}:-2:flags=lanczos" -frames:v "$COUNT" \
      -c:v libwebp -quality "$QUALITY" -compression_level 6 "$dir/frame_%04d.webp"
  fi
  if [[ "$FORMAT" == avif || "$FORMAT" == both ]]; then
    # ffmpeg writes still AVIF through libaom (one file per frame).
    ffmpeg -hide_banner -loglevel error -y -i "$IN" -an \
      -vf "fps=${RATE},scale=${w}:-2:flags=lanczos,format=yuv420p" -frames:v "$COUNT" \
      -c:v libaom-av1 -still-picture 1 -crf "$AVIF_CRF" -cpu-used 6 -f image2 "$dir/frame_%04d.avif"
  fi
}

# ── 3. Extract desktop (+ mobile) sets ───────────────────────────────────────
extract "$WIDTH" "$OUT_DIR/desktop"
[[ "$MOBILE_W" != "0" ]] && extract "$MOBILE_W" "$OUT_DIR/mobile"

# ── 4. Manifest — the canvas player reads this instead of hard-coding counts ─
EXT=webp; [[ "$FORMAT" == avif ]] && EXT=avif
dims() { ffprobe -v error -show_entries stream=width,height -of csv=p=0:s=x "$1"; }
first_d="$OUT_DIR/desktop/frame_0001.$EXT"
real_count=$(ls "$OUT_DIR/desktop"/frame_*."$EXT" | wc -l | tr -d ' ')
D=$(dims "$first_d"); DW=${D%x*}; DH=${D#*x}
MOB="null"
if [[ "$MOBILE_W" != "0" ]]; then
  M=$(dims "$OUT_DIR/mobile/frame_0001.$EXT"); MOB="{\"w\":${M%x*},\"h\":${M#*x},\"path\":\"mobile/\"}"
fi
cat > "$OUT_DIR/manifest.json" <<JSON
{"count":$real_count,"ext":"$EXT","pad":4,"prefix":"frame_","desktop":{"w":$DW,"h":$DH,"path":"desktop/"},"mobile":$MOB}
JSON

# ── 5. Report ────────────────────────────────────────────────────────────────
for set in desktop mobile; do
  [[ -d "$OUT_DIR/$set" ]] || continue
  n=$(ls "$OUT_DIR/$set" | grep -c "\.$EXT$")
  kb=$(du -sk "$OUT_DIR/$set" | cut -f1)
  echo "  $set: $n .$EXT frames, ${kb} KB on disk (all formats)"
done
[[ "$real_count" != "$COUNT" ]] && echo "! got $real_count frames (asked $COUNT) — source shorter than expected"
echo "Done → $OUT_DIR (manifest.json)"
