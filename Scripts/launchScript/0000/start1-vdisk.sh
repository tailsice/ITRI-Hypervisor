./qemu-system-arm --enable-kvm -kernel vmlinux.dom0 --enable-spt --mach-phys 0x64000000 --guest-phys 0x64000000 -m 64 -M mainstone -nographic -append "root=/dev/vda rw ip=192.168.20.2::192.168.20.1:255.255.255.0:vm1:eth0:off clocksource=pit console=hvc0" -netdev type=tap,id=mynet,macaddr=22:54:00:12:34:01 -global virtio-net-mmio.netdev=mynet -global virtio-net-mmio.mac=52:54:00:12:34:01 -chardev stdio,id=my_console -device virtconsole,chardev=my_console,name=console.0 -serial none -monitor null -chardev socket,id=mon,path=/root/vm1.monitor,server,nowait -mon chardev=mon,id=monitor,mode=readline -drive file=/mnt/vdisk1.img,if=virtio-mmio,id=myimg,vhost=on -global virtio-blk-mmio.drive=myimg
