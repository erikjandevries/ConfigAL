CONFIGAL_CURRENT=$( cd $(dirname ${BASH_SOURCE[0]}) ; pwd -P )

source ${CONFIGAL_CURRENT}/ConfigAL_functions.sh


# Load installation settings
if [[ -e ${CONFIGAL_CURRENT}/9_private/InstallAL_settings.sh ]]; then
  source ${CONFIGAL_CURRENT}/9_private/InstallAL_settings.sh
else
  source ${CONFIGAL_CURRENT}/9_private/InstallAL_settings_template.sh
fi

prompt_sudopw

ensure_dir 9_private
ConfigAL_start() {
  # Requires
  # $1: subfolder
  # $2: script file name

  # Run the initialisation script
  if [[ -e ${CONFIGAL_CURRENT}/9_private/$1/$2_init.sh ]]; then
    source ${CONFIGAL_CURRENT}/9_private/$1/$2_init.sh
  else
    if [[ -e ${CONFIGAL_CURRENT}/9_private/$1/$2_init_template.sh ]]; then
      source ${CONFIGAL_CURRENT}/9_private/$1/$2_init_template.sh
    fi
  fi

  # Run the main script
  if [[ -e ${CONFIGAL_CURRENT}/$1/$2.sh ]]; then
    source ${CONFIGAL_CURRENT}/$1/$2.sh
  fi

  # Run the finalisation script
  if [[ -e ${CONFIGAL_CURRENT}/9_private/$1/$2_finalise.sh ]]; then
    source ${CONFIGAL_CURRENT}/9_private/$1/$2_finalise.sh
  else
    if [[ -e ${CONFIGAL_CURRENT}/9_private/$1/$2_finalise_template.sh ]]; then
      source ${CONFIGAL_CURRENT}/9_private/$1/$2_finalise_template.sh
    fi
  fi
}

# Load Settings
ConfigAL_start 9_private ConfigAL_settings

# Start installation and configuration

echo_section "Adding ConfigAL common functions to .bashrc"
ensure_dir ~/.bash_functions
cp ${CONFIGAL_CURRENT}/ConfigAL_functions.sh ~/.bash_functions/
ensure_conf 'source ~/.bash_functions/ConfigAL_functions.sh' ~/.bashrc

ConfigAL_start 1_linux network
ConfigAL_start 1_linux video_drivers
ConfigAL_start 1_linux audio
ConfigAL_start 1_linux fonts

ConfigAL_start 1_linux git
ConfigAL_start 1_linux rsync
ConfigAL_start 1_linux screen

ConfigAL_start 2_www openssh
ConfigAL_start 2_www nginx
ConfigAL_start 2_www apache

ConfigAL_start 3_db mariadb
# ConfigAL_start 3_db postgresql

ConfigAL_start 4_php php
# ConfigAL_start 4_php phpadmin

# ConfigAL_start 5_server qemu
ConfigAL_start 5_server/nextcloud nextcloud
# ConfigAL_start 5_server/vlc vlc

ConfigAL_start 6_workstation xorg
ConfigAL_start 6_workstation sddm
ConfigAL_start 6_workstation kde_plasma
ConfigAL_start 6_workstation kde_applications
# # ConfigAL_start 6_workstation mdm
# ConfigAL_start 6_workstation cinnamon
# ConfigAL_start 6_workstation gnome
# ConfigAL_start 6_workstation gnome_applications

ConfigAL_start 6_workstation firefox
ConfigAL_start 6_workstation vlc

ConfigAL_start 7_machine_learning atom

ConfigAL_start 7_machine_learning openblas-lapack
# ConfigAL_start 7_machine_learning mkl

ConfigAL_start 7_machine_learning r
ConfigAL_start 7_machine_learning rstudio
ConfigAL_start 7_machine_learning rshiny

# ConfigAL_start 7_machine_learning mxnet
# ConfigAL_start 7_machine_learning mxnet-r
# ConfigAL_start 7_machine_learning python27

ConfigAL_start 7_machine_learning python

ConfigAL_start 9_private private

forget_sudopw
