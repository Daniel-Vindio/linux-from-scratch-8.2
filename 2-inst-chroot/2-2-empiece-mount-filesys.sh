#!/bin/bash

echo -e "
############################################################\n\
#$0\n\
############################################################\n"

if [ $(id -u) -ne 0 ]
	then 
		echo -e "Ur not root bro"
		echo -e "Tines que ser root, tío"
	exit 1
fi

if [ ! -d "${LFS}/dev" ]; then
	echo "Revise el sistema !!!!"
	echo "${LFS}/dev proc, sys y run deberían existir "
fi


#LFS 8.2
#6.2.2. Mounting and Populating /dev 
#Solo montaje, la creación está en el archivo 0
mount -v --bind /dev ${LFS}/dev

mount -vt devpts devpts ${LFS}/dev/pts -o gid=5,mode=620
mount -vt proc proc ${LFS}/proc
mount -vt tmpfs tmpfs ${LFS}/run
mount -vt sysfs sysfs ${LFS}/sys

if [ -h ${LFS}/dev/shm ]; then
  mkdir -pv ${LFS}/$(readlink ${LFS}/dev/shm)
fi
