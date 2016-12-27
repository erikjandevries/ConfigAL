echo_section "Installing extra applications for KDE"

# https://www.archlinux.org/groups/x86_64/kde-applications/

if [[ "$KDE_ALL_APPLICATIONS" == "true" ]]; then

  ensure_pkg kde-applications

else

  KDE_APPS=
  KDE_APPS="$KDE_APPS dolphin"                            # File Manager
  KDE_APPS="$KDE_APPS dolphin-plugins"                    # Extra Dolphin plugins
  KDE_APPS="$KDE_APPS gwenview"                           # A fast and easy to use image viewer for KDE
  KDE_APPS="$KDE_APPS kate"                               # Advanced Text Editor
  KDE_APPS="$KDE_APPS kcalc"                              # Scientific Calculator
  KDE_APPS="$KDE_APPS kcharselect"                        # Character Selector
  KDE_APPS="$KDE_APPS kcolorchooser"                      # Color Chooser
  KDE_APPS="$KDE_APPS kcron"                              # Configure and schedule tasks
  KDE_APPS="$KDE_APPS kfind"                              # Find Files/Folders
  KDE_APPS="$KDE_APPS konsole"                            # Terminal

  ensure_pkg $KDE_APPS

fi
