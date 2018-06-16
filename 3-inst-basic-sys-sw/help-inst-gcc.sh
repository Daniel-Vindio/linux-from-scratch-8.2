# Help to install gcc with qi

#6.20. GCC-7.3.0


T_COMIENZO=$(date +"%T")	#para calcular el tiempo de instalación

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

control_flujo () {
	echo "Continue? To exit press N"
	read CS
	if [ "$CS" == "N" ]
		then
			echo "exit"
			exit
	fi
}

if [ $(id -u) -ne 0 ]
	then 
		echo -e "Ur not root bro"
		echo -e "Tines que ser root, tío"
	exit 1
fi

#---------------------------------------
rm -f /usr/lib/gcc
registro_error "1"

qi -i xxxx


ln -sv ../usr/bin/cpp /lib
registro_error "2"

ln -sv gcc /usr/bin/cc
registro_error "3"

install -v -dm755 /usr/lib/bfd-plugins
registro_error "4"

ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/7.3.0/liblto_plugin.so \
/usr/lib/bfd-plugins/
registro_error "5"

control_flujo

echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

control_flujo

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log

control_flujo

grep -B4 '^ /usr/include' dummy.log

control_flujo

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

control_flujo

grep "/lib.*/libc.so.6 " dummy.log

control_flujo

grep found dummy.log

control_flujo

rm -v dummy.c a.out dummy.log


mkdir -pv /usr/share/gdb/auto-load/usr/lib
registro_error "6"

mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
registro_error "7"


#Registro de tiempos de ejecución
T_FINAL=$(date +"%T")
echo "$(date) $nombre <$MSG_TIME> $T_COMIENZO $T_FINAL" >> $FILE_BITACORA






