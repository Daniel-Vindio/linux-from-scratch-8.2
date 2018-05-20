#!/bin/bash -e

echo -e "
############################################################\n\
#$0\n\
############################################################\n"

#LFS 8.2
#6.2. Preparing Virtual Kernel File Systems 

control_flujo () {
	echo "Continue? To exit press N"
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

echo "LFS = $LFS"

#8.2. Preparing Virtual Kernel File Systems
echo "8.2. Preparing Virtual Kernel File Systems"
if [ ! -d "${LFS}/dev" ]; then
	mkdir -pv ${LFS}/{dev,proc,sys,run}
fi
#control_flujo

# Creating Initial Device Nodes
if [ ! -c "${LFS}/dev/console" ]; then
	mknod -m 600 ${LFS}/dev/console c 5 1
	echo "Creado ${LFS}/dev/console "
fi

if [ ! -c "${LFS}/dev/null" ]; then
	mknod -m 666 ${LFS}/dev/null c 1 3
	echo "Creado ${LFS}/dev/null"
fi

