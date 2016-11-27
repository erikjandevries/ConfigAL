source ConfigAL_functions.sh
CONFIGAL_CURRENT=$(pwd)

# Load installation settings
if [[ -e 9_private/InstallAL_settings.sh ]]; then
  source 9_private/InstallAL_settings.sh
else
  source 9_private/InstallAL_settings_template.sh
fi
# Prompt for passwords to be set up
source 9_private/InstallAL_passwords_template.sh

source 1_linux/install_os/prepare_os_disk.sh
source 1_linux/install_os/install_os.sh
