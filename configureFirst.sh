#!/bin/bash
set -e

DIR=`pwd`
OSBIT=`uname -m`

function detect_os() {
    if [ -f /etc/arch-release ]
    then
        OS="archlinux"
    elif [ -f /etc/redhat-release ] || [ -f /etc/centos-release ]
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
	sudo apt-get -y install build-essential mono-complete libmono-winforms2.0-cil monodevelop
elif [ ${OS} == "redhat" ]
then
	sudo yum install -y yum-utils gcc-c++
    sudo rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
    sudo yum-config-manager --add-repo http://download.mono-project.com/repo/centos7/
    sudo yum install -y mono-devel
elif [ ${OS} == "archlinux" ]
then
    sudo pacman -S --noconfirm gcc mono
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

# Make sure current user belongs to group owning serial TTY devices
username=`whoami`
if [ ${OS} == "archlinux" ]
then
    TTY_GROUP="uucp"
else
    TTY_GROUP="dialout"
fi
echo "Checking if you are in the ${TTY_GROUP} group."
if grep ${username} /etc/group|grep -c i${TTY_GROUP}; then
  echo "User already in ${TTY_GROUP} group. Adding not required."
else
  echo "Adding user ${username} to the ${TY_GROUP} group."
  if [ "$(id -u)" != "0" ]; then
    # sudo adduser $username ${TTY_GROUP}
    sudo usermod -a -G ${TTY_GROUP} $username
  else
    # adduser $username ${TTY_GROUP}
    usermod -a -G ${TTY_GROUP} $username
  fi
  echo "You need to login again in order to connect to your printer."
fi
echo "Compiling helper software to allow non ansi baud rates for some boards"
echo "depending on the used serial driver."
g++ SetBaudrate.cpp -o SetBaudrate

echo "Configuration finished."
#echo "Make sure, your user has permission to connect to the serial port."
#echo "For debian and clones use:"
#echo "usermod -a -G ${TTY_GROUP} yourUserName"
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
export OS
export DIR
generate_local_configuration.sh
bash ${DIR}/createDesktopIcon.sh
mkdir -p ~/.local/share/RepetierHost/
cp -r eMotionTech/CuraEngine/ ~/.local/share/RepetierHost/
mkdir -p ~/.mono/registry/CurrentUser/software/
cp -r eMotionTech/repetier ~/.mono/registry/CurrentUser/software/
if [ ${OS} == "debian" ]
then
    ./installDependenciesDebian
elif [ ${OS} == "redhat" ]
then
    ./installDependenciesFedora
elif [ ${OS} == "archlinux" ]
then
    ./installDependenciesArchlinux
fi


