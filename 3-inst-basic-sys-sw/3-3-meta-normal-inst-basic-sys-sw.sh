#!/tools/bin/bash -e

echo -e "
############################################################\n\
#$0\n\
############################################################\n"

cd /home

. 0-var-chroot-rc
. versiones.sh

./ilfs39_linux.sh 		$VER_linux 		xz
./ilfs40_man-pages.sh 	$VER_man_pages 	xz
./ilfs41_glibc.sh 		$VER_glibc		xz
./ilfs38_locales.sh
./ilfs42_tzdata.sh	2018d	xz
./ilfs37_adjust.sh


echo -e "
#############################\n\
#  terminado con exito      #\n\
#  successfully finised     #\n\
#############################\n"
