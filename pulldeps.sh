#!/bin/bash
# copyleft me (Elam); keep the software free, baby

if [ "$(id -u)" != "0" ]; then
echo "You must be the superuser to run this script :( try adding \"sudo\" at the begining of your command and rerun" >&2
exit 1
fi
apt-get update

# python, for obvious reasons
apt-get install python3 python3-pip


# BME / boardio deps

pip3 install RPI.GPIO
pip3 install adafruit-blinka
pip3 install adafruit-circuitpython-bme280
