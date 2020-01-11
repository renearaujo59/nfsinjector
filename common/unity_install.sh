if [ -d /data/adb/modules/BrainStorm ]; then
 echo "" > /data/adb/modules/BrainStorm/remove
elif [ -d /data/adb/modules_update/BrainStorm ]; then
 rm -rf /data/adb/modules_update/BrainStorm
elif [ -d /sbin/.core/img/BrainStorm ]; then
 echo "" > /sbin/.core/img/BrainStorm/remove
elif [ -d /sbin/.magisk/img/BrainStorm ]; then
 echo "" > /sbin/.magisk/img/BrainStorm/remove
fi;