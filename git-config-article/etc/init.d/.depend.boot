TARGETS = console-setup resolvconf mountkernfs.sh ufw apparmor hostname.sh screen-cleanup plymouth-log udev cryptdisks cryptdisks-early networking checkroot.sh lvm2 checkfs.sh urandom open-iscsi iscsid hwclock.sh mountdevsubfs.sh mountnfs-bootclean.sh mountnfs.sh bootmisc.sh mountall-bootclean.sh mountall.sh procps kmod checkroot-bootclean.sh
INTERACTIVE = console-setup udev cryptdisks cryptdisks-early checkroot.sh checkfs.sh
udev: mountkernfs.sh
cryptdisks: checkroot.sh cryptdisks-early udev lvm2
cryptdisks-early: checkroot.sh udev
networking: resolvconf mountkernfs.sh urandom procps
checkroot.sh: hwclock.sh mountdevsubfs.sh hostname.sh
lvm2: cryptdisks-early mountdevsubfs.sh udev
checkfs.sh: cryptdisks checkroot.sh lvm2
urandom: hwclock.sh
open-iscsi: networking iscsid
iscsid: networking
hwclock.sh: mountdevsubfs.sh
mountdevsubfs.sh: mountkernfs.sh udev
mountnfs-bootclean.sh: mountnfs.sh
mountnfs.sh: networking
bootmisc.sh: mountnfs-bootclean.sh mountall-bootclean.sh checkroot-bootclean.sh udev
mountall-bootclean.sh: mountall.sh
mountall.sh: checkfs.sh checkroot-bootclean.sh lvm2
procps: mountkernfs.sh udev
kmod: checkroot.sh
checkroot-bootclean.sh: checkroot.sh
