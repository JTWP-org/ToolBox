#!/bin/bash
serverS=( $(ls -d  ~/*/Pavlov) )
set -u
clear 
echo "WARNING script only works on servers installed in the home dir of the user running the script "
echo "you need to pass this script the server type to install with an argument if left empty script will close"
echo
echo "your options are \"PC\" \"PC-BETA\" \"SHACK\" \"SHACK-RC\""

echo "----------------------"

type=$(echo $1)



echo 
echo "ubuntu version  $(lsb_release -a | grep Release | awk '{print $2}')"
version=$(lsb_release -a | grep Release | awk '{print $2}')

if [ $version == 23.04 ]
then
sudo apt update && sudo apt install -y gdb curl lib32gcc1 libc++-dev unzip
sudo useradd -m steam 
else
sudo apt update && sudo apt install -y gdb curl lib32gcc-s1 libc++-dev unzip
sudo useradd -m steam
fi



bash /Steam/steamcmd.sh +login anonymous +app_update 1007 +quit
mkdir -p ~/.steam/sdk64
cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/steamclient.so

echo "${#serverS[@]} Servers Detected "
for i in "${serverS[@]}"
do

    name=$(cat ${i}/Saved/Config/LinuxServer/Game.ini | grep ServerName | awk -F '=' '{print $2}' )
    echo "------------------SERVER INFO"
    echo "$(echo $i | awk -F "/" '{print $4}')"
    echo $name
    echo "-----------------------------"
    echo
    echo "installing update now "
    sleep 1
    case $type in

    PC|pc)
        install="/home/steam/Steam/steamcmd.sh +force_install_dir /home/steam/${i} +login anonymous +app_update 622970 +exit  "
        ;;

    BETA|beta)
        install="/home/steam/Steam/steamcmd.sh +force_install_dir /home/steam/${i} +login anonymous +app_update 622970 -beta beta_server +exit "
        ;;

    SHACK|shack)
        install="/home/steam/Steam/steamcmd.sh +force_install_dir /home/steam/${i} +login anonymous +app_update 622970 -beta shack +exit"
        ;;

    RC|rc)
        install="/home/steam/Steam/steamcmd.sh +force_install_dir /home/steam/${i} +login anonymous +app_update 622970 -beta shack_beta +exit "
        ;;


esac
    $install

    cp /home/steam/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so "~${i}/Pavlov/Binaries/Linux/steamclient.so"
    echo "END SERVER UPDATE FOR ${name}"
    echo
    echo
    echo
    echo
    echo
done
 






