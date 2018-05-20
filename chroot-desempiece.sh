#!/bin/bash

echo -e "
############################################################\n\
#$?\n\
############################################################\n"

if [ $(id -u) -ne 0 ]
	then 
		echo -e "Ur not root bro"
		echo -e "Tines que ser root, tío"
	exit 1
fi

. 0-var-general-rc

umount ${LFS}/dev/pts

if [ -h ${LFS}/dev/shm ]; then
  link=$(readlink ${LFS}/dev/shm)
  umount -v ${LFS}/$link
  unset link
else
  umount -v ${LFS}/dev/shm
fi

umount ${LFS}/dev
umount ${LFS}/proc
umount ${LFS}/sys
umount ${LFS}/run
