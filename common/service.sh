ARCH=$(getprop ro.product.cpu.abi)
if [ -d /data/adb/modules ]; then
 MAIN=/data/adb/modules/BrainStorm/system
elif [ -d /sbin/.core/img ]; then
 MAIN=/sbin/.core/img/BrainStorm/system
elif [ -d /sbin/.magisk/img ]; then
 MAIN=/sbin/.magisk/img/BrainStorm/system
fi;
if [ "$ARCH" = "$(echo "$ARCH"|grep "x86")" ];then
 mv -f $MAIN/etc/bs/x86/n /system/etc/bs
else
 mv -f $MAIN/etc/bs/arm/n /system/etc/bs
fi;
chmod 0755 /system/etc/bs/n
/system/etc/bs/n 2>/dev/null
exit 0