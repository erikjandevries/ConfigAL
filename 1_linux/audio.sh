# http://jaysdesktop.blogspot.nl/2011/10/enabling-hdmi-audio-out-in-ubuntu-1004.html
# https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture

if [[ "x$AUDIO_DEVICE" == "x" ]]; then
  echo ""
else
  echo_section "Enabling audio device"

  # speaker-test -c 2 -D $AUDIO_DEVICE
  ensure_conf "load-module module-alsa-sink device=$AUDIO_DEVICE" /etc/pulse/default.pa
fi
