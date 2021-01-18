#!/usr/bin/python3
"""Periodically send bme280 data via POST request to a designated host"""
import sys
import time
import board
import requests
from busio import I2C
import adafruit_bme280
# Create library object using our Bus I2C port
try:
    config = open("config", "r")
    host = config.readline()
    name = config.readline()
except Exception as e:
    print(e)
i2c = I2C(board.SCL, board.SDA)
bme280 = adafruit_bme280.Adafruit_BME280_I2C(i2c)


# change this to match the location's pressure (hPa) at sea level
bme280.sea_level_pressure = 1013.25
if len(sys.argv) == 2:
    try:
        print(requests.post(host, data={'id':1, "name":name, "temp":bme280.temperature, "humidity":bme280.humidity, "pressure":bme280.pressure, "altitude":bme280.altitude}))
    except Exception as e:
        print(e)


while True:
    try:
        print(requests.post(host, data={'id':1, "name":name, "temp":bme280.temperature, "humidity":bme280.humidity, "pressure":bme280.pressure, "altitude":bme280.altitude}))
    except Exception as e:
        print(e)
    time.sleep(60)
