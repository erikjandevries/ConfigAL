source ConfigAL_functions.sh
source ConfigAL_settings.sh

prompt_sudopw

source 1_linux/xorg.sh
source 1_linux/video_drivers.sh

source 1_linux/cinnamon.sh
source 1_linux/gnome.sh
source 1_linux/gnome_applications.sh
source 1_linux/kde_plasma.sh
source 1_linux/kde_applications.sh

source 1_linux/sddm.sh
# source 1_linux/mdm.sh

source 1_linux/git.sh

source 2_www/firefox.sh
source 2_www/openssh.sh

source 6_machine_learning/atom.sh

forget_sudopw=
