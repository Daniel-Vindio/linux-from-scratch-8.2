# Test suite

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
echo -e "\nGCC GLIBC TESTS 2ª Pasada" >> $FILE_BITACORA

echo 'int main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools' > /tmp/dum_test
resultado=$(cat /tmp/dum_test)
echo $resultado
registro_error2 "$resultado"

rm -v dummy.c a.out

