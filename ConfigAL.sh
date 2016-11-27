source ConfigAL_functions.sh
CONFIGAL_CURRENT=$(pwd)

# Load installation settings
if [[ -e 9_private/InstallAL_settings.sh ]]; then
  source 9_private/InstallAL_settings.sh
else
  source 9_private/InstallAL_settings_template.sh
fi

prompt_sudopw

ensure_dir 9_private_config
ConfigAL_start() {
  # Requires
  # $1: subfolder
  # $2: script file name

  # Run the initialisation script
  if [[ -e $CONFIGAL_CURRENT/9_private_config/$1/$2_init.sh ]]; then
    source $CONFIGAL_CURRENT/9_private_config/$1/$2_init.sh
  else
    if [[ -e $CONFIGAL_CURRENT/9_private_config/$1/$2_init_template.sh ]]; then
      source $CONFIGAL_CURRENT/9_private_config/$1/$2_init_template.sh
    fi
  fi

  # Run the main script
  if [[ -e $CONFIGAL_CURRENT/$1/$2.sh ]]; then
    source $CONFIGAL_CURRENT/$1/$2.sh
  fi

  # Run the finalisation script
  if [[ -e $CONFIGAL_CURRENT/9_private_config/$1/$2_finalise.sh ]]; then
    source $CONFIGAL_CURRENT/9_private_config/$1/$2_finalise.sh
  else
    if [[ -e $CONFIGAL_CURRENT/9_private_config/$1/$2_finalise_template.sh ]]; then
      source $CONFIGAL_CURRENT/9_private_config/$1/$2_finalise_template.sh
    fi
  fi
}

# Load Settings
ConfigAL_start 9_private ConfigAL_settings

# Start installation and configuration

ConfigAL_start 1_linux video_drivers
ConfigAL_start 1_linux xorg

ConfigAL_start 1_linux sddm
# ConfigAL_start 1_linux mdm

ConfigAL_start 1_linux cinnamon
ConfigAL_start 1_linux gnome
ConfigAL_start 1_linux gnome_applications
ConfigAL_start 1_linux kde_plasma
ConfigAL_start 1_linux kde_applications

ConfigAL_start 1_linux git
ConfigAL_start 1_linux rsync

ConfigAL_start 2_www firefox
ConfigAL_start 2_www open
ConfigAL_start 2_www nginx
ConfigAL_start 2_www apache

ConfigAL_start 3_db mariadb
ConfigAL_start 3_db postgresql

ConfigAL_start 4_php php
# ConfigAL_start 4_php phpadmin

ConfigAL_start 5_vmhost qemu

ConfigAL_start 6_machine_learning atom
ConfigAL_start 6_machine_learning rstudio
ConfigAL_start 6_machine_learning mxnet
ConfigAL_start 6_machine_learning mxnet-r
ConfigAL_start 6_machine_learning python27

ConfigAL_start 9_private private

forget_sudopw
