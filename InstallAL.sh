CONFIGAL_CURRENT=$( cd $(dirname ${BASH_SOURCE[0]}) ; pwd -P )

source $CONFIGAL_CURRENT/ConfigAL_functions.sh

# Load installation settings
if [[ -e $CONFIGAL_CURRENT/9_private/InstallAL_settings.sh ]]; then
  source $CONFIGAL_CURRENT/9_private/InstallAL_settings.sh
else
  source $CONFIGAL_CURRENT/9_private/InstallAL_settings_template.sh
fi
# Prompt for passwords to be set up
source $CONFIGAL_CURRENT/9_private/InstallAL_passwords_template.sh

source $CONFIGAL_CURRENT/1_linux/install_os/prepare_os_disk.sh
source $CONFIGAL_CURRENT/1_linux/install_os/install_os.sh
