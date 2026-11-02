#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}/.config/easyeffects/db"

echo "==> Stopping EasyEffects..."
easyeffects -q || true
sleep 1

mkdir -p "${TARGET_DIR}"

echo "==> Installing EasyEffects KConfig db files to ${TARGET_DIR}..."
cp -v "${SCRIPT_DIR}/db/"* "${TARGET_DIR}/"

# Detect ThinkPad Speaker sink if name differs slightly
SPEAKER_SINK="$(pactl list sinks short 2>/dev/null | awk '/Speaker__sink/ {print $2; exit}' || true)"
if [[ -n "${SPEAKER_SINK}" ]]; then
    sed -i "s|^outputDevice=.*|outputDevice=${SPEAKER_SINK}|" "${TARGET_DIR}/easyeffectsrc"
fi

echo "==> Starting EasyEffects service..."
nohup easyeffects --service-mode >/dev/null 2>&1 &
sleep 2
easyeffects -b 2 || true

if [[ -n "${SPEAKER_SINK}" ]]; then
    pactl set-default-sink "${SPEAKER_SINK}" || true
fi
pactl set-sink-volume easyeffects_sink 100% 2>/dev/null || true

echo "==> Done! All 6 stages (Bass Enhancer, Equalizer, Exciter, Stereo Tools, Loudness, Maximizer) are active."
