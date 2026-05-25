#!/bin/sh
# installs required packages on Ubuntu/Debian to compile fhDOOMEx.
# most packages will install additional dependencies that are also required but are not explicitly listed here.

echo "installing build essentials..."
sudo apt install build-essential

echo "installing basic stuff..."
sudo apt install git cmake ninja

echo "installing dev packages..."
sudo apt install freeglut3-dev libalut-dev libasound2-dev libopenal-dev libcurl4-dev

MACHINE_TYPE=`uname -m`
echo "machine type:"${MACHINE_TYPE}
if [ "$MACHINE_TYPE" = "x86_64" ]; then
	echo "installing 32bit libraries..."
	sudo apt install build-essential:i386 freeglut3-dev:i386 libalut-dev:i386 libasound2-dev:i386 libopenal-dev:i386 libcurl4-dev:i386
fi