#!/tools/bin/bash -e

echo -e "
############################################################\n\
#$0\n\
############################################################\n"

function registro_error () {
#Función para registrar errores y resultados en la bitaćora
if [ $? -ne 0 ]
then
	MOMENTO=$(date)
	echo $MSG_ERR
	echo "$MOMENTO $nombre <$1> -> ERROR" >> $FILE_BITACORA
	exit 1
else
	MOMENTO=$(date)
	echo "$MOMENTO $nombre <$1> -> Conforme" >> $FILE_BITACORA
fi
}

. 0-var-chroot-rc
. versiones.sh

cd $chrootqipkgs

qi -i linux-$VER_linux-i686+1.tlz
registro_error "VER_linux"

qi -i man-pages-$VER_man_pages-i686+1.tlz
registro_error "VER_man_pages"

#esto hay que probarlo
ln -sfv /tools/lib/gcc /usr/lib
registro_error "ln -sfv"

ln -sfv ld-linux.so.2 /lib/ld-lsb.so.3
registro_error "ln -sfv"

##rm -f /usr/include/limits.h
touch /etc/ld.so.conf
registro_error "touch"

qi -i glibc-$VER_glibc-i686+1.tlz
registro_error "VER_glibc"

mkdir -pv /var/cache/nscd
registro_error "mkdir"

$croothome/ilfs38_locales.sh
registro_error "ilfs38_locales.sh"

qi -i tzdata-2018d-i686+1.tlz
registro_error "tzdata"

#$croothome/ilfs37_adjust.sh
#registro_error "ilfs37_adjust.sh"

qi -i zlib-$VER_zlib-i686+1.tlz
registro_error "VER_zlib"

mv -v /usr/lib/libz.so.* /lib
registro_error "mv"

ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so
registro_error "ln -sfv"
#Comprobar que funcione.

qi -i file-$VER_file-i686+1.tlz
registro_error "VER_glibc"

qi -i readline-$VER_readline-i686+1.tlz
registro_error "VER_readline"

qi -i m4-$VER_m4-i686+1.tlz
registro_error "VER_m4"

#Al instalar el paquete en la host, le faltan las librerías de Flex.
#Construir paquete flex. La build ya tiene las librerías de 32 y 64
#por eso no dio problemas para construir bc.
qi -i flex-$VER_flex-i686+1.tlz
registro_error "VER_flex"

ln -sfv flex /usr/bin/lex
registro_error "ln -sfv"

#No es capaz de encontrar ncursesw en /tools/lib
#así que le ponen estos Symlinks temporales
ln -sfv /tools/lib/libncursesw.so.6 /usr/lib/libncursesw.so.6
registro_error "ln -sfv"

ln -sfv libncurses.so.6 /usr/lib/libncurses.so
registro_error "ln -sfv"

qi -i bc-$VER_bc-i686+1.tlz
registro_error "VER_bc"

qi -i binutils-$VER_binutils-i686+1.tlz
registro_error "VER_binutils"

qi -i gmp-$VER_gmp-i686+1.tlz
registro_error "VER_gmp"

qi -i mpfr-$VER_mpfr-i686+1.tlz
registro_error "VER_mpfr"

qi -i mpc-$VER_mpc-i686+1.tlz
registro_error "VER_mpc"

##Instalación de GCC
#rm -f /usr/lib/gcc
#
##!!!!!! no funciona. Parece que se compila, pero no.
#######qi -i gcc-$VER_gcc-i686+1.tlz
#ln -sv ../usr/bin/cpp /lib
#ln -sv gcc /usr/bin/cc
#install -v -dm755 /usr/lib/bfd-plugins
#ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/$VER_gcc/liblto_plugin.so /usr/lib/bfd-plugins/
#mkdir -pv /usr/share/gdb/auto-load/usr/lib
#
#mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
#Esto no funciona

#6.21. Bzip
#Priemro se han instalado en el build machine las librería
#de 32 bit y todo lo de 64 bit

qi -i bzip2-$VER_bzip2-i686+1.tlz
registro_error "VER_bzip2"

ln -sfv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
registro_error "ln -sfv"
rm -v /usr/bin/{bunzip2,bzcat,bzip2}
registro_error "rm -v"
ln -sfv bzip2 /bin/bunzip2
registro_error "ln -sfv"
ln -sfv bzip2 /bin/bzcat
registro_error "ln -sfv"

