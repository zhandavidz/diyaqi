# Elam's Air Quality RasPi Based Sensor Deployment Protocol!

## Welcome!

Below are the steps to set up your very own Raspberry-Pi based air quality monitoring station

## Table of Contents

**[Components list](#components)**

**[Burning an OS Image](#burning-a-raspberry-pi-os-image)**

**[Pre-Boot Configureatiuon](#headless-config)**

**[First Boot!](#first-boot)**

**[SSHing in](#sshing-in)**

**[Next Steps](#once-youre-in)**


## Components

 Make sure you have all of your components; This includes

	- Raspberry pi Zero W*
	- BME280 Sensor with headers
	- 4 female to female jumper wires
	- a micro USB cable to power your pi
	- a micro SD card (at least 16GB in size)
	- Some way to interface with your microsd card (adapter, port, etc)
	- A computer running Windows, OS X (macOS), or linux)**

*no reason other versions shouldn't work if they have wifi (or are connected to ethernet), but untested

**if you use BSD you probably don't need to be reading this, but welcome! use dd or something lol


## Burning a Raspberry Pi OS Image

Let's get to work!

1. Download the latest Raspberry Pi OS (formerly Raspian) image from https://www.raspberrypi.org/software/operating-systems/
	- Note! This tutorial only requires the "Lite" verison, but feel free to download either the "with desktop" or "with desktop and recommended software" versions if you perfer, those will work too!
2. Download and install BalenaEtcher from https://www.balena.io/etcher/ for whatever operating system you are on
3. Plug in your MicroSD card
**Warning: the next steps will wipe all current data on your MicroSD Card**
4. Open BalenaEtcher, select your MicroSD card (make sure you aren't accidentally burning the image to a random flash drive that's plugged in!) and the Raspberry Pi OS image, click "Flash!" and wait for Etcher to do its thing (flashing and verifying your flash)
5. Once BalenaEtcher finishes, you should have a bootable version of Raspberry Pi OS! Just a few more things to do before we put that card in the Pi

## Headless Config

We will be setting up the pi "headless", which means we won't need to connect anything to it besides power to use it

This requires us to do some manual setup on the pi before we boot it up for the first time, but don't worry! Just follow the instructions carefully and you should be good to go!

Firstly, we need to enable ssh (secure shell) on the pi
	- secure shell is a method by which a computer can remotley access another computer

### Enabling secure shell access (ssh)
When you burned your Raspberry pi OS image, there should have been two 'partitions' created on your SD card. They will appear, on most operating systems, as two individual devices. We need to access the "boot" partition, which is the first partition and is also the smaller one.

Once you get into the boot partition, make a file called "ssh" with no extension and save it. The text inside it doesn't matter, so you can put anything you want in there (or nothing, it doesn't matter)

**SSH will now be enabled on first boot!**

### Automatically connecting to WiFi

To automatically connect to wifi, we need to change a file called "wpa_supplicant.conf"; This file manages your Raspberry Pi automatically connecting to wifi on boot

Luckily, all we need to do is put our wpa supplicant in the boot folder and Rasberry Pi OS will locate it correctly for us! Isn't that nice? Let's do that real quick.

1. Create a file in the same boot folder we just put that 'ssh' file in, call it "wpa_supplicant.conf"
2. In that file put the following text, replacing <SSID> with your wifi network name, and <PASS> with that network's password (keeping the quotes around them)
	- If you live outside of the US, swap "US" for whatever ISO 2 letter code your country has

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=<US>

network={
 ssid="<SSID>"
 psk="<PASS>"
}
```

**Your device is now ready for its first boot!**

## First boot!

The pi will take a little while to get itself going, go grab a coffee and give it 5-10 minutes to initalize.

Once you feel like it has had enough time to set up, let's get into it!

## SSHing in
For MacOS or linux, you will aready have ssh installed. For windows, you MAY have ssh installed; try the steps below, and if you get an "ssh is not recognized as an internal or external command" kind of thing, follow the instructions for "ssh (PuTTY)" below

open your terminal and type in the following command and press enter

```shell
ssh pi@raspberrypi
```

You should be greeted with

```
pi@raspberrypi's password:
```

The default password is "raspberry" (when you type, nothing will show up. This is normal! Just type "raspberry" and press enter)


### SSHing in (PuTTY)

install [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html), a simple ssh client for windows

1. open PuTTY

2. enter "raspberrypi" as the hostname, leave the port at 22 and press "Open"
3. enter "pi" to "Login As:"
4. Enter "raspberry" to "pi@raspberrypi's password:"

## Once you're in
Once you enter the password and press enter, a few lines looking similar to those below will appear (if you got the password right)

```
Linux raspberrypi 4.19.118-v7l+ #1311 SMP Mon Apr 27 14:26:42 BST 2020 armv7l
The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.
Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Fri Jun 26 10:21:38 2020 from 192.168.43.138
pi@raspberrypi:~ $
```

The version number and time will be different, but the important part is that you get that "pi@raspberrypi:~$". That means you're in (you have a shell, or command line access on/to the pi)!

(*If you want, you can change the default password of "raspberry" by typing "passwd" in the shell prompt, pressing enter, and following the password change prompts*)

We now need to set up the sensor, and get it reporting. You're doing great!

We now need to set up the sensor, configure where we're sending the data, and configure the data-sending script to start every time we turn on our pi. Sounds like a lot, doesn't it? Luckily, most of the process is automated (thanks, scripting!).
All you need to do is run the following command while you're at the "pi@raspberrypi:~ $" prompt"

```
git clone https://github.com/T3chy/diyaqi && cd diyaqi && sudo ./setup.sh
```

**Note: you may be asked for your password after running this command; simple enter 'raspberry' (without the quotes) or the new password you previosly set and press enter.**

Follow the prompts in the script, and you should be good to go! Congratulations!!


## Troubleshooting

WIP
