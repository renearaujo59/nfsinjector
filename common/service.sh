ARCH=$(getprop ro.product.cpu.abi)
if [ -d /data/adb/modules ]; then
 MAIN=/data/adb/modules/nfsinjector/system
elif [ -d /sbin/.core/img ]; then
 MAIN=/sbin/.core/img/nfsinjector/system
elif [ -d /sbin/.magisk/img ]; then
 MAIN=/sbin/.magisk/img/nfsinjector/system
fi;
if [ "$ARCH" = "$(echo "$ARCH"|grep "x86")" ];then
 mv -f $MAIN/etc/nfs/x86/nfs /system/etc/nfs
else
 mv -f $MAIN/etc/nfs/arm/nfs /system/etc/nfs
fi;
chmod 0755 /system/etc/nfs/nfs
/system/etc/nfs/nfs 2>/dev/null
exit 0