#6.22. Pkg-config-0.29.2
qi -i pkg-config-lite-$VER_pkg-i686+1.tlz
registro_error "VER_pkg"


#Problemas para generar el paquete qi para gcc. Lo aparco y sigo avanzando.
#Realmente de momento no hace falta gcc en el host.


#6.23. Ncurses-6.1
qi -i ncurses-$VER_ncurses-i686+1.tlz
registro_error "VER_ncurses"

#6.24. Attr-2.4.47
#En CLFS no se instala. Pero voy a instalarlo, a que serán necesarias
#las librerías.

qi -i attr-$VER_attr-i686+1.tlz
registro_error "VER_attr"

#6.25. Acl-2.2.52
qi -i acl-$VER_acl-i686+1.tlz
registro_error "VER_acl"

#6.26. Libcap-2.25
qi -i libcap-$VER_libcap-i686+1.tlz
registro_error "VER_libcap"

#6.27. Sed-4.4
qi -i sed-$VER_sed-i686+1.tlz
registro_error "VER_sed"

#6.28. Shadow-4.5
qi -i shadow-$VER_shadow-i686+1.tlz
registro_error "VER_shadow"

#6.29. Psmisc-
qi -i psmisc-$VER_psmisc-i686+1.tlz
registro_error "VER_psmisc"
mv -v /usr/bin/fuser /bin
registro_error "mv"
mv -v /usr/bin/killall /bin
registro_error "mv"
#Es mejor moverlos una vez instalado. Sino se cargan  el /bin.

#6.30. Iana-Etc-2.30
qi -i iana-etc-$VER_iana-i686+1.tlz
registro_error "VER_iana"

#6.31. Bison-
qi -i bison-$VER_bison-i686+1.tlz
registro_error "VER_bison"

#6.32 Flex-. Ya está.

#6.33. Grep-
qi -i grep-$VER_grep-i686+1.tlz
registro_error "VER_grep"

#6.34. Bash
qi -i bash-$VER_bash-i686+1.tlz
registro_error "VER_bash"
mv -vf /usr/bin/bash /bin
registro_error "mv"

#6.36. GDBM-
qi -i gdbm-$VER_gdbm-i686+1.tlz
registro_error "VER_gdbm"

#6.37. Gperf-
qi -i gperf-$VER_gperf-i686+1.tlz
registro_error "VER_gperf"

#6.38. Expat-
qi -i expat-$VER_expat-i686+1.tlz
registro_error "VER_expat"

#6.39. Inetutils-
qi -i inetutils-$VER_inetutils-i686+1.tlz
registro_error "VER_inetutils"
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
registro_error "mv"
mv -v /usr/bin/ifconfig /sbin
registro_error "mv"

#6.41. XML::Parser
qi -i XML-Parser-$VER_xmlparser-i686+1.tlz
registro_error "VER_xmlparser"

#6.42. Intltool-
qi -i intltool-$VER_intltool-i686+1.tlz
registro_error "VER_intltool"

#6.43. Autoconf-
qi -i autoconf-$VER_autoconf-i686+1.tlz
registro_error "VER_autoconf"

#6.44. Automake-
qi -i automake-$VER_automake-i686+1.tlz
registro_error "VER_automake"

#6.45. Xz-5.2.3
qi -i xz-$VER_xz-i686+1.tlz
registro_error "VER_xz"
mv -v /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
registro_error "mv"

#6.46. Kmod-
qi -i kmod-$VER_kmod-i686+1.tlz
registro_error "VER_kmod"

for target in depmod insmod lsmod modinfo modprobe rmmod; do
	ln -sfv ../bin/kmod /sbin/$target
	registro_error "ln -sfv $target"
done
ln -sfv kmod /bin/lsmod
registro_error "ln -sfv $target"

#6.47. Gettext-
qi -i gettext-$VER_gettext-i686+1.tlz
registro_error "VER_gettext"

#6.48. Libelf
qi -i libelf-$VER_libelf-i686+1.tlz
registro_error "VER_libelf"

#Tiny CC
qi -i tcc-$VER_tcc-i686+1.tlz
registro_error "VER_tcc"

#6.49. Libffi
qi -i libffi-$VER_libffi-i686+1.tlz
registro_error "VER_libffi"

#6.50. OpenSSL-1.1.0g
qi -i openssl-$VER_openssl-i686+1.tlz
registro_error "VER_openssl"

