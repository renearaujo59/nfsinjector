#========================================
# NFS-INJECTOR
# Codename : HUNTER
# Version : 5.0
# Developer : @K1ks
Date=08-04-2019
# Team : @HafizZiq , @HackerZombie , @KilayoRed , @TarangKarpe
#========================================
## MODE USER ( mode.txt )
# 0 = BALANCED ( Def )
# 1 = ULTRA 
# 2 = GAMING
# 3 = BATTERY_SAVER
## ZRAM USER ( comp.txt )
# 0 = AUTO ( Def )
# 1 = ON
# 2 = OFF
## DNS USER ( dns.txt )
# 0 = OFF ( Def )
# 1 = DNS GUARD ( ADS )
# 2 = DNS CLOUDFLARE ( SPEED )
# 3 = DNS GOOGLE
# 4 = DNS CLEANBROWSING
# 5 = DNS VERISIGN
## SELIUX USER ( linux.txt )
# 0 = PERMISSIVE ( Def )
# 1 = ENFORCING
# SUPPORT GOVERNORS = pixel_schedutil helix_schedutil smurfutil_flex pixutil pwrutilx darkness schedutil blu_schedutil blu_active elementalx zzmoove interactivepro interactiveplus interactiveX interactive ondemand performance
# SUPPORT SCHEDULER = anxiety fiops sioplus sio zen tripndroid row bfq cfq deadline noop
# SUPPORT TCP = ascarex sociopath westwood cubic reno

# PATH LOG =========================================#

Path=/data
if [ ! -d $Path/NFS ]; then
 mkdir -p $Path/NFS
fi;
NFS=$Path/NFS
LOG=/$NFS/nfs.log
LOGMOUNT=/$NFS/nfsmount.log
V=5.5
S=Stable
Code=Crisis
box=`busybox | awk 'NR==1{print $2}'` 2>/dev/null
MEM=`free -m | awk '/Mem:/{print $2}'`
mem=`free | grep Mem |  awk '{print $2}'`;
VENDOR=$(getprop ro.product.brand) 2>/dev/null
ROM=$(getprop ro.build.display.id) 2>/dev/null
KERNEL=$(uname -r) 2>/dev/null
APP=$(getprop ro.product.model) 2>/dev/null
SDK=$(getprop ro.build.version.sdk) 2>/dev/null 
ROOT=$(magisk -c) 2>/dev/null
MODE=`cat $NFS/mode.txt`;
DNS=`cat $NFS/dns.txt`;
SE=`cat $NFS/linux.txt`;
CP=`cat $NFS/comp.txt`;
FC=`cat /sys/kernel/fast_charge/force_fast_charge`;
BATT=`cat /sys/class/power_supply/battery/capacity`;
CHIP=$(getprop ro.product.board) 2>/dev/null
CHIP1=$(getprop ro.product.platform) 2>/dev/null
CHIP2=$(getprop ro.board.platform) 2>/dev/null

if [ ! "$CHIP" = "" ]; then
 SOC=$(getprop ro.product.board) 2>/dev/null
elif [ ! "$CHIP1" = "" ]; then
 SOC=$(getprop ro.product.platform) 2>/dev/null
elif [ ! "$CHIP2" = "" ]; then
 SOC=$(getprop ro.board.platform) 2>/dev/null
else
 SOC=Unidentified_Soc
fi;

if [ -d /sbin/.core/img ]; then
SBIN=/sbin/.core/img
elif [ -d /sbin/.magisk/img ]; then
SBIN=/sbin/.magisk/img
fi;

INVADER() {
echo "*...WARNING , BE CAREFUL...*" | tee -a $LOG;
echo "*...NFS AUTO-EXIT , ABORTING...*" | tee -a $LOG;
echo "*... $IT FOUND...*" | tee -a $LOG;
echo "*...CHECK BEFORE NEXT REBOOT...*" | tee -a $LOG;
exit 1
}

if [ -e /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors ]; then
 AGB=/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
elif [ -e /sys/devices/system/cpu/cpu1/cpufreq/scaling_available_governors ]; then
 AGB=/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_governors
fi;

TACC=/proc/sys/net/ipv4/tcp_available_congestion_control
if [ -e /sys/block/mmcblk0/queue/scheduler ]; then
 SA=/sys/block/mmcblk0/queue/scheduler
elif [ -e /sys/block/sda/queue/scheduler ]; then
 SA=/sys/block/sda/queue/scheduler
elif [ -d /sys/block/dm-0/queue/scheduler ]; then
 SA=/sys/block/dm-0/queue/scheduler
elif [ -d /sys/block/loop0/queue/scheduler ]; then
 SA=/sys/block/loop0/queue/scheduler
fi;

if grep 'smurfutil_flex' $AGB; then
 gov=smurfutil_flex
elif grep 'pixutil' $AGB; then
 gov=pixutil
elif grep 'pwrutilx' $AGB; then
 gov=pwrutilx
elif grep 'helix_schedutil' $AGB; then
 gov=pixel_schedutil
elif grep 'pixel_schedutil' $AGB; then
 gov=pixel_schedutil
elif grep 'schedutil' $AGB; then
 gov=schedutil
elif grep 'darkness' $AGB; then
 gov=darkness 
elif grep 'elementalx' $AGB; then
 gov=elementalx
elif grep 'interactive' $AGB; then
 gov=interactive
elif grep 'interactivepro' $AGB; then
 gov=interactivepro
elif grep 'interactive_pro' $AGB; then
 gov=interactive_pro
elif grep 'interactiveplus' $AGB; then
 gov=interactiveplus
elif grep 'interactivex' $AGB; then
 gov=interactivex
elif grep 'blu_active' $AGB; then
 gov=blu_active
elif grep 'blu_schedutil' $AGB; then
 gov=blu_schedutil
elif grep 'zzmoove' $AGB; then
 gov=zzmoove
elif grep 'ondemand' $AGB; then
 gov=ondemand 
elif grep 'performance' $AGB; then
 gov=performance
fi;
if grep 'anxiety' $SA; then 
 sch=anxiety
elif grep 'zen' $SA; then
 sch=zen
elif grep 'tripndroid' $SA; then
 sch=tripndroid
elif grep 'cfq' $SA; then
 sch=cfq
elif grep 'bfq' $SA; then
 sch=bfq
elif grep 'fiops' $SA; then
 sch=fiops
elif grep 'sioplus' $SA; then
 sch=sioplus
elif grep 'sio' $SA; then
 sch=sio 
elif grep 'row' $SA; then
 sch=row
elif grep 'deadline' $SA; then
 sch=deadline
elif grep 'noop' $SA; then
 sch=noop
fi;
if  grep -l 'ascarex' $TACC; then
 tcp=ascarex
elif  grep -l 'sociopath' $TACC; then
 tcp=sociopath
elif  grep -l 'westwood' $TACC; then
 tcp=westwood
elif  grep -l 'cubic' $TACC; then
 tcp=cubic
else
 tcp=reno
fi;
if [ -e /sys/kernel/fast_charge/ac_charge_level ]; then	
 if [ -e /sys/class/power_supply/battery/batt_slate_mode ]; then	
 echo "0" > /sys/class/power_supply/battery/batt_slate_mode
 fi;
fi;

# WAITING TIME =========================================#

while ! pgrep com.android ; 
do
 sleep 66
done

if [ -e $LOG ]; then
 rm $LOG;
fi;

# CHECK INVADER =========================================#

if [ -e $SBIN/legendary_kernel_tweaks ]; then
 INVADER
 IT=LTK
elif [ -e /data/LKT.prop ]; then
 INVADER
 IT=LTK
elif [ -e $SBIN/FDE ]; then
 INVADER
 IT=FDE.AI
elif [ -e $SYS/bin/L_Speed ]; then
 INVADER
 IT=LSpeed
elif [ -e $SYS/xbin/killjoy ]; then
 INVADER
 IT=KillJoy
elif [ -e $SYS/xbin/haveged ]; then
 INVADER
 IT=Haveged
elif [ -e $SYS/bin/The_Thing ]; then
 INVADER
 IT=The_Thing
elif [ -e $SYS/KITANA/COMMON/KI00Rngd ]; then
 INVADER
 IT=Kitana
elif [ -e $SYS/xbin/fde ]; then
 INVADER
 IT=FDE
elif [ -e $SYS/bin/ABS ]; then
 INVADER
 IT=ABS
elif [ -e $SYS/etc/CrossBreeder/CrossBreeder ]; then
 INVADER
 IT=CrossBeeder
elif [ -e $SYS/etc/init.d/999fde ]; then
 INVADER
 IT=FDE
elif [ -e /data/data/com.paget96.lspeed/files/binaries/busybox ]; then
 INVADER
 IT=LSpeedApp
fi;

# CONFIGURATION =========================================#

if [ ! -e $NFS/governor.txt ]; then
 echo "$gov" > $NFS/governor.txt
fi;
if [ ! -e $NFS/scheduler.txt ]; then
 echo "$sch" > $NFS/scheduler.txt
fi;
if [ ! -e $NFS/tcp.txt ]; then
 echo "$tcp" > $NFS/tcp.txt
fi
if [ ! -e $NFS/mode.txt ]; then
 echo "0" > $NFS/mode.txt
fi;
if [ ! -e $NFS/dns.txt ]; then
 echo "0" > $NFS/dns.txt
fi;
if [ ! -e $NFS/linux.txt ]; then
 echo "0" > $NFS/linux.txt
fi;
if [ ! -e $NFS/comp.txt ]; then
 echo "0" > $NFS/comp.txt
fi;
if [ ! -e $NFS/sync.txt ]; then
 echo "0" > $NFS/sync.txt
fi;
if [ "$MEM" -lt 2560 ]; then
 RAMCAP=0
else
 RAMCAP=1
fi;

# LOGGING =========================================#

