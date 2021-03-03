#!/sbin/sh
/sbin/busybox --install /sbin/
/sbin/busybox ifconfig eth0 10.0.2.15 netmask 255.255.255.0 up
/sbin/busybox route add default gw 10.0.2.2 eth0
/sbin/busybox ulimit -S -c unlimited
/sbin/busybox telnetd -b 10.0.2.15:22 -l /sbin/sh

