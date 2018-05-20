#!/tools/bin/bash -e

echo -e "
############################################################\n\
#$0\n\
############################################################\n"

cd /home

. 0-var-chroot-rc
. versiones.sh

./2-4-creacion-directorios.sh
./2-5-creacion-config-files.sh

./ilfs33_lzip.sh 	$VER_lzip	gz
./ilfs34_unzip.sh	$VER_unzip 	gz
./ilfs35_graft.sh	$VER_graft 	gz
./ilfs36_qi.sh 		$VER_qi


#Y a partir de aquí se cargan los paquetes por Qi !!!!

./3-1-meta-qi-inst-basic-sys-sw.sh

echo -e "
#############################\n\
#  terminado con exito      #\n\
#  successfully finised     #\n\
#############################\n"
