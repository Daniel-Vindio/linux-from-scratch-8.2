#!/bin/bash -e

#Full automation.
#This script is only to face a complete updating of the system, from zero.
#For example, when a new version of gcc, glibc or even the kernel. 


#Abrir consola GUI y ser root
#Open Gui console and be root.

if [ $(id -u) -ne 0 ]
	then 
		echo -e "Ur not root bro"
		echo -e "Tines que ser root, tío"
	exit 1
fi

echo "======================================================="
echo "Did you exec env -i HOME=\$HOME TERM=\$TERM /bin/bash ?"
echo "If you did, type SI to continue"
echo "If not, press any key to exit"
echo "======================================================="
read CS
if [ "$CS" != "SI" ]
	then
		echo "exit"
		exit
fi

#====== STAGE 1 ========================================================
. 0-var-general-rc
. 0-var-inst-temp-sys-rc
. $dirversiones/versiones.sh

#En este caso partimos de la base de que se trabaja en una partición
#específica para LFS
mount -v -t ext4 $lfsdevice $LFS

cd $srcinst1
./1-meta-inst-temp-sys.sh


cd $srcinst2
./2-1-creacion-file-system.sh
./2-2-empiece-mount-filesys.sh

#Ahora hay que llevarse cosas al chroot.
#Some stuff (files of variables and instalators mainly) has to be copied
#within the chroot environment.

mkdir -v $croothome
chmod -v 777 $croothome

mkdir -v $chrootqipkgs
chmod -v 777 $chrootqipkgs

cp -v $srcdir/0-var-chroot-rc $croothome
cp -v $srcinst2/2-4-creacion-directorios.sh $croothome
cp -v $srcinst2/2-5-creacion-config-files.sh $croothome
cp -v $srcinst3/* $croothome
cp -v $dirversiones/versiones.sh $croothome
cp -v $qipkgs32/* $chrootqipkgs

touch $croothome/reg_instal.log
touch $croothome/test.log


#====== STAGE 2 ========================================================
./2-3-1-empiece-chroot.sh

