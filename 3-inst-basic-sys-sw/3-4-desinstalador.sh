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

qi -dp linux-$VER_linux-i686+1.tlz
#registro_error "VER_linux"

qi -dp man-pages-$VER_man_pages-i686+1.tlz
#registro_error "VER_man_pages"

qi -dp glibc-$VER_glibc-i686+1.tlz
#registro_error "VER_glibc"

qi -dp tzdata-2018d-i686+1.tlz
#registro_error "tzdata"

qi -dp zlib-$VER_zlib-i686+1.tlz
#registro_error "VER_zlib"

qi -dp file-$VER_file-i686+1.tlz
#registro_error "VER_glibc"

qi -dp readline-$VER_readline-i686+1.tlz
#registro_error "VER_readline"

qi -dp m4-$VER_m4-i686+1.tlz
#registro_error "VER_m4"

qi -dp flex-$VER_flex-i686+1.tlz
#registro_error "VER_flex"

qi -dp bc-$VER_bc-i686+1.tlz
#registro_error "VER_bc"

qi -dp binutils-$VER_binutils-i686+1.tlz
#registro_error "VER_binutils"

qi -dp gmp-$VER_gmp-i686+1.tlz
#registro_error "VER_gmp"

qi -dp mpfr-$VER_mpfr-i686+1.tlz
#registro_error "VER_mpfr"

qi -dp mpc-$VER_mpc-i686+1.tlz
#registro_error "VER_mpc"

qi -dp bzip2-$VER_bzip2-i686+1.tlz
#registro_error "VER_bzip2"

qi -dp pkg-config-lite-$VER_pkg-i686+1.tlz
#registro_error "VER_pkg"

qi -dp ncurses-$VER_ncurses-i686+1.tlz
#registro_error "VER_ncurses"

qi -dp attr-$VER_attr-i686+1.tlz
#registro_error "VER_attr"

qi -dp acl-$VER_acl-i686+1.tlz
#registro_error "VER_acl"

qi -dp libcap-$VER_libcap-i686+1.tlz
#registro_error "VER_libcap"

qi -dp sed-$VER_sed-i686+1.tlz
#registro_error "VER_sed"

qi -dp shadow-$VER_shadow-i686+1.tlz
#registro_error "VER_shadow"

qi -dp psmisc-$VER_psmisc-i686+1.tlz
#registro_error "VER_psmisc"

qi -dp iana-etc-$VER_iana-i686+1.tlz
#registro_error "VER_iana"

qi -dp bison-$VER_bison-i686+1.tlz
#registro_error "VER_bison"

qi -dp grep-$VER_grep-i686+1.tlz
#registro_error "VER_grep"

qi -dp bash-$VER_bash-i686+1.tlz
#registro_error "VER_bash"

qi -dp gdbm-$VER_gdbm-i686+1.tlz
#registro_error "VER_gdbm"

qi -dp gperf-$VER_gperf-i686+1.tlz
#registro_error "VER_gperf"

qi -dp expat-$VER_expat-i686+1.tlz
#registro_error "VER_expat"

qi -dp inetutils-$VER_inetutils-i686+1.tlz
#registro_error "VER_inetutils"

qi -dp XML-Parser-$VER_xmlparser-i686+1.tlz
#registro_error "VER_xmlparser"

qi -dp intltool-$VER_intltool-i686+1.tlz
#registro_error "VER_intltool"

qi -dp autoconf-$VER_autoconf-i686+1.tlz
#registro_error "VER_autoconf"

qi -dp automake-$VER_automake-i686+1.tlz
#registro_error "VER_automake"

qi -dp xz-$VER_xz-i686+1.tlz
#registro_error "VER_xz"

qi -dp kmod-$VER_kmod-i686+1.tlz
#registro_error "VER_kmod"

qi -dp gettext-$VER_gettext-i686+1.tlz
#registro_error "VER_gettext"

qi -dp libelf-$VER_libelf-i686+1.tlz
#registro_error "VER_libelf"

qi -dp tcc-$VER_tcc-i686+1.tlz
#registro_error "VER_tcc"

qi -dp libffi-$VER_libffi-i686+1.tlz
#registro_error "VER_libffi"

qi -dp openssl-$VER_openssl-i686+1.tlz
#registro_error "VER_openssl"

qi -dp Python-$VER_Python-i686+1.tlz
#registro_error "VER_Python"

qi -dp ninja-$VER_ninja-i686+1.tlz
#registro_error "VER_ninja"

qi -dp procps-ng-$VER_procps-i686+1.tlz
#registro_error "VER_procps"

qi -dp util-linux-$VER_util_linux-i686+1.tlz
#registro_error "VER_util_linux"

qi -dp coreutils-$VER_coreutils-i686+1.tlz
#registro_error "VER_coreutils"

qi -dp check-$VER_check-i686+1.tlz
#registro_error "VER_check"

qi -dp diffutils-$VER_diffutils-i686+1.tlz
#registro_error "VER_diffutils"

qi -dp gawk-$VER_gawk-i686+1.tlz
#registro_error "VER_gawk"

qi -dp findutils-$VER_findutils-i686+1.tlz
#registro_error "VER_findutils"

qi -dp groff-$VER_groff-i686+1.tlz
#registro_error "VER_groff"

qi -dp grub-$VER_grub-i686+1.tlz

qi -dp less-$VER_less-i686+1.tlz
#registro_error "VER_less"

qi -dp gzip-$VER_gzip-i686+1.tlz
#registro_error "VER_gzip"

qi -dp iproute2-$VER_iproute2-i686+1.tlz
#registro_error "VER_iproute2"

qi -dp kbd-$VER_kbd-i686+1.tlz
#registro_error "VER_kbd"

qi -dp libpipeline-$VER_libpipeline-i686+1.tlz
#registro_error "VER_libpipeline"

qi -dp make-$VER_make-i686+1.tlz
#registro_error "VER_make"

qi -dp patch-$VER_patch-i686+1.tlz
#registro_error "VER_patch"

qi -dp sysklogd-$VER_sysklogd-i686+1.tlz
#registro_error "VER_sysklogd"

qi -dp sysvinit-$VER_sysvinit-i686+1.tlz
#registro_error "VER_sysvinit"

qi -dp eudev-$VER_eudev-i686+1.tlz
#registro_error "VER_eudev"

qi -dp man-db-$VER_man_db-i686+1.tlz
#registro_error "VER_man_db"

qi -dp tar-$VER_tar-i686+1.tlz
#registro_error "VER_tar"

qi -dp texinfo-$VER_texinfo-i686+1.tlz
#registro_error "VER_texinfo"

qi -dp vim-$VER_vim-i686+1.tlz
#registro_error "VER_vim"

qi -dp linux-$VER_linux-i686+1.tlz
#registro_error "VER_linux"

qi -dp runit-$VER_runit-i686+1.tlz
#registro_error "VER_runit"

qi -dp gpm-$VER_gpm-i686+1.tlz
#registro_error "VER_gpm"



echo -e "
#############################\n\
#  terminado con exito      #\n\
#  successfully finised     #\n\
#############################\n"
