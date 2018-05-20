#!/bin/bash -e

echo -e "
############################################################\n\
# 1-meta-inst-temp-sys.sh----------------------------------#\n\
############################################################\n"

./ilfs1_binutils.sh		$VER_binutils 	gz
./ilfs2_gcc.sh			$VER_gcc		gz	$VER_mpfr $VER_gmp $VER_mpc 
./ilfs3_linux.sh 		$VER_linux 		xz
./ilfs4_glibc.sh 		$VER_glibc		xz

#prueba de compilacion
$srcdir/gcc-glibc-test-suite1.sh

./ilfs5_gcc.sh			$VER_gcc		gz
./ilfs6_binutils.sh		$VER_binutils 	gz
./ilfs7_gcc.sh			$VER_gcc		gz	$VER_mpfr $VER_gmp $VER_mpc 

#prueba de compilacion
$srcdir/gcc-glibc-test-suite2.sh

./ilfs8_tcl.sh 			$VER_tcl 		gz
./ilfs9_expect.sh 		$VER_expect 	gz
./ilfs10_dejagnu.sh 	$VER_dejagnu 	gz
./ilfs11_m4.sh 			$VER_m4 		xz 
./ilfs12_ncurses.sh 	$VER_ncurses 	gz
./ilfs13_bash.sh 		$VER_bash		gz
./ilfs14_bison.sh 		$VER_bison 		xz
./ilfs15_bzip2.sh 		$VER_bzip2 		gz
./ilfs16_coreutils.sh 	$VER_coreutils	xz
./ilfs17_diffutils.sh 	$VER_diffutils 	xz
./ilfs18_file.sh 		$VER_file 		gz
./ilfs19_findutils.sh	$VER_findutils	gz
./ilfs20_gawk.sh 		$VER_gawk 		xz
./ilfs21_gettext.sh 	$VER_gettext 	xz
./ilfs22_grep.sh 		$VER_grep 		xz
./ilfs23_gzip.sh 		$VER_gzip	 	xz
./ilfs24_make.sh 		$VER_make 		gz
./ilfs25_patch.sh 		$VER_patch 		xz
./ilfs27_sed.sh 		$VER_sed 		xz
./ilfs28_tar.sh 		$VER_tar 		xz
./ilfs29_texinfo.sh 	$VER_texinfo 	xz
./ilfs30_util-linux.sh	$VER_util_linux xz
./ilfs31_xz.sh 			$VER_xz 		xz
./ilfs26_perl.sh 		$VER_perl 		gz #xz

#./ilfs32_vim.sh 		$VER_vim 		bz2
# No es posible instalar vim hasta que no se instale
# ncurses en la ubicación definitiva. No hay quien le
# diga al linker que busque en otro sitio que no sea
# /usr/lib. Hacen falta symlinks etc.



echo -e "
#############################\n\
#  terminado con exito      #\n\
#  successfully finised     #\n\
#############################\n"

