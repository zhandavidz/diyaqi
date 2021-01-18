#!/bin/bash
# copyleft me (Elam) 2021; keep the software free, baby
if [ "$(id -u)" != "0" ]; then
echo "You must be the superuser to run this script :( try adding \"sudo\" at the begining of your command and rerun" >&2
exit 1
fi

deviceExists() {
	devs=$(i2cdetect -y 1 | sed 1d | sed 's/^....//' | sed 's/--//g')
	# if [ -n "${devs// }" ]; then
	case $devs in
		(*[![:blank:]]*) echo "$devs" | xargs echo;;
		(*) echo 0
	esac


}
deviceExists
