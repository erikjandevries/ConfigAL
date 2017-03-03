echo "Checking network connection"

## This file is a bit of a hack to help keep WIFI connections alive.
##
## To run it every 15 minutes, add a line to your crontab:
## crontab -e
## */15 * * * * /path/to/restart_systemd-networkd.sh
##
## You should change the TEST_IP to the ip-address of your (WIFI) router,
## to make sure you test your network connection
## instead of your internet connection

TEST_IP=8.8.8.8
TEST_LOG_FILE=~/logs/networkconnection.log
TEST_LOG_FILE_LAST_SUCCESS=~/logs/networkconnection_lastsuccess.log

log_line() {
  # Requires
  # $1: log line
  # $2: log file
  echo "$(date -u +"%Y-%m-%d %T.%N %Z") $1" >> $2
}

TEST_LOSS=$(ping -c 4 $TEST_IP | grep "100% packet loss")

if [ "x$TEST_LOSS" == "x" ]; then
  echo "Network connection to $TEST_IP is working"

  echo "$(date -u +"%Y-%m-%d %T.%N %Z") Network connection to $TEST_IP is working" > $TEST_LOG_FILE_LAST_SUCCESS
else
  echo "Cannot reach $TEST_IP"

  touch $TEST_LOG_FILE
  log_line "Cannot reach $TEST_IP" $TEST_LOG_FILE
  log_line "Restarting systemd-networkd..." $TEST_LOG_FILE
  systemctl restart systemd-networkd
  log_line "systemd-networkd restarted." $TEST_LOG_FILE
fi
