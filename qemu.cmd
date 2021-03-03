@echo off
rem set message=Hello World 
rem echo %message%
set kernel=Image.gz
rem set initrd=rootfs.cpio.gz
rem set initrd=mk10.img.gz
rem set initrd=twrp.331.img.gz
rem set initrd=twrp.340.img.gz
set initrd=twrp.350.img.gz
set initrd=twrp.350_mod.img.gz
rem set initrd=ramdisk_amber_20210221.img.gz
rem set initrd=ramdisk.img.gz
set sys_mem_size=2G
rem set disk0=c:\d_drive\amber\super.img
set console=ttyS0
rem set param=-device virtio-blk-device,drive=hd1 -drive media=disk,format=raw,file=c:\d_drive\amber\super.img,id=hd1
rem set param= -device virtio-scsi-pci -device scsi-hd,drive=hd0 -blockdev node-name=hd0,filename=c:\d_drive\amber\super.img
rem set param= -drive media=disk,format=raw,file=c:\d_drive\ranchu-build\super.img,if=virtio
rem set additional_cmdline=-netdev user,id=vnet,hostfwd=tcp::2121-:21,hostfwd=tcp::2222-:22,hostfwd=tcp::2323-:23,hostfwd=tcp::5555-:5555,hostfwd=tcp::5037-:5037,hostfwd=tcp::5554-:5554 -device virtio-net-pci,netdev=vnet
set additional_cmdline= -device virtio-net-pci,netdev=net0 -netdev user,id=net0,hostfwd=tcp::5555-:5555,hostfwd=tcp::5554-:5554,hostfwd=tcp::2121-:21,hostfwd=tcp::2222-:22,hostfwd=tcp::2323-:23,hostfwd=tcp::8080-:80
rem set additional_cmdline=-netdev user,id=net0 -device virtio-net-pci,netdev=net0
rem -redir tcp:5555::5555 -redir tcp:5554::5554 -redir tcp:2222::22 -redir tcp:2121::21 -redir tcp:23::23
rem  -device usb,host:2.*
rem  androidboot.bootdevice=
rem vga=-device virtio-gpu-pci -device virtio-vga
c:\progra~1\qemu\qemu-system-aarch64 -machine virt -cpu cortex-a53 -m %sys_mem_size% %additional_cmdline% -device virtio-rng-pci -device virtio-mouse-pci -device virtio-keyboard-pci -vga vmware -kernel %kernel% -initrd %initrd% -append "coredump_filter=0x21 drm.debug=0x1ff androidboot.bootdevice=4010000000.pcie androidboot.boot_device=platform/4010000000.pcie androidboot.force_normal_boot=1 androidboot.fstab_suffix=ranchu androidboot.hardware=ranchu androidboot.selinux=permissive console=ttyAMA0 root=/dev/ram rdinit=/init console=pl011 console=%console% " -serial stdio %param%
pause
