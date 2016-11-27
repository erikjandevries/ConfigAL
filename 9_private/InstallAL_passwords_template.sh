# Prompt for passwords
# Do not store passwords unencrypted in script files!!

prompt_passwd "Arch Linux" "root"
OS_ROOT_PASSWD=$PROMPT_PASSWD
prompt_passwd "Arch Linux" $OS_NEW_USERNAME
OS_NEW_USERNAME_PASSWD=$PROMPT_PASSWD

PROMPT_PASSWD=
