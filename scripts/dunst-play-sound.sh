#!/usr/bin/env bash
if command -v pw-play &>/dev/null; then
  exec pw-play ~/.configs/nixos-merged/notification.mp3
else
  exec ${pkgs.alsa-utils}/bin/aplay ~/.configs/nixos-merged/notification.mp3
fi
