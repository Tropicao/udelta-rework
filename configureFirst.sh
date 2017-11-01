#!/bin/bash
set -e

DIR=`pwd`
OSBIT=`uname -m`

function detect_os() {
    if [ -f /etc/arch-release ]
    then
        OS="archlinux"
    elif [ -r /etc/rc.d/init/dfunctions ]
    then
        OS="redhat"
    elif [ -f /etc/debian_version ]
    then
        OS="debian"
    else
        echo "Unssuported system. Please use this software on Debian, RedHat or Archlinux based system"
        exit 1
    fi
    echo "System : ${OS}"
}


echo "System: ${OSBIT}"

if [ ${OSBIT} = "i686" ]; then
  echo "Using 32 bit CuraEngine"
	cp plugins/CuraEngine/CuraEngine32 plugins/CuraEngine/CuraEngine
else
  echo "Using 64 bit CuraEngine"
	cp plugins/CuraEngine/CuraEngine64 plugins/CuraEngine/CuraEngine
fi
chmod a+x plugins/CuraEngine/CuraEngine

detect_os

echo "Installing mandatory packages"
if [ ${OS} == "debian" ]
then
	sudo apt-get install build-essential mono-complete libmono-winforms2.0-cil monodevelop
elif [ ${OS} == "redhat" ]
then
	sudo yum install -y gcc-c++
	sudo yum install -y monodevelop
elif [ ${OS} == "archlinux" ]
then
    pacman -S --noconfirm gcc mono
fi

echo "#!/bin/sh" > repetierHost
echo "cd ${DIR}" >> repetierHost
echo "mono RepetierHost.exe -home ${DIR}&" >> repetierHost
sudo chmod 755 repetierHost
sudo chmod a+rx ../RepetierHost
sudo chmod -R a+r *
sudo chmod -R a+x data
sudo chmod a+x installDep*
if [ -f /usr/bin/repetierHost ]
then
    sudo rm /usr/bin/repetierHost
fi
sudo ln -s ${DIR}/repetierHost /usr/bin/repetierHost
# Make sure current user h	as dialout group access
username=`whoami`
echo "Checking if you are in the dialout group."
if grep ${username} /etc/group|grep -c dialout; then
  echo "User already in dialout group. Adding not required."
else
  echo "Adding user ${username} to the dialout group."
  if [ "$(id -u)" != "0" ]; then
    # sudo adduser $username dialout
    sudo usermod -a -G dialout $username
  else
    # adduser $username dialout
    usermod -a -G dialout $username
  fi
  echo "You need to login again in order to connect to your printer."
fi
echo "Compiling helper software to allow non ansi baud rates for some boards"
echo "depending on the used serial driver."
g++ SetBaudrate.cpp -o SetBaudrate

echo "Configuration finished."
#echo "Make sure, your user has permission to connect to the serial port."
#echo "For debian and clones use:"
#echo "usermod -a -G dialout yourUserName"
echo "IMPORTANT: In addition to the bundled CuraEngine, the host also"
echo "supports Slic3r and Skeinforge. These slicers are not bundled, so"
echo "need to install them according to their docs and then set the path"
echo "to them in Repetier-Host."
echo "For Slic3r simply unpack the tar you get on http://slic3r.org in this directory."
echo "The host will then register and add it automatically on next restart."
echo ""
echo "IMPORTANT: You need a recent mono version since the host uses .NET 4.0"
echo "If you see the following error message, your mono is too old!"
echo ">>> System.Windows.Forms.SplitContainer doesn't implement interface System.ComponentModel.ISupportInitialize <<<"
bash ${DIR}/createDesktopIcon.sh
mkdir -p /.local/share/RepetierHost/
cp -r eMotionTech/CuraEngine/ ~/.local/share/RepetierHost/
mkdir -p ~/.mono/registry/CurrentUser/software/
cp -r eMotionTech/repetier ~/.mono/registry/CurrentUser/software/
chmod a+x installDependenciesDebian
./installDependenciesDebian


