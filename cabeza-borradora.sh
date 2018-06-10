#!/bin/bash

# Cabeza borradora = literal translation of eraserhead
# Script to delete all the file system.
# It is needed to help to re-install the whole system, for example,
# when updating the system to the new package versions.

control_flujo () {
	echo "ARE YOU POSITIVE? To exit press N"
	read CS
	if [ "$CS" == "N" ]
		then
			echo "exit"
			exit
	fi
}

control_flujo2 () {
	echo "I don't know what 'positive' means. To exit press N"
	echo "It means you're sure. To exit press N"
	read CS
	if [ "$CS" == "N" ]
		then
			echo "exit"
			exit
	fi
}

control_flujo3 () {
	echo "Yes, I'm sure that's Ellis Brittle. To exit press N"
	echo "Directories will be deleted. To exit press N"
	read CS
	if [ "$CS" == "N" ]
		then
			echo "exit"
			exit
	fi
} 


if [ $(id -u) -ne 0 ]; then 
	echo -e "Ur not root bro"
	echo -e "Tines que ser root, tío"
	exit 1
fi

. 0-var-general-rc

mount -v -t ext4 $lfsdevice $LFS

echo -e "\nBORRADO TOTAL DEL SISTEMA DE ARCHIVOS"
echo -e "ERASING THE FILE SYSTEM COMPLETELY\n"
control_flujo
control_flujo2
control_flujo3

cd $LFS
echo -e "\n---> Borrado de carpetas en $LFS excepto sources y tools"
echo -e "\n---> OJO tiene que ser en /mnt/lfs. Si no te caargas el sistema"
ls
control_flujo
rm -rf bin boot dev etc home lib media mnt opt proc root run sbin srv sys tmp usr var

#cd $LFS/tools
#echo -e "\n---> Borrado de carpetas en $PWD"
#ls
#control_flujo
#rm -fr bin include lib man share i686-pc-linux-gnu i686-lfs-linux-gnu etc lib  libexec sbin var

umount $LFS




















