if [ -d /data/adb/modules/nfsinjector ]; then
 echo "" > /data/adb/modules/nfsinjector/remove
elif [ -d /data/adb/modules_update/nfsinjector ]; then
 rm -rf /data/adb/modules_update/nfsinjector
elif [ -d /sbin/.core/img/nfsinjector ]; then
 echo "" > /sbin/.core/img/nfsinjector/remove
elif [ -d /sbin/.magisk/img/nfsinjector ]; then
 echo "" > /sbin/.magisk/img/nfsinjector/remove
fi;