echo_section "Installing X.Org X Window System"

ensure_pkg xorg-server xorg-server-utils xorg-xinit xorg-utils

if [[ $XORG_ADD_SCREEN_RESOLUTION == "true" ]]; then
  MODELINE="$(cvt $XORG_SCREEN_RESOLUTION_WIDTH $XORG_SCREEN_RESOLUTION_HEIGHT | grep Modeline)"
  MODELINE_NAME="$(cvt $XORG_SCREEN_RESOLUTION_WIDTH $XORG_SCREEN_RESOLUTION_HEIGHT | grep Modeline | awk -F'"' '{print $3}')"
  MODELINE_CONTENT="$(cvt $XORG_SCREEN_RESOLUTION_WIDTH $XORG_SCREEN_RESOLUTION_HEIGHT | grep Modeline | awk -F'Modeline ' '{print $2}')"
  MONITOR_NAME="$(xrandr | grep "connected primary" | awk -F' ' '{print $1}')"

  sudo tee /etc/X11/xorg.conf.d/10-monitor.conf << EOF > /dev/null
Section "Monitor"
    Identifier "$MONITOR_NAME"
    $MODELINE
    Option "PreferredMode" "$MODELINE_NAME"
EndSection

Section "Screen"
    Identifier "Screen0"
    Monitor "$MONITOR_NAME"
    DefaultDepth 24
    SubSection "Display"
        Modes "$MODELINE_NAME"
    EndSubSection
EndSection

Section "Device"
    Identifier "Device0"
    Driver "$XORG_SCREEN_RESOLUTION_DRIVER"
EndSection
EOF
fi

if [[ $XORG_SET_SCREEN_RESOLUTION == "true" ]]; then
  MODELINE="$(cvt $XORG_SCREEN_RESOLUTION_WIDTH $XORG_SCREEN_RESOLUTION_HEIGHT | grep Modeline)"
  MODELINE_NAME="$(cvt $XORG_SCREEN_RESOLUTION_WIDTH $XORG_SCREEN_RESOLUTION_HEIGHT | grep Modeline | awk -F'"' '{print $2}')"
  MODELINE_CONTENT="$(cvt $XORG_SCREEN_RESOLUTION_WIDTH $XORG_SCREEN_RESOLUTION_HEIGHT | grep Modeline | awk -F'"' '{print $3}')"
  MONITOR_NAME="$(xrandr | grep "connected primary" | awk -F' ' '{print $1}')"

  xrandr --newmode "$MODELINE_NAME" $MODELINE_CONTENT
  xrandr --addmode $MONITOR_NAME $MODELINE_NAME
  xrandr --output $MONITOR_NAME --mode $MODELINE_NAME
fi
