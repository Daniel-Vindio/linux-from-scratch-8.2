#/bin/bash -e

echo -e "
############################################################\n\
#$0\n\
############################################################\n"

#Version 8.2
#6.4. Entering the Chroot Environment 

if [ $(id -u) -ne 0 ]
	then 
		echo -e "Ur not root bro"
		echo -e "Tines que ser root, tío"
	exit 1
fi

/usr/sbin/chroot "${LFS}" /tools/bin/env -i \
HOME=/root \
TERM="${TERM}" \
PS1='(lfs-chroot) \u:\w\$ ' \
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
/tools/bin/bash -c /home/3-1-meta-inst-basic-sys-sw.sh

