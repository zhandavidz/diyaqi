#!/usr/bin/python
"""Periodically send bme280 data via POST request to a designated host"""
import sys
import time
import board
import requests
from busio import I2C
import adafruit_bme280
# Create library object using our Bus I2C port

host = sys.argv[1]
name = sys.argv[2]


# change this to match the location's pressure (hPa) at sea level
bme280.sea_level_pressure = 1013.25

while True:
    try:
        print(requests.post(host, data={'id':1, "name":name, "temp":bme280.temperature, "humidity":bme280.humidity, "pressure":bme280.pressure, "altitude":bme280.altitude}))
    except:
        print('frick')
    time.sleep(30)
