./qemu-system-arm --enable-kvm -kernel vmlinux-si.dom0 --enable-si --mach-phys 0x70000000 --guest-phys 0x70000000 -m 64 -M mainstone -nographic -append "root=/dev/vda ip=192.168.20.5::192.168.20.1:255.255.255.0:vm4:eth0:off clocksource=pit console=hvc0" -netdev type=tap,id=mynet,macaddr=22:54:00:12:34:01 -global virtio-net-mmio.netdev=mynet -global virtio-net-mmio.mac=52:54:00:12:34:04 -chardev stdio,id=my_console -device virtconsole,chardev=my_console,name=console.0 -serial none -monitor null -chardev socket,id=mon,path=/root/vm4.monitor,server,nowait -mon chardev=mon,id=monitor,mode=readline -drive file=/mnt/vdisk4.img,if=virtio-mmio,id=myimg,vhost=on -global virtio-blk-mmio.drive=myimg
