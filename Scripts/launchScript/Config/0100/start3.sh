./qemu-system-arm --enable-kvm -kernel vmlinux.dom0 --enable-spt --mach-phys 0x6c000000 --guest-phys 0x6c000000 -m 64 -M mainstone -nographic -append "root=/dev/nfs rw  nfsroot=192.168.20.1:/root/rootfs/debian,hard ip=192.168.20.4::192.168.20.1:255.255.255.0:vm3:eth0:off clocksource=pit console=hvc0" -netdev type=tap,id=mynet,macaddr=22:54:00:12:34:01 -global virtio-net-mmio.netdev=mynet -global virtio-net-mmio.mac=52:54:00:12:34:03 -chardev stdio,id=my_console -device virtconsole,chardev=my_console,name=console.0 -serial none -monitor null -chardev socket,id=mon,path=/root/vm3.monitor,server,nowait -mon chardev=mon,id=monitor,mode=readline 
