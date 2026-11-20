#!/usr/bin/env bash
# prepare-scrub-video.sh — encode a video so it can be scrubbed by scroll.
#
# Why: a normal web video has a keyframe every few seconds. Seeking to a frame
# between keyframes forces the browser to decode from the previous keyframe,
# which is what makes scroll-scrubbed video stutter. Encoding EVERY frame as a
# keyframe (-g 1, "all-intra") makes every seek a single-frame decode.
# Cost: files are 3–8× bigger than normal encodes, so keep clips short (≤ 6 s)
# and sized per device.
#
# Outputs (in OUT_DIR, prefixed with NAME):
#   NAME-desktop.mp4   H.264 all-intra, DESKTOP_W wide   (Safari / iOS / everyone)
#   NAME-desktop.webm  VP9   all-intra, DESKTOP_W wide   (Chrome / Firefox, smaller)
#   NAME-mobile.mp4    H.264 all-intra, MOBILE_W wide
#   NAME-mobile.webm   VP9   all-intra, MOBILE_W wide
#   NAME-poster.webp + NAME-poster.jpg   first frame (poster / LCP image / reduced-motion still)
#
# Usage:
#   ./prepare-scrub-video.sh input.mov [OUT_DIR] [NAME]
# Env overrides (defaults in brackets):
#   DESKTOP_W [1920]  MOBILE_W [960]  FPS [30]  CRF_H264 [24]  CRF_VP9 [34]
#   MAX_SECONDS [0 = keep full length]  BUDGET_DESKTOP_KB [6000]  BUDGET_MOBILE_KB [2500]
set -euo pipefail

# ── 1. Arguments and checks ──────────────────────────────────────────────────
IN="${1:-}"
if [[ -z "$IN" || ! -f "$IN" ]]; then
  echo "usage: $0 input-video [out-dir] [name]" >&2; exit 1
fi
OUT_DIR="${2:-./scrub-out}"
NAME="${3:-$(basename "${IN%.*}")}"
DESKTOP_W="${DESKTOP_W:-1920}"
MOBILE_W="${MOBILE_W:-960}"
FPS="${FPS:-30}"
CRF_H264="${CRF_H264:-24}"
CRF_VP9="${CRF_VP9:-34}"
MAX_SECONDS="${MAX_SECONDS:-0}"
BUDGET_DESKTOP_KB="${BUDGET_DESKTOP_KB:-6000}"
BUDGET_MOBILE_KB="${BUDGET_MOBILE_KB:-2500}"

command -v ffmpeg >/dev/null || { echo "ffmpeg not found — install it (brew install ffmpeg / apt install ffmpeg)" >&2; exit 1; }
command -v ffprobe >/dev/null || { echo "ffprobe not found (ships with ffmpeg)" >&2; exit 1; }
mkdir -p "$OUT_DIR"

TRIM=()
if [[ "$MAX_SECONDS" != "0" ]]; then TRIM=(-t "$MAX_SECONDS"); fi

# ── 2. Encoders ──────────────────────────────────────────────────────────────
# -an                no audio (a scrub video never plays sound; saves bytes)
# -g 1 -keyint_min 1 every frame is a keyframe
# -bf 0              no B-frames (also avoids the Safari WebCodecs B-frame ordering bug)
# yuv420p            the only pixel format every browser decodes
# +faststart         moov atom first so metadata arrives before the data
# scale=W:-2         keep aspect, force even height (H.264 requirement)
h264() { # $1 width  $2 output
  ffmpeg -hide_banner -loglevel error -y "${TRIM[@]}" -i "$IN" -an \
    -vf "fps=${FPS},scale=${1}:-2:flags=lanczos" \
    -c:v libx264 -profile:v high -preset slow -crf "$CRF_H264" \
    -g 1 -keyint_min 1 -bf 0 -sc_threshold 0 -pix_fmt yuv420p \
    -movflags +faststart "$2"
}
vp9() { # $1 width  $2 output
  ffmpeg -hide_banner -loglevel error -y "${TRIM[@]}" -i "$IN" -an \
    -vf "fps=${FPS},scale=${1}:-2:flags=lanczos" \
    -c:v libvpx-vp9 -b:v 0 -crf "$CRF_VP9" -row-mt 1 -deadline good -cpu-used 2 \
    -g 1 -keyint_min 1 -pix_fmt yuv420p "$2"
}

echo "→ encoding $IN  (fps=$FPS, desktop=${DESKTOP_W}px, mobile=${MOBILE_W}px)"
h264 "$DESKTOP_W" "$OUT_DIR/$NAME-desktop.mp4"
h264 "$MOBILE_W"  "$OUT_DIR/$NAME-mobile.mp4"
ENCODERS="$(ffmpeg -hide_banner -encoders 2>/dev/null)"   # captured first: `| grep -q` + pipefail = false negative
if [[ "$ENCODERS" == *libvpx-vp9* ]]; then
  vp9 "$DESKTOP_W" "$OUT_DIR/$NAME-desktop.webm"
  vp9 "$MOBILE_W"  "$OUT_DIR/$NAME-mobile.webm"
else
  echo "! libvpx-vp9 not available — skipping WebM (MP4 alone works everywhere)"
fi

# ── 3. Poster (first frame) ──────────────────────────────────────────────────
# Used as <video poster>, as the reduced-motion still and as the LCP image.
ffmpeg -hide_banner -loglevel error -y -i "$IN" -frames:v 1 -vf "scale=${DESKTOP_W}:-2" -q:v 3 "$OUT_DIR/$NAME-poster.jpg"
ffmpeg -hide_banner -loglevel error -y -i "$IN" -frames:v 1 -vf "scale=${DESKTOP_W}:-2" -c:v libwebp -quality 78 "$OUT_DIR/$NAME-poster.webp" 2>/dev/null \
  || echo "! libwebp not available — poster.webp skipped"

# ── 4. Report: size, frames, keyframe check, budget ─────────────────────────
kb() { echo $(( $(wc -c <"$1") / 1024 )); }
echo
printf "%-28s %8s %7s %10s %s\n" FILE KB FRAMES KEYFRAMES BUDGET
for f in "$OUT_DIR/$NAME"-{desktop,mobile}.{mp4,webm}; do
  [[ -f "$f" ]] || continue
  frames=$(ffprobe -v error -select_streams v:0 -count_frames -show_entries stream=nb_read_frames -of csv=p=0 "$f")
  keys=$(ffprobe -v error -select_streams v:0 -skip_frame nokey -count_frames -show_entries stream=nb_read_frames -of csv=p=0 "$f")
  size=$(kb "$f")
  if [[ "$f" == *desktop* ]]; then budget=$BUDGET_DESKTOP_KB; else budget=$BUDGET_MOBILE_KB; fi
  verdict="ok"; (( size > budget )) && verdict="OVER ${budget}KB — shorten clip, lower FPS/width, or raise CRF"
  [[ "$frames" != "$keys" ]] && verdict="$verdict; NOT all-intra!"
  printf "%-28s %8s %7s %10s %s\n" "$(basename "$f")" "$size" "$frames" "$keys" "$verdict"
done
echo
echo "Done → $OUT_DIR"
