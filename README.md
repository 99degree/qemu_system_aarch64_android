# qemu_system_aarch64_android
A set of scripts to setup qemu 5.20 for Android

The setup is as below

Win10------|
ADB.EXE----|-->QEMU_SYSTEM_AARCH64.EXE->Android(recovery)
Win10 NAT--|
CONSOLE----|

init.rc Android init rc, added service to enable console and network/adb via network, also enable coredump
shell.sh setup busybox/network for guest(Android) to forward host port '5555/5554' to guest.
qemu.cmd launcher for qemu-system-aarch64.exe
Image.gz kernel for testing
twrp.350_mod.img.gz for testing

To test, install qemu 5.20 official. Launch with qemu.cmd, if the screen shows uart info, then its fine.
below are step for Android env setup via qemu window.
#stop recovery
#shell.sh

Ok, ready for core dump test. Below are adb setup. WSL environment is prefered.
#~/adb.exe connect 5555
#~/adb.exe shell 
#

Ok adb should gets into the Android recovery. Then exec below to create core dump:
#/sbin/recovery

Ok the coredump is at /data/core/, get it by
#~/adb.exe pull /data/core/dump_x_y_z

Ok use GDB to do analysis
#~/adb.exe pull /sbin/recovery
#aarch64-linux-gnu-gdb recovery 
Reading symbols from build/unzip_boot/root/sbin/recovery...
Reading symbols from .gnu_debugdata for /root/source/Android_boot_image_editor/build/unzip_boot/root/sbin/recovery...
(No debugging symbols found in .gnu_debugdata for /root/source/Android_boot_image_editor/build/unzip_boot/root/sbin/recovery)
(gdb)

Ok keys in below:
(gdb) core-file dump_x_y_z
(gdb) bt

Usually the backtrace will show the signal 11 caused location, but this twrp recovery binary is not having debug info. so thats it.

Enjoy!

