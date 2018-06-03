# 5.35. Stripping 
# 6.10. Adjusting the Toolchain 


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

function registro_error2 () {
#Función para registrar errores y resultados en la bitaćora
if [ -z "$1" ]
then
	MOMENTO=$(date)
	echo $MSG_ERR
	echo "$MOMENTO Toolchain <$1> -> ERROR" >> $FILE_BITACORA
	exit 1
else
	MOMENTO=$(date)
	echo "$MOMENTO <$1> -> Conforme" >> $FILE_BITACORA
fi
}


if [ $(id -u) -ne 0 ]
	then 
		echo -e "Ur not root bro"
		echo -e "Tines que ser root, tío"
	exit 1
fi


#----------------------CONFIGURE - MAKE - MAKE INSTALL------------------
echo -e "\n5.35 6.10 Adjusting the Toolchain and TESTS" >> $FILE_BITACORA

strip --strip-debug /tools/lib/*
strip --strip-unneeded /tools/{,s}bin/*
rm -rvf /tools/{,share}/{info,man,doc}
find /tools/{lib,libexec} -name \*.la -delete

mv -v /tools/bin/{ld,ld-old}
#renamed '/tools/bin/ld' -> '/tools/bin/ld-old'
registro_error "mv -v /tools/bin/{ld,ld-old}"

mv -v /tools/$(uname -m)-pc-linux-gnu/bin/{ld,ld-old}
#renamed '/tools/i686-pc-linux-gnu/bin/ld' -> '/tools/i686-pc-linux-gnu/bin/ld-old'
registro_error "mv -v /tools/$(uname -m)-pc-linux-gnu/bin/{ld,ld-old}"

mv -v /tools/bin/{ld-new,ld}
#renamed '/tools/bin/ld-new' -> '/tools/bin/ld'
registro_error "mv -v /tools/bin/{ld-new,ld}"

ln -sv /tools/bin/ld /tools/$(uname -m)-pc-linux-gnu/bin/ld
#'/tools/i686-pc-linux-gnu/bin/ld' -> '/tools/bin/ld'
registro_error "ln -sv /tools/bin/ld /tools/ ...."

# All ld point to /tools/bin/ld-new, the one built in 5.9
# Binutils Pass 2.

gcc -dumpspecs | sed -e 's@/tools@@g'                   \
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >      \
    `dirname $(gcc --print-libgcc-file-name)`/specs
registro_error "gcc -dumpspecs "

#*startfile_prefix_spec:
#/usr/lib/
#*cpp:
#%{posix:-D_POSIX_SOURCE} %{pthread:-D_REENTRANT} -isystem /usr/include