echo "================================================" | tee -a $LOG;
echo "//////// ϟ NFS-INJECTOR(TM) LOGGING SYSTEM ϟ ~~ " |  tee -a $LOG;
echo "//////// UNIVERSAL MAGISK MODULE ~~ " |  tee -a $LOG;
echo "//////// CodeName : $Code ~~ " |  tee -a $LOG;
echo "//////// Version : $V ~~ " |  tee -a $LOG;
echo "//////// Status : $S ~~ " |  tee -a $LOG;
echo "//////// Date : $Date ~~ " |  tee -a $LOG;
echo "================================================" | tee -a $LOG;
echo "* START : $( date +"%m-%d-%Y %H:%M:%S" ) *" | tee -a $LOG;
echo "** Vendor : $VENDOR *" | tee -a $LOG;
echo "** Device : $APP *" | tee -a $LOG;
echo "** Soc : $SOC *" | tee -a $LOG;
echo "** Rom : $ROM *" | tee -a $LOG;
echo "** Root : $ROOT *" | tee -a $LOG;
echo "** Android : $(getprop ro.build.version.release) *" | tee -a $LOG;
echo "** Sdk : $SDK *" | tee -a $LOG;
echo "** Kernel : $KERNEL *" | tee -a $LOG;
echo "** Ram : $MEM Mb *" | tee -a $LOG;
echo "** Busybox  : $box *" | tee -a $LOG;
echo "** Battery Level : $BATT % *" | tee -a $LOG;
if [ -d /data/data/com.kerneladiutor.mod ]; then 
 echo "** Kernel Adiutor Mod : Installed *" | tee -a $LOG;
fi;
if [ -d /data/data/com.grarak.kerneladiutor ]; then 
 echo "** Kernel Adiutor : Installed *" | tee -a $LOG;
fi;
if [ -d /data/data/flar2.exkernelmanager ]; then 
 echo "** Ex Kernel : Installed *" | tee -a $LOG;
fi;

echo "" | tee -a $LOG;
if [ $MODE -eq "2" ]; then
 echo "* GAMING MODE = Initialized *" | tee -a $LOG;
elif [ $MODE -eq "1" ]; then
 echo "* ULTRA MODE = Initialized *" | tee -a $LOG;
elif [ $MODE -eq "3" ]; then
 echo "* BATTERY SAVER MODE = Initialized *" | tee -a $LOG;
else
 echo "* BALANCED MODE = Initialized *" | tee -a $LOG;
fi;

# SELINUX PERMISSIVE =========================================#

if [ -e /sys/fs/selinux/enforce ]; then
 setenforce 0
 echo "$SE" > /sys/fs/selinux/enforce
 SE=`cat /sys/fs/selinux/enforce`;
fi;

if [ $SE -eq 1 ]; then
 echo "* SE Linux = Enforcing *" |  tee -a $LOG;
else 
 echo "* SE Linux = Permissive *" |  tee -a $LOG;
fi;

# MMC CRC =========================================#

MMC() {
echo "* MMC CRC checking = Disabled *" | tee -a $LOG;
}
if [ -e /sys/module/mmc_core/parameters/removable ]; then
 MC=/sys/module/mmc_core/parameters/removable
 echo "N" > $MC
 MMC
elif [ -e /sys/module/mmc_core/parameters/crc ]; then
 MC=/sys/module/mmc_core/parameters/crc
 echo "N" > $MC
 MMC
elif [ -e /sys/module/mmc_core/parameters/use_spi_crc ]; then
 MC=/sys/module/mmc_core/parameters/use_spi_crc
 echo "N" > $MC
 MMC
fi;

# SYSCTL / DVFS =========================================#

if [ -e $SYS/etc/sysctl.conf ]; then
 mv -f $SYS/etc/sysctl.conf $SYS/etc/sysctl.conf.bak
echo "* Tuner System  = Disabled *" |  tee -a $LOG;
fi;
if [ -e /sys/devices/14ac0000.mali/dvfs ]; then
 chmod 0000 /sys/devices/14ac0000.mali/dvfs
 chmod 0000 /sys/devices/14ac0000.mali/dvfs_max_lock
 chmod 0000 /sys/devices/14ac0000.mali/dvfs_min_lock
 echo "* Dyn Voltage / Freqs Scaling  = Disabled *" |  tee -a $LOG;
fi;

# VM TWEAKS =========================================#

