#!/tools/bin/bash -e

echo -e "
############################################################\n\
#$0\n\
############################################################\n"

. 0-var-chroot-rc
. versiones.sh

cd $chrootqipkgs

qi -i linux-$VER_linux-i686+1.tlz
qi -i man-pages-$VER_man_pages-i686+1.tlz

#esto hay que probarlo
ln -sfv /tools/lib/gcc /usr/lib
ln -sfv ld-linux.so.2 /lib/ld-lsb.so.3
##rm -f /usr/include/limits.h
touch /etc/ld.so.conf

qi -i glibc-$VER_glibc-i686+1.tlz

mkdir -pv /var/cache/nscd

$croothome/ilfs38_locales.sh

qi -i tzdata-2018d-i686+1.tlz

$croothome/ilfs37_adjust.sh

qi -i zlib-$VER_zlib-i686+1.tlz

mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so
#Comprobar que funcione.

qi -i file-$VER_file-i686+1.tlz
qi -i readline-$VER_readline-i686+1.tlz
qi -i m4-$VER_m4-i686+1.tlz

#Al instalar el paquete en la host, le faltan las librerías de Flex.
#Construir paquete flex. La build ya tiene las librerías de 32 y 64
#por eso no dio problemas para construir bc.
qi -i flex-$VER_flex-i686+1.tlz
ln -sv flex /usr/bin/lex

#No es capaz de encontrar ncursesw en /tools/lib
#así que le ponen estos Symlinks temporales
ln -sv /tools/lib/libncursesw.so.6 /usr/lib/libncursesw.so.6
ln -sfv libncurses.so.6 /usr/lib/libncurses.so
qi -i bc-$VER_bc-i686+1.tlz
qi -i binutils-$VER_binutils-i686+1.tlz

qi -i gmp-$VER_gmp-i686+1.tlz
qi -i mpfr-$VER_mpfr-i686+1.tlz
qi -i mpc-$VER_mpc-i686+1.tlz

#Instalación de GCC
rm -f /usr/lib/gcc

qi -i gcc-$VER_gcc-i686+1.tlz

ln -sv ../usr/bin/cpp /lib
ln -sv gcc /usr/bin/cc
install -v -dm755 /usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/$VER_gcc/liblto_plugin.so /usr/lib/bfd-plugins/
mkdir -pv /usr/share/gdb/auto-load/usr/lib

#mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
#Esto no funciona

#6.21. Bzip
#Priemro se han instalado en el build machine las librería
#de 32 bit y todo lo de 64 bit

qi -i bzip2-$VER_bzip2-i686+1.tlz

ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
rm -v /usr/bin/{bunzip2,bzcat,bzip2}
ln -sv bzip2 /bin/bunzip2
ln -sv bzip2 /bin/bzcat

#6.22. Pkg-config-0.29.2
qi -i pkg-config-lite-$VER_pkg-i686+1.tlz


echo -e "
#############################\n\
#  terminado con exito      #\n\
#  successfully finised     #\n\
#############################\n"
