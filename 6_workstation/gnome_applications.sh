echo_section "Installing extra applications for Gnome"

# https://www.archlinux.org/groups/x86_64/gnome-extra/

if [[ "$GNOME_ALL_APPLICATIONS" == "true" ]]; then

  ensure_pkg gnome-extra

else

  GNOME_APPS=
  GNOME_APPS="$GNOME_APPS gedit"                      # A text editor for GNOME 	2016-10-12
  GNOME_APPS="$GNOME_APPS gedit-code-assistance"      # Code assistance for gedit 	2016-11-12
  GNOME_APPS="$GNOME_APPS gitg"                       # A GIT repository viewer based on GTK+ 	2016-10-12

  ensure_pkg $GNOME_APPS

fi