sync;
chmod 0644 /proc/sys/*; 2>/dev/null

if [ "$MODE" -eq "2" ]; then
 sysctl -e -w vm.dirty_background_ratio=3 2>/dev/null
 sysctl -e -w vm.dirty_ratio=15 2>/dev/null
 sysctl -e -w vm.vfs_cache_pressure=150 2>/dev/null
elif [ "$MODE" -eq "1" ]; then
 sysctl -e -w vm.dirty_background_ratio=35 2>/dev/null
 sysctl -e -w vm.dirty_ratio=70 2>/dev/null
 sysctl -e -w vm.vfs_cache_pressure=10 2>/dev/null
elif [ "$MODE" -eq "3" ]; then
 sysctl -e -w vm.dirty_background_ratio=5 2>/dev/null
 sysctl -e -w vm.dirty_ratio=20 2>/dev/null
 sysctl -e -w vm.vfs_cache_pressure=10 2>/dev/null
else
 sysctl -e -w vm.dirty_background_ratio=35 2>/dev/null
 sysctl -e -w vm.dirty_ratio=70 2>/dev/null
 sysctl -e -w vm.vfs_cache_pressure=10 2>/dev/null
fi;
sysctl -e -w vm.drop_caches=0 2>/dev/null
sysctl -e -w vm.oom_kill_allocating_task=0 2>/dev/null
sysctl -e -w vm.block_dump=0 2>/dev/null
sysctl -e -w vm.overcommit_memory=1 2>/dev/null
sysctl -e -w vm.oom_dump_tasks=1 2>/dev/null
sysctl -e -w vm.dirty_writeback_centisecs=0 2>/dev/null
sysctl -e -w vm.dirty_expire_centisecs=0 2>/dev/null
sysctl -e -w vm.min_free_order_shift=4 2>/dev/null
sysctl -e -w vm.swappiness=0 2>/dev/null
sysctl -e -w vm.page-cluster=0 2>/dev/null
sysctl -e -w vm.laptop_mode=0 2>/dev/null
sysctl -e -w fs.lease-break-time=10 2>/dev/null
sysctl -e -w fs.leases-enable=1 2>/dev/null
sysctl -e -w fs.dir-notify-enable=0 2>/dev/null
sysctl -e -w vm.compact_memory=1 2>/dev/null
sysctl -e -w vm.compact_unevictable_allowed=1 2>/dev/null
echo "* VM Kernel = Activated *" |  tee -a $LOG;

# KILL DEBUGGING =========================================#

sysctl -e -w vm.panic_on_oom=0 2>/dev/null
sysctl -e -w kernel.panic_on_oops=0 2>/dev/null
sysctl -e -w kernel.panic=0 2>/dev/null
echo "* Kill Debugging = Activated *" |  tee -a $LOG;

# Low Memory Killer =========================================#

if [ "$MODE" -eq "2" ]; then
 FP=$((($MEM*3/100)*1024/4));
 VP=$((($MEM*4/100)*1024/4));
 SR=$((($MEM*5/100)*1024/4));
 HP=$((($MEM*6/100)*1024/4));
 CR=$((($MEM*9/100)*1024/4));
 EP=$((($MEM*15/100)*1024/4));
 ADJ1=0; ADJ2=117; ADJ3=235; ADJ4=411; ADJ5=823; ADJ6=1000 # NFS
 MFK=$(($SR*4/5))
elif [ "$MODE" -eq "1" ]; then
 FP=$((($MEM*3/100)*1024/4));
 VP=$((($MEM*4/100)*1024/4));
 SR=$((($MEM*5/100)*1024/4));
 HP=$((($MEM*6/100)*1024/4));
 CR=$((($MEM*9/100)*1024/4));
 EP=$((($MEM*15/100)*1024/4));
 ADJ1=0; ADJ2=117; ADJ3=235; ADJ4=411; ADJ5=823; ADJ6=1000 # NFS
 MFK=$(($SR*4/5))
elif [ "$MODE" -eq "3" ]; then
 FP=$((($MEM*3/100)*1024/4));
 VP=$((($MEM*4/100)*1024/4));
 SR=$((($MEM*5/100)*1024/4));
 HP=$((($MEM*6/100)*1024/4));
 CR=$((($MEM*10/100)*1024/4));
 EP=$((($MEM*13/100)*1024/4));
 ADJ1=0; ADJ2=100; ADJ3=200; ADJ4=300; ADJ5=900; ADJ6=906 # STOCK
 MFK=$(($FP*4/5))
else
 FP=$((($MEM*3/100)*1024/4));
 VP=$((($MEM*4/100)*1024/4));
 SR=$((($MEM*5/100)*1024/4));
 HP=$((($MEM*6/100)*1024/4));
 CR=$((($MEM*10/100)*1024/4));
 EP=$((($MEM*13/100)*1024/4));
 ADJ1=0; ADJ2=117; ADJ3=235; ADJ4=411; ADJ5=823; ADJ6=1000 # NFS
 MFK=$(($VP*4/5))
fi;

if [ -e /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk ]; then
 chmod 0666 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk;
 echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
 setprop lmk.autocalc false;
fi;
if [ -e /sys/module/lowmemorykiller/parameters/debug_level ]; then
 chmod 666 /sys/module/lowmemorykiller/parameters/debug_level;
 echo "0" > /sys/module/lowmemorykiller/parameters/debug_level;
fi;
if [ -e  /sys/module/lowmemorykiller/parameters/oom_reaper ]; then
 chmod 0666 /sys/module/lowmemorykiller/parameters/oom_reaper;
 echo "1" >  /sys/module/lowmemorykiller/parameters/oom_reaper
fi;

chmod 0666 /sys/module/lowmemorykiller/parameters/adj;
chmod 0666 /sys/module/lowmemorykiller/parameters/minfree;
echo "$ADJ1,$ADJ2,$ADJ3,$ADJ4,$ADJ5,$ADJ6" > /sys/module/lowmemorykiller/parameters/adj;
echo "$FP,$VP,$SR,$HP,$CR,$EP" > /sys/module/lowmemorykiller/parameters/minfree;

MFK1=$(($MFK/3))
sysctl -e -w vm.min_free_kbytes=$MFK;

if [ -e /proc/sys/vm/extra_free_kbytes ]; then
 sysctl -e -w vm.extra_free_kbytes=$MFK1;
 setprop sys.sysctl.extra_free_kbytes $MFK1;
fi;
echo "* Low Memory Killer = Activated *" |  tee -a $LOG;

# PROPERTY  =========================================#

if [ "$MODE" -eq "2" ]; then
setprop MIN_HIDDEN_APPS false
setprop ACTIVITY_INACTIVE_RESET_TIME false
setprop MIN_RECENT_TASKS false
setprop PROC_START_TIMEOUT false
setprop CPU_MIN_CHECK_DURATION false
setprop GC_TIMEOUT false
setprop SERVICE_TIMEOUT false
setprop MIN_CRASH_INTERVAL false
setprop ENFORCE_PROCESS_LIMIT false
setprop persist.sys.NV_FPSLIMIT 90
setprop persist.sys.NV_POWERMODE 1
setprop persist.sys.NV_PROFVER 15
setprop persist.sys.NV_STEREOCTRL 0
setprop persist.sys.NV_STEREOSEPCHG 0
setprop persist.sys.NV_STEREOSEP 20
setprop persist.sys.use_16bpp_alpha 1
setprop debug.egl.swapinterval -60
echo "* Gaming Property = Activated *" |  tee -a $LOG;
elif [ "$MODE" -eq "1" ]; then
setprop MIN_HIDDEN_APPS false
setprop ACTIVITY_INACTIVE_RESET_TIME false
setprop MIN_RECENT_TASKS false
setprop PROC_START_TIMEOUT false
setprop CPU_MIN_CHECK_DURATION false
setprop GC_TIMEOUT false
setprop SERVICE_TIMEOUT false
setprop MIN_CRASH_INTERVAL false
setprop ENFORCE_PROCESS_LIMIT false
echo "* Ultra Property = Activated *" |  tee -a $LOG;
elif [ "$MODE" -eq "3" ]; then
setprop enforce_process_limit 4
echo "* Battery Saving Property = Activated *" |  tee -a $LOG;
else
setprop ENFORCE_PROCESS_LIMIT false
echo "* Balanced Property = Activated *" |  tee -a $LOG;
fi;

# CPU_BOOST  =========================================#

if [ "$MODE" -eq "2" ]; then
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "150" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* CPU Boost Input Duration = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms
  echo "150" > /sys/module/cpu_boost/parameters/input_boost_ms
  echo "* CPU Boost Input Ms = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms_s2 ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "75" > /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "* CPU Boost Input Ms_S2 = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "40" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "* CPU Boost Dyn_Stune_Boost = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "40" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "* CPU Boost Dyn_Stune_Boost = Enabled *" | tee  -a $LOG
 fi;
elif [ "$MODE" -eq "1" ]; then
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "100" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* CPU Boost Input Duration = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms
  echo "100" > /sys/module/cpu_boost/parameters/input_boost_ms
  echo "* CPU Boost Input Ms = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms_s2 ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "50" > /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "* CPU Boost Input Ms_S2 = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "30" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "* CPU Boost Dyn_Stune_Boost = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "30" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "* CPU Boost Dyn_Stune_Boost = Enabled *" | tee  -a $LOG
 fi;
elif [ "$MODE" -eq "3" ]; then
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "0" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* CPU Boost Input Duration = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms
  echo "0" > /sys/module/cpu_boost/parameters/input_boost_ms
  echo "* CPU Boost Input Ms = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms_s2 ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "0" > /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "* CPU Boost Input Ms_S2 = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "0" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "* CPU Boost Dyn_Stune_Boost = Disabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "0" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "* CPU Boost Dyn_Stune_Boost = Disabled *" | tee  -a $LOG
 fi;
else
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "60" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* CPU Boost Input Duration = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms
  echo "60" > /sys/module/cpu_boost/parameters/input_boost_ms
  echo "* CPU Boost Input Ms = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms_s2 ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "25" > /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "* CPU Boost Input Ms_S2 = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "10" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "* CPU Boost Dyn_Stune_Boost = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "10" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "* CPU Boost Dyn_Stune_Boost = Enabled *" | tee  -a $LOG
 fi;
fi;

#=========================================#

if [ -e /sys/module/msm_performance/parameters/touchboost ]; then
 chmod 0644 /sys/module/msm_performance/parameters/touchboost
 echo "0" > /sys/module/msm_performance/parameters/touchboost 
 echo "* TouchBoost MSM = Disabled *" | tee -a $LOG
fi;
if [ -e /sys/module/cpu_boost/parameters/boost_ms ]; then
 chmod 0644 /sys/module/cpu_boost/parameters/boost_ms
 echo "0" > /sys/module/cpu_boost/parameters/boost_ms
 echo "* CPU Boost Ms = Disabled *" | tee  -a $LOG
fi;
if [ -e /sys/module/cpu_boost/parameters/sched_boost_on_input ]; then
 chmod 0644 /sys/module/cpu_boost/parameters/sched_boost_on_input
 echo "N" > /sys/module/cpu_boost/parameters/sched_boost_on_input
 echo "* CPU Boost Sched = Disabled *" | tee  -a $LOG
fi;

if [ -e /sys/power/pnpmgr/touch_boost ]; then
 chmod 0644 /sys/power/pnpmgr/touch_boost 
 echo "0" > /sys/power/pnpmgr/touch_boost 
 echo "* Touch_Boost PNP = Disabled *" | tee  -a $LOG
fi; 

# I/O SCHED =========================================#

MMC=`ls -d /sys/block/mmc*`;
DM=`ls -d /sys/block/dm-*`;
SD=`ls -d /sys/block/sd*`;
LOOP=`ls -d /sys/block/loop*`;
RAM=`ls -d /sys/block/ram*`;
ZRAM=`ls -d /sys/block/zram*`;
SCH=$(cat $NFS/scheduler.txt);

if [ "$MODE" -eq "2" ]; then
 RQ=2
 NOM=0
 NR=256
 KB=$(($MEM*2/5))
elif [ "$MODE" -eq "1" ]; then
 RQ=2
 NOM=0
 NR=256
 KB=$(($MEM*2/5))
elif [ "$MODE" -eq "3" ]; then
 RQ=0
 NOM=2
 NR=64
 KB=$(($MEM*2/15))
else
 RQ=2
 NOM=0
 NR=128
 KB=$(($MEM*2/7))
fi;

for X in $MMC $SD $DM $LOOP $RAM $ZRAM
do
 echo "$SCH" > $X/queue/scheduler 2>/dev/null
 echo "0" > $X/queue/rotational 2>/dev/null
 echo "0" > $X/queue/iostats 2>/dev/null
 echo "0" > $X/queue/add_random 2>/dev/null
 echo "$NR" > $X/queue/nr_requests 2>/dev/null
 echo "$NOM" > $X/queue/nomerges 2>/dev/null
 echo "$RQ" > $X/queue/rq_affinity 2>/dev/null
 echo "$KB" > $X/queue/read_ahead_kb 2>/dev/null
 echo "0" > $X/iosched/slice_idle 2>/dev/null
done

if [ "`ls /sys/devices/virtual/bdi/179*/read_ahead_kb`" ]; then
 for RH in /sys/devices/virtual/bdi/179*/read_ahead_kb;
do 
 echo "$KB" > $RH
done
fi; 2>/dev/null;

for I in `find /sys/devices/platform -name iostats`; 
do  
 echo "0" > $I;
done
echo "* I/O Scheduler $SCH = Activated *" |  tee -a $LOG;

# CPU POWER =========================================#

CPU=/sys/devices/system/cpu
GOV=$(cat $NFS/governor.txt);

if [ -d $CPU/cpu9 ]; then
 for C in 0 1 2 3 4 5 6 7 8 9; do
  chmod 0666 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0666 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
 done;

 CORES=Deca-Core
 core=10
 ML=/sys/devices/system/cpu/cpu0/cpufreq/$GOV
 MB=/sys/devices/system/cpu/cpu5/cpufreq/$GOV
 if [ -e /sys/devices/system/cpu/cpufreq/$GOV ]; then
  ML=/sys/devices/system/cpu/cpufreq/$GOV
 fi;
elif [ -d $CPU/cpu7 ]; then
 for C in 0 1 2 3 4 5 6 7; do
  chmod 0666 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0666 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
 done;
 
 CORES=Octa-Core
 core=8
 ML=/sys/devices/system/cpu/cpu0/cpufreq/$GOV
 MB=/sys/devices/system/cpu/cpu4/cpufreq/$GOV
 if [ -e /sys/devices/system/cpu/cpufreq/$GOV ]; then
  ML=/sys/devices/system/cpu/cpufreq/$GOV
 fi;
elif [ -d $CPU/cpu5 ]; then
 for C in 0 1 2 3 4 5 ; do
  chmod 0666 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0666 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
 done;
 
 CORES=Hexa-Core
 core=6
 ML=/sys/devices/system/cpu/cpu0/cpufreq/$GOV
 MB=/sys/devices/system/cpu/cpu3/cpufreq/$GOV
 if [ -e /sys/devices/system/cpu/cpufreq/$GOV ]; then
  ML=/sys/devices/system/cpu/cpufreq/$GOV
 fi;
elif [ -d $CPU/cpu3 ]; then
 for C in 0 1 2 3; do
  chmod 0666 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0666 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
 done;
 
 CORES=Quad-Core
 core=4
 ML=/sys/devices/system/cpu/cpu0/cpufreq/$GOV
 MB=/sys/devices/system/cpu/cpu2/cpufreq/$GOV
 if [ -e /sys/devices/system/cpu/cpufreq/$GOV ]; then
  ML=/sys/devices/system/cpu/cpufreq/$GOV
 fi;
elif [ -d $CPU/cpu1 ]; then
 for C in 0 1; do
  chmod 0666 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0666 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor 
 done;
 
 CORES=Dual-Core
 core=2
 ML=/sys/devices/system/cpu/cpu0/cpufreq/$GOV
 MB=/sys/devices/system/cpu/cpu1/cpufreq/$GOV
 if [ -e /sys/devices/system/cpu/cpufreq/$GOV ]; then
  ML=/sys/devices/system/cpu/cpufreq/$GOV
 fi;
fi;

CPUBATTERY() {
if [ "$GOV" == "smurfutil_flex" ]; then
 echo "1" > $ML/pl 2>/dev/null
 echo "9" > $ML/bit_shift1 2>/dev/null
 echo "6" > $ML/bit_shift1_2 2>/dev/null
 echo "6" > $ML/bit_shift2 2>/dev/null
 echo "45" > $ML/target_load1 2>/dev/null
 echo "75" > $ML/target_load2 2>/dev/null
 echo "1" > $MB/pl 2>/dev/null
 echo "9" > $MB/bit_shift1 2>/dev/null
 echo "6" > $MB/bit_shift1_2 2>/dev/null
 echo "6" > $MB/bit_shift2 2>/dev/null
 echo "45" > $MB/target_load1 2>/dev/null
 echo "75" > $MB/target_load2 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pixutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pwrutilx" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pixel_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "helix_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "blu_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "blu_active" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "19000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "darkness" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "19000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "elementalx" ]; then
 echo "5" > $MB/down_differential 2>/dev/null
 echo "0" > $MB/gboost 2>/dev/null
 echo "0" > $MB/input_event_timeout 2>/dev/null
 echo "40000" > $MB/sampling_rate 2>/dev/null
 echo "30000" > $MB/ui_sampling_rate 2>/dev/null
 echo "99" > $MB/up_threshold 2>/dev/null
 echo "99" > $MB/up_threshold_any_cpu_load 2>/dev/null
 echo "99" > $MB/up_threshold_multi_core 2>/dev/null
 echo "5" > $ML/down_differential 2>/dev/null
 echo "0" > $ML/gboost 2>/dev/null
 echo "0" > $ML/input_event_timeout 2>/dev/null
 echo "40000" > $ML/sampling_rate 2>/dev/null
 echo "30000" > $ML/ui_sampling_rate 2>/dev/null
 echo "99" > $ML/up_threshold 2>/dev/null
 echo "99" > $ML/up_threshold_any_cpu_load 2>/dev/null
 echo "99" > $ML/up_threshold_multi_core 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "zzmoove" ]; then
 echo "85" > $MB/up_threshold 2>/dev/null
 echo "75" > $MB/smooth_up 2>/dev/null
 echo "0" > $MB/scaling_proportional 2>/dev/null
 echo "70000" $MB/sampling_rate_min 2>/dev/null
 echo "70000" $MB/sampling_rate 2>/dev/null
 echo "1" > $MB/sampling_down_factor 2>/dev/null
 echo "0" > $MB/ignore_nice_load 2>/dev/null
 echo "0" > $MB/fast_scaling_up 2>/dev/null
 echo "0" > $MB/fast_scaling_down 2>/dev/null
 echo "50" > $MB/down_threshold 2>/dev/null
 echo "85" > $ML/up_threshold 2>/dev/null
 echo "75" > $ML/smooth_up 2>/dev/null
 echo "0" > $ML/scaling_proportional 2>/dev/null
 echo "70000" $ML/sampling_rate_min 2>/dev/null
 echo "70000" $ML/sampling_rate 2>/dev/null
 echo "1" > $ML/sampling_down_factor 2>/dev/null
 echo "0" > $ML/ignore_nice_load 2>/dev/null 
 echo "0" > $ML/fast_scaling_up 2>/dev/null
 echo "0" > $ML/fast_scaling_down 2>/dev/null
 echo "50" > $ML/down_threshold 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactiveplus" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "19000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactive_pro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "19000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactivepro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "19000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactive" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "19000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactivex" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "19000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $ML/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "ondemand" ]; then
 echo "90" > $MB/up_threshold 2>/dev/null
 echo "85" > $MB/up_threshold_any_cpu_load 2>/dev/null
 echo "85" > $MB/up_threshold_multi_core 2>/dev/null
 echo "75000" > $MB/sampling_rate 2>/dev/null
 echo "2" > $MB/sampling_down_factor 2>/dev/null
 echo "10" > $MB/down_differential 2>/dev/null
 echo "35" > $MB/freq_step 2>/dev/null
 echo "90" > $ML/up_threshold 2>/dev/null
 echo "85" > $ML/up_threshold_any_cpu_load 2>/dev/null
 echo "85" > $ML/up_threshold_multi_core 2>/dev/null
 echo "75000" > $ML/sampling_rate 2>/dev/null
 echo "2" > $ML/sampling_down_factor 2>/dev/null
 echo "10" > $ML/down_differential 2>/dev/null
 echo "35" > $ML/freq_step 2>/dev/null
 TUNE=Tuned
else
TUNE=Not_Tuned
fi;

chmod 0444 $ML
chmod 0444 $MB
echo "* CPU Power $CORES $GOV = $TUNE *" |  tee -a $LOG;
}

CPUBALANCE() {
if [ "$GOV" == "smurfutil_flex" ]; then
 echo "1" > $ML/pl 2>/dev/null
 echo "6" > $ML/bit_shift1 2>/dev/null
 echo "5" > $ML/bit_shift1_2 2>/dev/null
 echo "6" > $ML/bit_shift2 2>/dev/null
 echo "40" > $ML/target_load1 2>/dev/null
 echo "75" > $ML/target_load2 2>/dev/null
 echo "1" > $MB/pl 2>/dev/null
 echo "6" > $MB/bit_shift1 2>/dev/null
 echo "5" > $MB/bit_shift1_2 2>/dev/null
 echo "6" > $MB/bit_shift2 2>/dev/null
 echo "40" > $MB/target_load1 2>/dev/null
 echo "75" > $MB/target_load2 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pixutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "0" > $MB/pl 2>/dev/null
 echo "0" > $MB/hispeed_freq 2>/dev/null
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "8000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 echo "0" > $ML/pl 2>/dev/null
 echo "0" > $ML/hispeed_freq 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pwrutilx" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "0" > $MB/pl 2>/dev/null
 echo "0" > $MB/hispeed_freq 2>/dev/null
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "8000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 echo "0" > $ML/pl 2>/dev/null
 echo "0" > $ML/hispeed_freq 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pixel_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "0" > $MB/pl 2>/dev/null
 echo "0" > $MB/hispeed_freq 2>/dev/null
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "8000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 echo "0" > $ML/pl 2>/dev/null
 echo "0" > $ML/hispeed_freq 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "helix_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "0" > $MB/pl 2>/dev/null
 echo "0" > $MB/hispeed_freq 2>/dev/null
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "8000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 echo "0" > $ML/pl 2>/dev/null
 echo "0" > $ML/hispeed_freq 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "schedutil" ]; then
 echo "1500" > $MB/up_rate_limit_us 2>/dev/null
 echo "3000" > $MB/down_rate_limit_us 2>/dev/null
 echo "1500" > $ML/up_rate_limit_us 2>/dev/null
 echo "3000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "blu_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "0" > $MB/pl 2>/dev/null
 echo "0" > $MB/hispeed_freq 2>/dev/null
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 echo "0" > $ML/pl 2>/dev/null
 echo "0" > $ML/hispeed_freq 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "blu_active" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "darkness" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "elementalx" ]; then
 echo "5" > $MB/down_differential 2>/dev/null
 echo "0" > $MB/gboost 2>/dev/null
 echo "0" > $MB/input_event_timeout 2>/dev/null
 echo "40000" > $MB/sampling_rate 2>/dev/null
 echo "30000" > $MB/ui_sampling_rate 2>/dev/null
 echo "99" > $MB/up_threshold 2>/dev/null
 echo "99" > $MB/up_threshold_any_cpu_load 2>/dev/null
 echo "99" > $MB/up_threshold_multi_core 2>/dev/null
 echo "5" > $ML/down_differential 2>/dev/null
 echo "0" > $ML/gboost 2>/dev/null
 echo "0" > $ML/input_event_timeout 2>/dev/null
 echo "40000" > $ML/sampling_rate 2>/dev/null
 echo "30000" > $ML/ui_sampling_rate 2>/dev/null
 echo "99" > $ML/up_threshold 2>/dev/null
 echo "99" > $ML/up_threshold_any_cpu_load 2>/dev/null
 echo "99" > $ML/up_threshold_multi_core 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "zzmoove" ]; then
 echo "85" > $MB/up_threshold 2>/dev/null
 echo "75" > $MB/smooth_up 2>/dev/null
 echo "0" > $MB/scaling_proportional 2>/dev/null
 echo "70000" $MB/sampling_rate_min 2>/dev/null
 echo "70000" $MB/sampling_rate 2>/dev/null
 echo "1" > $MB/sampling_down_factor 2>/dev/null
 echo "0" > $MB/ignore_nice_load 2>/dev/null
 echo "0" > $MB/fast_scaling_up 2>/dev/null
 echo "0" > $MB/fast_scaling_down 2>/dev/null
 echo "50" > $MB/down_threshold 2>/dev/null
 echo "85" > $ML/up_threshold 2>/dev/null
 echo "75" > $ML/smooth_up 2>/dev/null
 echo "0" > $ML/scaling_proportional 2>/dev/null
 echo "70000" $ML/sampling_rate_min 2>/dev/null
 echo "70000" $ML/sampling_rate 2>/dev/null
 echo "1" > $ML/sampling_down_factor 2>/dev/null
 echo "0" > $ML/ignore_nice_load 2>/dev/null
 echo "0" > $ML/fast_scaling_up 2>/dev/null
 echo "0" > $ML/fast_scaling_down 2>/dev/null
 echo "50" > $ML/down_threshold 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactiveplus" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactive_pro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactivepro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactive" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactivex" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "ondemand" ]; then
 echo "90" > $MB/up_threshold 2>/dev/null
 echo "85" > $MB/up_threshold_any_cpu_load 2>/dev/null
 echo "85" > $MB/up_threshold_multi_core 2>/dev/null
 echo "75000" > $MB/sampling_rate 2>/dev/null
 echo "2" > $MB/sampling_down_factor 2>/dev/null
 echo "10" > $MB/down_differential 2>/dev/null
 echo "35" > $MB/freq_step 2>/dev/null
 echo "90" > $ML/up_threshold 2>/dev/null
 echo "85" > $ML/up_threshold_any_cpu_load 2>/dev/null
 echo "85" > $ML/up_threshold_multi_core 2>/dev/null
 echo "75000" > $ML/sampling_rate 2>/dev/null
 echo "2" > $ML/sampling_down_factor 2>/dev/null
 echo "10" > $ML/down_differential 2>/dev/null
 echo "35" > $ML/freq_step 2>/dev/null
 TUNE=Tuned
else
TUNE=Not_Tuned
fi;

chmod 0444 $ML
chmod 0444 $MB
echo "* CPU Power $CORES $GOV = $TUNE *" |  tee -a $LOG;
}

CPUULTRA() {
if [ "$GOV" == "smurfutil_flex" ]; then
 echo "1" > $ML/pl 2>/dev/null
 echo "3" > $ML/bit_shift1 2>/dev/null
 echo "2" > $ML/bit_shift1_2 2>/dev/null
 echo "10" > $ML/bit_shift2 2>/dev/null
 echo "25" > $ML/target_load1 2>/dev/null
 echo "75" > $ML/target_load2 2>/dev/null
 echo "1" > $MB/pl 2>/dev/null
 echo "3" > $MB/bit_shift1 2>/dev/null
 echo "2" > $MB/bit_shift1_2 2>/dev/null
 echo "10" > $MB/bit_shift2 2>/dev/null
 echo "25" > $MB/target_load1 2>/dev/null
 echo "75" > $MB/target_load2 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pixutil" ]; then
 echo "2000" > $MB/up_rate_limit_us 2>/dev/null
 echo "5000" > $MB/down_rate_limit_us 2>/dev/null
 echo "2000" > $ML/up_rate_limit_us 2>/dev/null
 echo "5000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pwrutilx" ]; then
 echo "2000" > $MB/up_rate_limit_us 2>/dev/null
 echo "5000" > $MB/down_rate_limit_us 2>/dev/null
 echo "2000" > $ML/up_rate_limit_us 2>/dev/null
 echo "5000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pixel_schedutil" ]; then
 echo "2000" > $MB/up_rate_limit_us 2>/dev/null
 echo "5000" > $MB/down_rate_limit_us 2>/dev/null
 echo "2000" > $ML/up_rate_limit_us 2>/dev/null
 echo "5000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "helix_schedutil" ]; then
 echo "2000" > $MB/up_rate_limit_us 2>/dev/null
 echo "5000" > $MB/down_rate_limit_us 2>/dev/null
 echo "2000" > $ML/up_rate_limit_us 2>/dev/null
 echo "5000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "schedutil" ]; then
 echo "2000" > $MB/up_rate_limit_us 2>/dev/null
 echo "5000" > $MB/down_rate_limit_us 2>/dev/null
 echo "2000" > $ML/up_rate_limit_us 2>/dev/null
 echo "5000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "blu_active" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "99" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "99" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "darkness" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "99" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "99" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "elementalx" ]; then
 echo "5" > $MB/down_differential 2>/dev/null
 echo "0" > $MB/gboost 2>/dev/null
 echo "0" > $MB/input_event_timeout 2>/dev/null
 echo "40000" > $MB/sampling_rate 2>/dev/null
 echo "30000" > $MB/ui_sampling_rate 2>/dev/null
 echo "99" > $MB/up_threshold 2>/dev/null
 echo "99" > $MB/up_threshold_any_cpu_load 2>/dev/null
 echo "99" > $MB/up_threshold_multi_core 2>/dev/null
 echo "5" > $ML/down_differential 2>/dev/null
 echo "0" > $ML/gboost 2>/dev/null
 echo "0" > $ML/input_event_timeout 2>/dev/null
 echo "40000" > $ML/sampling_rate 2>/dev/null
 echo "30000" > $ML/ui_sampling_rate 2>/dev/null
 echo "99" > $ML/up_threshold 2>/dev/null
 echo "99" > $ML/up_threshold_any_cpu_load 2>/dev/null
 echo "99" > $ML/up_threshold_multi_core 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "zzmoove" ]; then
 echo "75" > $MB/up_threshold 2>/dev/null
 echo "75" > $MB/smooth_up 2>/dev/null
 echo "0" > $MB/scaling_proportional 2>/dev/null
 echo "60000" $MB/sampling_rate_min 2>/dev/null
 echo "60000" $MB/sampling_rate 2>/dev/null
 echo "1" > $MB/sampling_down_factor 2>/dev/null
 echo "0" > $MB/ignore_nice_load 2>/dev/null
 echo "0" > $MB/fast_scaling_up 2>/dev/null
 echo "0" > $MB/fast_scaling_down 2>/dev/null
 echo "30" > $MB/down_threshold 2>/dev/null
 echo "75" > $ML/up_threshold 2>/dev/null
 echo "75" > $ML/smooth_up 2>/dev/null
 echo "0" > $ML/scaling_proportional 2>/dev/null
 echo "60000" $ML/sampling_rate_min 2>/dev/null
 echo "60000" $ML/sampling_rate 2>/dev/null
 echo "1" > $ML/sampling_down_factor 2>/dev/null
 echo "0" > $ML/ignore_nice_load 2>/dev/null 
 echo "0" > $ML/fast_scaling_up 2>/dev/null
 echo "0" > $ML/fast_scaling_down 2>/dev/null
 echo "30" > $ML/down_threshold 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactiveplus" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "99" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "99" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactive_pro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "99" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "99" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactivepro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "99" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "99" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactive" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "99" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "99" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactivex" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "99" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
 echo "80000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "99" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "ondemand" ]; then
 echo "90" > $MB/up_threshold 2>/dev/null
 echo "85" > $MB/up_threshold_any_cpu_load 2>/dev/null
 echo "85" > $MB/up_threshold_multi_core 2>/dev/null
 echo "75000" > $MB/sampling_rate 2>/dev/null
 echo "2" > $MB/sampling_down_factor 2>/dev/null
 echo "10" > $MB/down_differential 2>/dev/null
 echo "35" > $MB/freq_step 2>/dev/null
 echo "90" > $ML/up_threshold 2>/dev/null
 echo "85" > $ML/up_threshold_any_cpu_load 2>/dev/null
 echo "85" > $ML/up_threshold_multi_core 2>/dev/null
 echo "75000" > $ML/sampling_rate 2>/dev/null
 echo "2" > $ML/sampling_down_factor 2>/dev/null
 echo "10" > $ML/down_differential 2>/dev/null
 echo "35" > $ML/freq_step 2>/dev/null
 TUNE=Tuned
else
TUNE=Not_Tuned
fi;

chmod 0444 $ML
chmod 0444 $MB
echo "* CPU Power $CORES $GOV = $TUNE *" |  tee -a $LOG;
}

CPUGAME() {
if [ "$GOV" == "smurfutil_flex" ]; then
 echo "1" > $ML/pl 2>/dev/null
 echo "6" > $ML/bit_shift1 2>/dev/null
 echo "5" > $ML/bit_shift1_2 2>/dev/null
 echo "6" > $ML/bit_shift2 2>/dev/null
 echo "40" > $ML/target_load1 2>/dev/null
 echo "75" > $ML/target_load2 2>/dev/null
 echo "1" > $MB/pl 2>/dev/null
 echo "6" > $MB/bit_shift1 2>/dev/null
 echo "5" > $MB/bit_shift1_2 2>/dev/null
 echo "6" > $MB/bit_shift2 2>/dev/null
 echo "40" > $MB/target_load1 2>/dev/null
 echo "75" > $MB/target_load2 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pixutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "0" > $MB/pl 2>/dev/null
 echo "0" > $MB/hispeed_freq 2>/dev/null
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "8000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 echo "0" > $ML/pl 2>/dev/null
 echo "0" > $ML/hispeed_freq 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pwrutilx" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "0" > $MB/pl 2>/dev/null
 echo "0" > $MB/hispeed_freq 2>/dev/null
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "8000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 echo "0" > $ML/pl 2>/dev/null
 echo "0" > $ML/hispeed_freq 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "pixel_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "0" > $MB/pl 2>/dev/null
 echo "0" > $MB/hispeed_freq 2>/dev/null
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "8000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 echo "0" > $ML/pl 2>/dev/null
 echo "0" > $ML/hispeed_freq 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "helix_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "0" > $MB/pl 2>/dev/null
 echo "0" > $MB/hispeed_freq 2>/dev/null
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "8000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 echo "0" > $ML/pl 2>/dev/null
 echo "0" > $ML/hispeed_freq 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "schedutil" ]; then
 echo "1500" > $MB/up_rate_limit_us 2>/dev/null
 echo "3000" > $MB/down_rate_limit_us 2>/dev/null
 echo "1500" > $ML/up_rate_limit_us 2>/dev/null
 echo "3000" > $ML/down_rate_limit_us 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "blu_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "0" > $MB/pl 2>/dev/null
 echo "0" > $MB/hispeed_freq 2>/dev/null
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 echo "0" > $ML/pl 2>/dev/null
 echo "0" > $ML/hispeed_freq 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "blu_active" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "darkness" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "elementalx" ]; then
 echo "5" > $MB/down_differential 2>/dev/null
 echo "0" > $MB/gboost 2>/dev/null
 echo "0" > $MB/input_event_timeout 2>/dev/null
 echo "40000" > $MB/sampling_rate 2>/dev/null
 echo "30000" > $MB/ui_sampling_rate 2>/dev/null
 echo "99" > $MB/up_threshold 2>/dev/null
 echo "99" > $MB/up_threshold_any_cpu_load 2>/dev/null
 echo "99" > $MB/up_threshold_multi_core 2>/dev/null
 echo "5" > $ML/down_differential 2>/dev/null
 echo "0" > $ML/gboost 2>/dev/null
 echo "0" > $ML/input_event_timeout 2>/dev/null
 echo "40000" > $ML/sampling_rate 2>/dev/null
 echo "30000" > $ML/ui_sampling_rate 2>/dev/null
 echo "99" > $ML/up_threshold 2>/dev/null
 echo "99" > $ML/up_threshold_any_cpu_load 2>/dev/null
 echo "99" > $ML/up_threshold_multi_core 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "zzmoove" ]; then
 echo "85" > $MB/up_threshold 2>/dev/null
 echo "75" > $MB/smooth_up 2>/dev/null
 echo "0" > $MB/scaling_proportional 2>/dev/null
 echo "70000" $MB/sampling_rate_min 2>/dev/null
 echo "70000" $MB/sampling_rate 2>/dev/null
 echo "1" > $MB/sampling_down_factor 2>/dev/null
 echo "0" > $MB/ignore_nice_load 2>/dev/null
 echo "0" > $MB/fast_scaling_up 2>/dev/null
 echo "0" > $MB/fast_scaling_down 2>/dev/null
 echo "50" > $MB/down_threshold 2>/dev/null
 echo "85" > $ML/up_threshold 2>/dev/null
 echo "75" > $ML/smooth_up 2>/dev/null
 echo "0" > $ML/scaling_proportional 2>/dev/null
 echo "70000" $ML/sampling_rate_min 2>/dev/null
 echo "70000" $ML/sampling_rate 2>/dev/null
 echo "1" > $ML/sampling_down_factor 2>/dev/null
 echo "0" > $ML/ignore_nice_load 2>/dev/null
 echo "0" > $ML/fast_scaling_up 2>/dev/null
 echo "0" > $ML/fast_scaling_down 2>/dev/null
 echo "50" > $ML/down_threshold 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactiveplus" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactive_pro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactivepro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactive" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "interactivex" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "20000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "50000" > $ML/min_sample_time 2>/dev/null
 echo "40000" > $ML/timer_slack 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "90" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 echo "80000" > $MB/timer_slack 2>/dev/null
 TUNE=Tuned
elif [ "$GOV" == "ondemand" ]; then
 echo "90" > $MB/up_threshold 2>/dev/null
 echo "85" > $MB/up_threshold_any_cpu_load 2>/dev/null
 echo "85" > $MB/up_threshold_multi_core 2>/dev/null
 echo "75000" > $MB/sampling_rate 2>/dev/null
 echo "2" > $MB/sampling_down_factor 2>/dev/null
 echo "10" > $MB/down_differential 2>/dev/null
 echo "35" > $MB/freq_step 2>/dev/null
 echo "90" > $ML/up_threshold 2>/dev/null
 echo "85" > $ML/up_threshold_any_cpu_load 2>/dev/null
 echo "85" > $ML/up_threshold_multi_core 2>/dev/null
 echo "75000" > $ML/sampling_rate 2>/dev/null
 echo "2" > $ML/sampling_down_factor 2>/dev/null
 echo "10" > $ML/down_differential 2>/dev/null
 echo "35" > $ML/freq_step 2>/dev/null
 TUNE=Tuned
else
TUNE=Not_Tuned
fi;

chmod 0444 $ML
chmod 0444 $MB
echo "* CPU Power $CORES $GOV = $TUNE *" |  tee -a $LOG;
}

if [ "$MODE" -eq "2" ]; then
 CPUGAME
elif [ "$MODE" -eq "1" ]; then
 CPUULTRA
elif [ "$MODE" -eq "3" ]; then
 CPUBATTERY
else
 CPUBALANCE
fi;

# DALVIK TUNER =========================================#

current1=$(getprop dalvik.vm.dex2oat-threads)
current2=$(getprop dalvik.vm.boot-dex2oat-threads)
current3=$(getprop persist.dalvik.vm.dex2oat-threads)

if [ ! "$current1" = "" ]; then
 if [ $core -eq 10 ]; then
  setprop dalvik.vm.dex2oat-threads 8
 elif [ $core -eq 8 ]; then
  setprop dalvik.vm.dex2oat-threads 6
 elif [ $core -eq 6 ]; then
  setprop dalvik.vm.dex2oat-threads 4
 elif [ $core -eq 4 ]; then
  setprop dalvik.vm.dex2oat-threads 2
 elif [ $core -eq 2 ]; then
  setprop dalvik.vm.dex2oat-threads 1
 fi;
 echo "* Dalvik Tuner Dex2oat = Activated *" |  tee -a $LOG;
fi;

if [ ! "$current2" = "" ]; then
 if [ $core -eq 10 ]; then
  setprop dalvik.vm.boot-dex2oat-threads 8
 elif [ $core -eq 8 ]; then
  setprop dalvik.vm.boot-dex2oat-threads 6
 elif [ $core -eq 6 ]; then
  setprop dalvik.vm.boot-dex2oat-threads 4
 elif [ $core -eq 4 ]; then
  setprop dalvik.vm.boot-dex2oat-threads 2
 elif [ $core -eq 2 ]; then
  setprop dalvik.vm.boot-dex2oat-threads 1
 fi;
 echo "* Dalvik Tuner Dex2oat Boot = Activated *" |  tee -a $LOG;
fi;

if [ ! "$current3" = "" ]; then
 if [ $core -eq 10 ]; then
  setprop persist.dalvik.vm.dex2oat-threads 8
 elif [ $core -eq 8 ]; then
  setprop persist.dalvik.vm.dex2oat-threads 6
 elif [ $core -eq 6 ]; then
  setprop persist.dalvik.vm.dex2oat-threads 4
 elif [ $core -eq 4 ]; then
  setprop persist.dalvik.vm.dex2oat-threads 2
 elif [ $core -eq 2 ]; then
  setprop persist.dalvik.vm.dex2oat-threads 1
 fi;
 echo "* Dalvik Tuner Pers Dex2oat = Activated *" |  tee -a $LOG;
fi;

# ZRAM ZSWAP CONFIGURATION =========================================#
# Function 

swapOFF() {
if [ -e /dev/block/zram0 ]; then
 swapoff /dev/block/zram0
 setprop vnswap.enabled false
 setprop ro.config.zram false
 setprop ro.config.zram.support false
 setprop zram.disksize 0
 echo "* ZRAM0 = Disabled *" |  tee -a $LOG;
fi;
if [ -e /dev/block/zram1 ]; then
 swapoff /dev/block/zram1
 setprop vnswap.enabled false
 setprop ro.config.zram false
 setprop ro.config.zram.support false
 setprop zram.disksize 0
 echo "* ZRAM1 = Disabled *" |  tee -a $LOG;
fi;
if [ -e /dev/block/zram2 ]; then
 swapoff /dev/block/zram2
 setprop vnswap.enabled false
 setprop ro.config.zram false
 setprop ro.config.zram.support false
 setprop zram.disksize 0
 echo "* ZRAM2 = Disabled *" |  tee -a $LOG;
fi;
}

swapON() {
if [ -e /dev/block/zram0 ]; then
 swapoff /dev/block/zram0
 echo "1" > /sys/block/zram0/reset
 echo "$((ZR*1024*1024))" > /sys/block/zram0/disksize 
 mkswap /dev/block/zram0
 swapon /dev/block/zram0
 sysctl -e -w vm.swappiness=20
 setprop vnswap.enabled true
 setprop ro.config.zram true
 setprop ro.config.zram.support true
 setprop zram.disksize $ZR
 echo "* ZRAM0 = Activated for $ZR MB *" |  tee -a $LOG;
fi;
if [ -e /dev/block/zram1 ]; then
 swapoff /dev/block/zram1
 echo "1" > /sys/block/zram1/reset
 echo "$((ZR*1024*1024))" > /sys/block/zram1/disksize 
 mkswap /dev/block/zram1
 swapon /dev/block/zram1
 sysctl -e -w vm.swappiness=20
 setprop vnswap.enabled true
 setprop ro.config.zram true
 setprop ro.config.zram.support true
 setprop zram.disksize $ZR
 echo "* ZRAM1 = Activated for $ZR MB *" |  tee -a $LOG;
fi;
if [ -e /dev/block/zram2 ]; then
 swapoff /dev/block/zram2
 echo "1" > /sys/block/zram2/reset
 echo "$((ZR*1024*1024))" > /sys/block/zram2/disksize 
 mkswap /dev/block/zram2
 swapon /dev/block/zram2
 sysctl -e -w vm.swappiness=20
 setprop vnswap.enabled true
 setprop ro.config.zram true
 setprop ro.config.zram.support true
 setprop zram.disksize $ZR
 echo "* ZRAM2 = Activated for $ZR MB *" |  tee -a $LOG;
fi;
}

zswapON() {
if [ -e /sys/module/zswap/parameters/enabled ]; then
 if [ -e /sys/module/zswap/parameters/enabled ]; then
  echo "Y" > /sys/module/zswap/parameters/enabled
 fi;
 if [ -e /sys/module/zswap/parameters/max_pool_percent ]; then
  echo "30" > /sys/module/zswap/parameters/max_pool_percent
 fi;
 sysctl -e -w vm.swappiness=30
 echo "* ZSwap = Activated *" |  tee -a $LOG; 
fi;
}

zswapOFF() {
if [ -e /sys/module/zswap/parameters/enabled ]; then
 echo "N" > /sys/module/zswap/parameters/enabled
 echo "* ZSwap = Disabled *" |  tee -a $LOG; 
fi;
}
 
if [ "$MODE" -eq "2" ]; then
 ZR=$(($MEM/2))
elif [ "$MODE" -eq "1" ]; then
 ZR=$(($MEM/2))
elif [ "$MODE" -eq "3" ]; then
 ZR=$(($MEM/4))
else
 ZR=$(($MEM/3))
fi;
 
if [ "$CP" -eq "1" ]; then
 swapON 2>/dev/null
 zswapON 2>/dev/null
elif [ "$CP" -eq "2" ]; then
 swapOFF 2>/dev/null
 zswapOFF 2>/dev/null
elif [ "$CP" -eq "0" ]; then
 if [ "$RAMCAP" -eq "0" ]; then
  swapON 2>/dev/null
  zswapON 2>/dev/null
 else
  swapOFF 2>/dev/null
  zswapOFF 2>/dev/null
 fi;
fi;

if [ -e /sys/kernel/mm/uksm/run ]; then
 echo "0" > /sys/kernel/mm/uksm/run;
 setprop ro.config.ksm.support false;
 echo "* UKSM = Disabled *" |  tee -a $LOG; 
elif [ -e /sys/kernel/mm/ksm/run ]; then
 echo "0" > /sys/kernel/mm/ksm/run;
 setprop ro.config.ksm.support false;
 echo "* KSM = Disabled *" |  tee -a $LOG;
fi;

# DEEP SLEEP ENHANCEMENT =========================================#

for i in $(ls /sys/class/scsi_disk/); do
 echo "temporary none" > /sys/class/scsi_disk/"$i"/cache_type
 if [ -e /sys/class/scsi_disk/"$i"/cache_type ]; then
  DP=1
 fi;
done

if [ "$DP" -eq "1" ]; then
 echo "* Deep Sleep Enhancement = Fixed *" |  tee -a $LOG;
fi;

# KERNEL TASK  =========================================#
 
if [ -e /sys/kernel/debug/sched_features ]; then
 echo "NO_GENTLE_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features
 echo "ARCH_POWER" > /sys/kernel/debug/sched_features
 echo "* Kernel Task Scheduler = Disabled *" |  tee -a $LOG;
fi;

# NETWORK SPEED =========================================#

CC=$(cat $NFS/tcp.txt);
echo "$CC" > /proc/sys/net/ipv4/tcp_congestion_control 
sysctl -e -w net.ipv4.tcp_timestamps=0
sysctl -e -w net.ipv4.tcp_sack=1
sysctl -e -w net.ipv4.tcp_fack=1
sysctl -e -w net.ipv4.tcp_window_scaling=1
echo "* Network TCP $CC = Activated *" |  tee -a $LOG;

# GUARD / CLOUDFLARE / GOOGLE =========================================#

if [ $DNS -eq "1" ]; then
 # GUARD
 # IPTABLE 
 iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to 176.103.130.130:5353
 iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to 176.103.130.130:5353
 iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to 176.103.130.131:5353
 iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to 176.103.130.131:5353
 ip6tables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to [2a00:5a60::ad1:0ff]:5353
 ip6tables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to [2a00:5a60::ad1:0ff]:5353
 ip6tables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to [2a00:5a60::ad2:0ff]:5353
 ip6tables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to [2a00:5a60::ad2:0ff]:5353
 # SETPROP 
 setprop net.eth0.dns1 176.103.130.130
 setprop net.eth0.dns2 176.103.130.131
 setprop net.dns1 176.103.130.130
 setprop net.dns2 176.103.130.131
 setprop net.ppp0.dns1 176.103.130.130
 setprop net.ppp0.dns2 176.103.130.131
 setprop net.rmnet0.dns1 176.103.130.130
 setprop net.rmnet0.dns2 176.103.130.131
 setprop net.rmnet1.dns1 176.103.130.130
 setprop net.rmnet1.dns2 176.103.130.131
 setprop net.rmnet2.dns1 176.103.130.130
 setprop net.rmnet2.dns2 176.103.130.131
 setprop net.pdpbr1.dns1 176.103.130.130
 setprop net.pdpbr1.dns2 176.103.130.131
 setprop net.wlan0.dns1 176.103.130.130
 setprop net.wlan0.dns2 176.103.130.131
 setprop 2a00:5a60::ad1:0ff:5353
 setprop 2a00:5a60::ad2:0ff:5353
 echo "* Guard DNS = Enabled *" | tee -a $LOG;
elif [ $DNS -eq "2" ]; then
 # CLOUDFLARE
 # IPTABLE 
 iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to 1.0.0.1:53
 iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to 1.0.0.1:53
 iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to 1.1.1.1:53
 iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to 1.1.1.1:53
 ip6tables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to  2606:4700:4700::1111
 ip6tables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to  2606:4700:4700::1001
 ip6tables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to  2606:4700:4700::1111
 ip6tables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to  2606:4700:4700::1001
 # SETPROP
 setprop net.eth0.dns1 1.1.1.1
 setprop net.eth0.dns2 1.0.0.1
 setprop net.dns1 1.1.1.1
 setprop net.dns2 1.0.0.1
 setprop net.ppp0.dns1 1.1.1.1
 setprop net.ppp0.dns2 1.0.0.1
 setprop net.rmnet0.dns1 1.1.1.1
 setprop net.rmnet0.dns2 1.0.0.1
 setprop net.rmnet1.dns1 1.1.1.1
 setprop net.rmnet1.dns2 1.0.0.1
 setprop net.rmnet2.dns1 1.1.1.1
 setprop net.rmnet2.dns2 1.0.0.1
 setprop net.pdpbr1.dns1 1.1.1.1
 setprop net.pdpbr1.dns2 1.0.0.1 
 setprop net.wlan0.dns1 1.1.1.1
 setprop net.wlan0.dns2 1.0.0.1
 setprop 2606:4700:4700::1111
 setprop 2606:4700:4700::1001
 echo "* CloudFlare DNS = Enabled *" | tee -a $LOG;
elif [ $DNS -eq "3" ]; then
 # GOOGLE
 # IPTABLE 
 iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to 8.8.8.8:53
 iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to 8.8.4.4:53
 iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to 8.8.8.8:53
 iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to 8.8.4.4:53
 ip6tables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to 2001:4860:4860:8888
 ip6tables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to 2001:4860:4860:8888
 ip6tables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to 2001:4860:4860:8844
 ip6tables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to 2001:4860:4860:8844
 # SETPROP
 setprop net.eth0.dns1 8.8.8.8
 setprop net.eth0.dns2 8.8.4.4
 setprop net.dns1 8.8.8.8
 setprop net.dns2 8.8.4.4
 setprop net.ppp0.dns1 8.8.8.8
 setprop net.ppp0.dns2 8.8.4.4
 setprop net.rmnet0.dns1 8.8.8.8
 setprop net.rmnet0.dns2 8.8.4.4
 setprop net.rmnet1.dns1 8.8.8.8
 setprop net.rmnet1.dns2 8.8.4.4
 setprop net.rmnet2.dns1 8.8.8.8
 setprop net.rmnet2.dns2 8.8.4.4
 setprop net.pdpbr1.dns1 8.8.8.8
 setprop net.pdpbr1.dns2 8.8.4.4
 setprop net.wlan0.dns1 8.8.8.8
 setprop net.wlan0.dns2 8.8.4.4
 setprop 2001:4860:4860::8888
 setprop 2001:4860:4860::8844
 echo "* Google Public DNS = Enabled *" | tee -a $LOG; 
elif [ $DNS -eq "5" ]; then
 # VERISIGN
 # IPTABLE 
 iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to 64.6.64.6:5353
 iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to 64.6.64.6:5353
 iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to 64.6.65.6:5353
 iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to 64.6.65.6:5353
 ip6tables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to [2620:74:1b::1:1]:5353
 ip6tables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to [2620:74:1b::1:1]:5353
 ip6tables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to [2620:74:1c::2:2.]:5353
 ip6tables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to [2620:74:1c::2:2.]:5353
 # SETPROP 
 setprop net.eth0.dns1 64.6.64.6
 setprop net.eth0.dns2 64.6.65.6
 setprop net.dns1 64.6.64.6
 setprop net.dns2 64.6.65.6
 setprop net.ppp0.dns1 64.6.64.6
 setprop net.ppp0.dns2 64.6.65.6
 setprop net.rmnet0.dns1 64.6.64.6
 setprop net.rmnet0.dns2 64.6.65.6
 setprop net.rmnet1.dns1 64.6.64.6
 setprop net.rmnet1.dns2 64.6.65.6
 setprop net.rmnet2.dns1 64.6.64.6
 setprop net.rmnet2.dns2 64.6.65.6
 setprop net.pdpbr1.dns1 64.6.64.6
 setprop net.pdpbr1.dns2 64.6.65.6
 setprop net.wlan0.dns1 64.6.64.6
 setprop net.wlan0.dns2 64.6.65.6
 setprop 2620:74:1b::1:1:5353
 setprop 2620:74:1c::2:2.:5353
 echo "* Verisign DNS = Enabled *" | tee -a $LOG;
elif [ $DNS -eq "4" ]; then
 # CLEANBROWSING
 # IPTABLE 
 iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to 185.228.168.9:5353
 iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to 185.228.168.9:5353
 iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to 185.228.169.9:5353
 iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to 185.228.169.9:5353
 ip6tables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to [2a0d:2a00:1::2]:5353
 ip6tables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to [2a0d:2a00:1::2]:5353
 ip6tables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to [2a0d:2a00:2::2]:5353
 ip6tables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to [2a0d:2a00:2::2]:5353
 # SETPROP 
 setprop net.eth0.dns1 185.228.168.9
 setprop net.eth0.dns2 185.228.169.9
 setprop net.dns1 185.228.168.9
 setprop net.dns2 185.228.169.9
 setprop net.ppp0.dns1 185.228.168.9
 setprop net.ppp0.dns2 185.228.169.9
 setprop net.rmnet0.dns1 185.228.168.9
 setprop net.rmnet0.dns2 185.228.169.9
 setprop net.rmnet1.dns1 185.228.168.9
 setprop net.rmnet1.dns2 185.228.169.9
 setprop net.rmnet2.dns1 185.228.168.9
 setprop net.rmnet2.dns2 185.228.169.9
 setprop net.pdpbr1.dns1 185.228.168.9
 setprop net.pdpbr1.dns2 185.228.169.9
 setprop net.wlan0.dns1 185.228.168.9
 setprop net.wlan0.dns2 185.228.169.9
 setprop 2a0d:2a00:1::2:5353
 setprop 2a0d:2a00:2::2:5353
 echo "* CleanBrowsing DNS = Enabled *" | tee -a $LOG;
fi;	

# FIX GP SERVICES =========================================#

pm enable com.google.android.gms/.update.SystemUpdateActivity
pm enable com.google.android.gms/.update.SystemUpdateService
pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver
pm enable com.google.android.gms/.update.SystemUpdateService$Receiver
pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver
pm enable com.google.android.gsf/.update.SystemUpdateActivity
pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity
pm enable com.google.android.gsf/.update.SystemUpdateService
pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver
pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver
echo "* Fix GP Services = Activated *" |  tee -a $LOG;

# WAKELOCKS =========================================#

if [ -e /sys/module/bcmdhd/parameters/wlrx_divide ]; then
 echo "4" > /sys/module/bcmdhd/parameters/wlrx_divide 2>/dev/null
 echo "4" > /sys/module/bcmdhd/parameters/wlctrl_divide 2>/dev/null
 echo "* Wlan Wakelocks = Activated *" |  tee -a $LOG;
fi;
 
if [ -e /sys/module/wakeup/parameters/enable_bluetooth_timer ]; then
 echo "Y" > /sys/module/wakeup/parameters/enable_bluetooth_timer 2>/dev/null
 echo "N" > /sys/module/wakeup/parameters/enable_ipa_ws 2>/dev/null
 echo "Y" > /sys/module/wakeup/parameters/enable_netlink_ws 2>/dev/null
 echo "Y" > /sys/module/wakeup/parameters/enable_netmgr_wl_ws 2>/dev/null
 echo "N" > /sys/module/wakeup/parameters/enable_qcom_rx_wakelock_ws 2>/dev/null
 echo "Y" > /sys/module/wakeup/parameters/enable_timerfd_ws 2>/dev/null
 echo "N" > /sys/module/wakeup/parameters/enable_wlan_extscan_wl_ws 2>/dev/null
 echo "N" > /sys/module/wakeup/parameters/enable_wlan_wow_wl_ws 2>/dev/null
 echo "N" > /sys/module/wakeup/parameters/enable_wlan_ws 2>/dev/null
 echo "N" > /sys/module/wakeup/parameters/enable_netmgr_wl_ws 2>/dev/null
 echo "N" > /sys/module/wakeup/parameters/enable_wlan_wow_wl_ws 2>/dev/null
 echo "N" > /sys/module/wakeup/parameters/enable_wlan_ipa_ws 2>/dev/null
 echo "N" > /sys/module/wakeup/parameters/enable_wlan_pno_wl_ws 2>/dev/null
 echo "N" > /sys/module/wakeup/parameters/enable_wcnss_filter_lock_ws 2>/dev/null
 echo "* Switch Wakelocks = Activated *" |  tee -a $LOG;
fi;

if [ -e /sys/class/misc/boeffla_wakelock_blocker/wakelock_blocker ]; then
 echo "wlan_pno_wl;wlan_ipa;wcnss_filter_lock;[timerfd];hal_bluetooth_lock;IPA_WS;sensor_ind;wlan;netmgr_wl;qcom_rx_wakelock;wlan_wow_wl;wlan_extscan_wl;NETLINK" > /sys/class/misc/boeffla_wakelock_blocker/wakelock_blocker
 echo "* Boeffla_Wakelock_Blocker = Activated *" |  tee -a $LOG;
fi;

# KERNEL / MODULES / MASKS DEBUGGERS OFF =========================================#

for i in $(find /sys/ -name debug_mask); do
 echo "0" > $i
done
for i in $(find /sys/ -name debug_level); do
 echo "0" > $i
done
for i in $(find /sys/ -name edac_mc_log_ce); do
 echo "0" > $i
done
for i in $(find /sys/ -name edac_mc_log_ue); do
 echo "0" > $i
done
for i in $(find /sys/ -name enable_event_log); do
 echo "0" > $i
done
for i in $(find /sys/ -name log_ecn_error); do
 echo "0" > $i
done
for i in $(find /sys/ -name snapshot_crashdumper); do
 echo "0" > $i
done
if [ -e /sys/module/logger/parameters/log_mode ]; then
 echo "2" > /sys/module/logger/parameters/log_mode
fi;

echo "* Useless Debuggers = Disabled *" |  tee -a $LOG;

# MISC MODES =========================================#

if [ -e /sys/class/lcd/panel/power_reduce ]; then
 echo "* LCD Power = Activated *" |  tee -a $LOG	
 echo "1" > /sys/class/lcd/panel/power_reduce
fi;

if [ "$MODE" -eq "2" ]; then
 if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
  chmod 0644 /sys/module/workqueue/parameters/power_efficient
  echo "N" > /sys/module/workqueue/parameters/power_efficient
  echo "* Power Save Workqueues = Disabled *" |  tee -a $LOG; 
 fi;
 if [ -e /sys/module/adreno_idler/parameters/adreno_idler_active ]; then
  chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "0" > /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "* Adreno Idler = Disabled *" |  tee -a $LOG;  
 fi;
 if [ -e /sys/kernel/sched/arch_power ]; then
  echo "0" > /sys/kernel/sched/arch_power
  echo "* Arch Power = Disabled *" |  tee -a $LOG
 fi;
elif [ "$MODE" -eq "1" ]; then
 if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
  chmod 0644 /sys/module/workqueue/parameters/power_efficient
  echo "N" > /sys/module/workqueue/parameters/power_efficient
  echo "* Power Save Workqueues = Disabled *" |  tee -a $LOG; 
 fi;
 if [ -e /sys/module/adreno_idler/parameters/adreno_idler_active ]; then
  chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "0" > /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "* Adreno Idler = Disabled *" |  tee -a $LOG;  
 fi;
 if [ -e /sys/kernel/sched/arch_power ]; then
  echo "0" > /sys/kernel/sched/arch_power
  echo "* Arch Power = Disabled *" |  tee -a $LOG
 fi;
elif [ "$MODE" -eq "3" ]; then
 if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
  chmod 0644 /sys/module/workqueue/parameters/power_efficient
  echo "Y" > /sys/module/workqueue/parameters/power_efficient
  echo "* Power Save Workqueues = Enabled *" |  tee -a $LOG; 
 fi;
 if [ -e /sys/module/adreno_idler/parameters/adreno_idler_active ]; then
  chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "1" > /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "* Adreno Idler = Enabled *" |  tee -a $LOG;  
 fi;
 if [ -e /sys/kernel/sched/arch_power ]; then
  echo "1" > /sys/kernel/sched/arch_power
  echo "* Arch Power = Enabled *" |  tee -a $LOG
 fi;
else
 if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
  chmod 0644 /sys/module/workqueue/parameters/power_efficient
  echo "Y" > /sys/module/workqueue/parameters/power_efficient
  echo "* Power Save Workqueues = Enabled *" |  tee -a $LOG; 
 fi;
 if [ -e /sys/module/adreno_idler/parameters/adreno_idler_active ]; then
  chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "0" > /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "* Adreno Idler = Disabled *" |  tee -a $LOG;  
 fi;
 if [ -e /sys/kernel/sched/arch_power ]; then
  echo "1" > /sys/kernel/sched/arch_power
  echo "* Arch Power = Enabled *" |  tee -a $LOG
 fi;
fi;

# FAST CHARGE =========================================#

if [ "$FC" -eq "2" ]; then	
 echo "* Fast Charge 1 = Activated *" |  tee -a $LOG
elif [ "$FC" -eq "1" ]; then	
 echo "* Fast Charge 2 = Activated *" |  tee -a $LOG
fi;

if [ `cat /sys/kernel/fast_charge/screen_on_current_limit` -eq "0" ]; then	
 echo "* Screen On Current Limit = Exceeded *" |  tee -a $LOG
fi;

# FSYNC ON/OFF =========================================#

if [ "$SY" -eq "1" ]; then
 if [ -e /sys/kernel/dyn_fsync/Dyn_fsync_active ]; then
  echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_active
  echo "* Dyn Fsync Active = Enabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/class/misc/fsynccontrol/fsync_enabled ]; then
  echo "1" > /sys/class/misc/fsynccontrol/fsync_enabled
  echo "* Fsync Control = Enabled *" | tee  -a $LOG
 fi; 
 if [ -e /sys/module/sync/parameters/fsync ]; then
  echo "1" > /sys/module/sync/parameters/fsync
  echo "* Fsync = Enabled *" | tee  -a $LOG
 fi;
 if  [ -e /sys/module/sync/parameters/fsync_enabled ]; then
  echo "Y" > /sys/module/sync/parameters/fsync_enabled
  echo "* Fsync = Enabled *" | tee  -a $LOG
 fi;
else
 if [ -e /sys/kernel/dyn_fsync/Dyn_fsync_active ]; then
  echo "0" > /sys/kernel/dyn_fsync/Dyn_fsync_active
  echo "* Dyn Fsync Active = Disabled *" | tee  -a $LOG
 fi;
 if [ -e /sys/class/misc/fsynccontrol/fsync_enabled ]; then
  echo "0" > /sys/class/misc/fsynccontrol/fsync_enabled
  echo "* Fsync Control = Disabled *" | tee  -a $LOG
 fi; 
 if [ -e /sys/module/sync/parameters/fsync ]; then
  echo "0" > /sys/module/sync/parameters/fsync
  echo "* Fsync = Disabled *" | tee  -a $LOG
 fi;
 if  [ -e /sys/module/sync/parameters/fsync_enabled ]; then
  echo "N" > /sys/module/sync/parameters/fsync_enabled
  echo "* Fsync = Disabled *" | tee  -a $LOG
 fi;
fi;

# CHECK  PROCESS =========================================#

if [ `cat /proc/sys/vm/min_free_kbytes` -eq "$MFK" ] && [ `cat /proc/sys/vm/oom_kill_allocating_task` -eq "0" ]; then
 echo "* Optimization Status =  ACTIVE *" |  tee -a $LOG;
else 
 echo "* Optimization Status  = PARTIAL *" |  tee -a $LOG;
fi;

echo "" | tee -a $LOG;
echo "* END : $( date +"%m-%d-%Y %H:%M:%S" ) *" | tee -a $LOG;
echo "================================================" | tee -a $LOG;
echo "* ϟ NFS-INJECTOR(TM) ϟ *" | tee -a $LOG
echo "* Copyright(C) K1KS & Team 2019 *" | tee -a $LOG
echo "* Group t.me/nfsinjector *" | tee -a $LOG
echo "================================================" | tee -a $LOG;
exit 0
