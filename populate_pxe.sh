#!/bin/bash

VERD="6.2"

VER=$(echo $VERD|sed 's/\.//')
cd /tftp
mkdir -p "$VERD"
cd "$VERD"
[ -r pxeboot ] || wget -nv ftp://ftp.icm.edu.pl/pub/OpenBSD/"$VERD"/amd64/pxeboot
[ -r bsd ] || wget -nv ftp://ftp.icm.edu.pl/pub/OpenBSD/"$VERD"/amd64/bsd
[ -r bsd.rd ] || wget -nv ftp://ftp.icm.edu.pl/pub/OpenBSD/"$VERD"/amd64/bsd.rd
cd /tftp
rm -f auto_install bsd* pxeboot
ln -s "$VERD"/pxeboot .
ln -s "$VERD"/bsd .
ln -s "$VERD"/bsd.rd .
ln -s pxeboot auto_install
ls -l


# populate /var/www

mkdir -p /var/www/htdocs/pub/OpenBSD/"$VERD"/amd64
cd /var/www/htdocs/pub/OpenBSD/"$VERD"/amd64
for i in INSTALL.amd64 bsd bsd.mp bsd.rd base"$VER".tgz SHA256 SHA256.sig; do
  [ -r "$i" ] || wget -nv ftp://ftp.icm.edu.pl/pub/OpenBSD/"$VERD"/amd64/"$i"
done
ls >index.txt

cd /var/www/htdocs/
[ -r install.conf ] && mv install.conf install.conf$(date +%F%H%M).bak
ln -s install.conf62 install.conf
