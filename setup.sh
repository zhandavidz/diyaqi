#!/bin/bash
# copyleft me (Elam) 2021; keep the software free, baby
if [ "$(id -u)" != "0" ]; then
echo "You must be the superuser to run this script :( try adding \"sudo\" at the begining of your command and rerun" >&2
exit 1
fi
i2cDeviceExists() {
	devs=$(i2cdetect -y 1 | sed 1d | sed 's/^....//' | sed 's/--//g')
	# if [ -n "${devs// }" ]; then
	case $devs in
		(*[![:blank:]]*) return "$(echo "$devs" | xargs echo)";;
		(*) return 0
	esac
}
pulldeps(){
	apt-get update

	# python, for obvious reasons
	apt-get install -y python3 python3-pip || exit 1
	pip3 install --upgrade setuptools

	# cURL to test website

	apt-get install -y curl

	# i2ctools to detect device
	apt-get install -y i2ctools

	# BME / boardio deps

	pip3 install RPI.GPIO || exit 1
	pip3 install adafruit-blinka
	pip3 install adafruit-circuitpython-bme280
}
sensorTest(){
	v="$(python sensorTest.py)"
	if $v; then
		exit 1
	fi
}
hostTest(){
	resp=$(curl -o /dev/null -i -L -s -w "%{http_code}\n" "$host/test")
	if [ "$resp" == 200 ]; then
		return 0
	else
		return 1
	fi
}


echo "Welcome to the PiAQI autoinstallation script! Pulling dependancies..."

pulldeps || error "dependancy pull failed!"

read -r -p "dependancies pulled! Please hook up your BME280 sensor and press enter to continue"

echo "attempting to detect i2c devicew.."

if ! i2cDeviceExists; then
	echo "Device found! Proceeding"
else
	error "Device not found :( please check your wiring and rerun this script"
fi

echo "testing the sensor..."

sensorTest || error "sensor test failed!"

flag=1
while ! [ $flag -eq 0 ]; do
	echo "Please enter the url provided by the organizer ex. https://albanylovestheair.com"
	read -r host
	echo "you entered $host is this correct? [Y/n]"
	read -r flag
	if ! [ "$flag" == "n" ]; then
		flag=1
	fi
	if [ $flag -eq 1 ]; then
		echo "testing host..."
		if [ "$(hostTest)" -eq 0 ]; then
			echo "host is up!"
			flag=0
		else
			echo "host is not up :( retry? [y/N]"
			read -r flag
			if ! [ "$flag" == "y" ]; then
				flag=0
			else
				echo "exiting..."
				exit 1
			fi
		fi
	fi
done

echo