#6.51. Python-3
qi -i Python-$VER_Python-i686+1.tlz
registro_error "VER_Python"

#6.52. Ninja-
qi -i ninja-$VER_ninja-i686+1.tlz
registro_error "VER_ninja"

#6.53. Meson-0
#No es tam facil... qi -i  VER_meson=

#6.54. Procps-ng-
qi -i procps-ng-$VER_procps-i686+1.tlz
registro_error "VER_procps"

#6.73. Util-linux
qi -i util-linux-$VER_util_linux-i686+1.tlz
registro_error "VER_util_linux"

#6.56. Coreutils-
qi -i coreutils-$VER_coreutils-i686+1.tlz
registro_error "VER_coreutils"
mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
registro_error "mv"
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
registro_error "mv"
mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin
registro_error "mv"
mv -v /usr/bin/{head,sleep,nice} /bin
registro_error "mv"
mv -v /usr/bin/chroot /usr/sbin
registro_error "mv"
#mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
#sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8

#6.57. Check
qi -i check-$VER_check-i686+1.tlz
registro_error "VER_check"

#6.58. Diffutils
qi -i diffutils-$VER_diffutils-i686+1.tlz
registro_error "VER_diffutils"

#6.59. Gawk-
qi -i gawk-$VER_gawk-i686+1.tlz
registro_error "VER_gawk"

#6.60. Findutils-
qi -i findutils-$VER_findutils-i686+1.tlz
registro_error "VER_findutils"

#6.61. Groff-
qi -i groff-$VER_groff-i686+1.tlz
registro_error "VER_groff"

#6.62. GRUB-
qi -i grub-$VER_grub-i686+1.tlz
registro_error "VER_grub"

#6.63. Less-
qi -i less-$VER_less-i686+1.tlz
registro_error "VER_less"

#6.64. Gzip
qi -i gzip-$VER_gzip-i686+1.tlz
registro_error "VER_gzip"
mv -v /usr/bin/gzip /bin
registro_error "mv"

#6.65. IPRoute2-
qi -i iproute2-$VER_iproute2-i686+1.tlz
registro_error "VER_iproute2"

#6.66. Kbd-
qi -i kbd-$VER_kbd-i686+1.tlz
registro_error "VER_kbd"

#6.67. Libpipeline-
qi -i libpipeline-$VER_libpipeline-i686+1.tlz
registro_error "VER_libpipeline"

#6.68. Make-
qi -i make-$VER_make-i686+1.tlz
registro_error "VER_make"

#6.69. Patch-
qi -i patch-$VER_patch-i686+1.tlz
registro_error "VER_patch"

#6.70. Sysklogd-
qi -i sysklogd-$VER_sysklogd-i686+1.tlz
registro_error "VER_sysklogd"

#6.71. Sysvinit-
qi -i sysvinit-$VER_sysvinit-i686+1.tlz
registro_error "VER_sysvinit"

#6.72. Eudev-
qi -i eudev-$VER_eudev-i686+1.tlz
registro_error "VER_eudev"
udevadm hwdb --update

#6.74. Man-DB-
qi -i man-db-$VER_man_db-i686+1.tlz
registro_error "VER_man_db"

#6.75. Tar-1
qi -i tar-$VER_tar-i686+1.tlz
registro_error "VER_tar"

#6.76. Texinfo-
qi -i texinfo-$VER_texinfo-i686+1.tlz
registro_error "VER_texinfo"

#6.77. Vim-
qi -i vim-$VER_vim-i686+1.tlz
registro_error "VER_vim"
cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc
" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1
set nocompatible
set backspace=2
set mouse=
syntax on

if (&term == "xterm") || (&term == "putty")
set background=dark
endif

set spelllang=es,en
map <f12> :set spell!<cr>
"this is to activate/deactivate the spelling

set tw=75 et nowritebackup

" End /etc/vimrc
EOF
registro_error "cat"

#8.3. Linux-
qi -i linux-$VER_linux-i686+1.tlz
registro_error "VER_linux"

### RUNIT
qi -i runit-$VER_runit-i686+1.tlz
registro_error "VER_runit"

### Mosepad
qi -i gpm-$VER_gpm-i686+1.tlz
registro_error "VER_gpm"



echo -e "
#############################\n\
#  terminado con exito      #\n\
#  successfully finised     #\n\
#############################\n"
