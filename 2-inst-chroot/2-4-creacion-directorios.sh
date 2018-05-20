#!/tools/bin/bash -e
#OJO esto es porque en chroot bash no está en /bin todavía

echo -e "
############################################################\n\
#$0\n\
############################################################\n"


control_flujo () {
	echo "Continue? To exit press N"
	read CS
	if [ "$CS" == "N" ]
		then
			echo "exit"
			exit
	fi
}

if [ $(id -u) -ne 0 ]; then 
	echo -e "Ur not root bro"
	echo -e "Tines que ser root, tío"
	exit 1
fi

#Version 8.2
#6.5. Creating Directories 
#Los directorios se crean desde chroot

echo -e "
#############################\n\
#  OJO SOLO CHROOT          #\n\
#                           #\n\
#############################\n"
#control_flujo

#proc_root=$(ls -id / | cut -d " " -f1)
#[ $proc_root == "2" ] && echo "Debe hacerse en chroot" && exit 1

#mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
mkdir -pv /{bin,boot,etc/{opt,sysconfig},lib/firmware,mnt,opt}
mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
#control_flujo

install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp
#control_flujo

mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -v  /usr/libexec
mkdir -pv /usr/{,local/}share/man/man{1..8}
#control_flujo

case $(uname -m) in
 x86_64) mkdir -v /lib64 ;;
esac
#control_flujo

mkdir -v /var/{log,mail,spool}
#control_flujo

ln -sv /run /var/run
ln -sv /run/lock /var/lock
#control_flujo

mkdir -pv /var/{opt,cache,lib/{color,misc,locate},local}
#control_flujo


#6.6. Creating Essential Files and Symlinks
ln -sv /tools/bin/{bash,cat,dd,echo,ln,pwd,rm,stty} /bin
ln -sv /tools/bin/{install,perl} /usr/bin
ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib
ln -sv /tools/lib/libstdc++.{a,so{,.6}} /usr/lib
ln -sv bash /bin/sh
ln -sv /proc/self/mounts /etc/mtab














