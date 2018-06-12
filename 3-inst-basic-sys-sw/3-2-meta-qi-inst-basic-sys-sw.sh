#!/tools/bin/bash -e

echo -e "
############################################################\n\
#$0\n\
############################################################\n"

. 0-var-chroot-rc
. versiones.sh

cd $chrootqipkgs

qi -i linux-4.16-i686+1.tlz
qi -i man-pages-4.15-i686+1.tlz


#esto hay que probarlo
ln -sfv /tools/lib/gcc /usr/lib
ln -sfv ld-linux.so.2 /lib/ld-lsb.so.3
rm -f /usr/include/limits.h
touch /etc/ld.so.conf

qi -i glibc-2.27-i686+1.tlz

mkdir -pv /var/cache/nscd

$croothome/ilfs38_locales.sh

qi -i tzdata-2018d-i686+1.tlz

$croothome/ilfs37_adjust.sh

#Añadidos 10/06/018

qi -i zlib-1.2.11-i686+1.tlz
qi -i file-5.32-i686+1.tlz
qi -i readline-7.0-i686+1.tlz
qi -i m4-1.4.18-i686+1.tlz

#Al instalar el paquete en la host, le faltan las librerías de Flex.
#Construir paquete flex. La build ya tiene las librerías de 32 y 64
#por eso no dio problemas para construir bc.
qi -i flex-2.6.4-i686+1.tlz
ln -sv flex /usr/bin/lex

#No es capaz de encontrar ncursesw en /tools/lib
#así que le ponen esteos Symlinks temporales
ln -sv /tools/lib/libncursesw.so.6 /usr/lib/libncursesw.so.6
ln -sfv libncurses.so.6 /usr/lib/libncurses.so
qi -i bc-1.07.1-i686+1.tlz
qi -i binutils-2.30-i686+1.tlz

qi -i gmp-6.0.0-i686+1.tlz
qi -i mpfr-3.1.2-i686+1.tlz
qi -i mpc-1.0.2-i686+1.tlz

#Instalacioń de GCC
rm -f /usr/lib/gcc
---qi -i gcc-xxxx Pendiente

ln -sv ../usr/bin/cpp /lib
ln -sv gcc /usr/bin/cc
---seguir añadiendo instrucciones

#qi -i isl-0.18-i686+1.tlz
#qi -i cloog-0.18.4-i686+1.tlz
#qi -i bison-3.0.4-i686+1.tlz




echo -e "
#############################\n\
#  terminado con exito      #\n\
#  successfully finised     #\n\
#############################\n"
