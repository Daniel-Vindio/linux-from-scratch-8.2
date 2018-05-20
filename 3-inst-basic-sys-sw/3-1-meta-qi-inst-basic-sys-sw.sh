#!/tools/bin/bash -e

echo -e "
############################################################\n\
#$0--------------------------#\n\
############################################################\n"

cd $chrootqipkgs

qi -i linux-4.16-i686+1.tlz
qi -i man-pages-4.15-i686+0.tlz
qi -i glibc-2.27-i686+1.tlz
$croothome/ilfs37_adjust.sh
$croothome/ilfs38_locales.sh
qi -i tzdata-2018d-i686+1.tlz
qi -i m4-1.4.18-i686+1.tlz
#qi -i gmp
qi -i mpfr-4.0.1-i686+1.tlz
qi -i mpc-1.1.0-i686+1.tlz
qi -i isl-0.18-i686+1.tlz
qi -i cloog-0.18.4-i686+1.tlz
qi -i zlib-1.2.11-i686+1.tlz
qi -i flex-2.6.4-i686+1.tlz
qi -i bison-3.0.4-i686+1.tlz
qi -i binutils-2.30-i686+1.tlz



echo -e "
#############################\n\
#  terminado con exito      #\n\
#  successfully finised     #\n\
#############################\n"
