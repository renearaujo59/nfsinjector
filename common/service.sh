#========================================
# NFS-INJECTOR
# Codename : 
# Version : 8.0
# Developer : @K1ks
Date=17-10-2019
# Testers : @HafizZiq @player65 @Apitpro @im_simple_man @AzSuperbored @KilayoRed @xlidz @HarshalRaj @TarangKarpe @chrisdrakos @Kookieya @Whiplesh @trushtushar @iSawJig @D347HW15H
# Paypal : paypal.me/k1ksxda
#========================================
# SMART CONTROL
## MODE USER ( mode.txt )
# 0 = BALANCED
# 1 = ULTRA
# 2 = GAMING
# 3 = BATTERY_SAVER
## ZRAM USER ( comp.txt )
# 0 = AUTO ( Def )
# 1 = ON
# 2 = OFF
## SYNC USER ( sync.txt )
# 0 = OFF ( Def )
# 1 = ON
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
# SUPPORT GOVERNORS = pixel_schedutil helix_schedutil smurfutil_flex pixutil pwrutilx darkness schedutil blu_schedutil blu_active zzmoove interactivepro interactiveplus interactiveX interactive phantom ondemand cultivation elementalx
# SUPPORT SCHEDULER = anxiety fiops sioplus sio zen tripndroid row bfq cfq deadline noop
# SUPPORT TCP = ascarex sociopath westwood cubic reno

# PATH LOG =========================================#

Path=/data
if [ ! -d $Path/NFS ]; then
 ST=Clean
 mkdir -p $Path/NFS
fi;
NFS=$Path/NFS
LOG=$NFS/nfs.log
V=8.0
S=STABLE
Code=INFINITE
#CodeT=A14
box=$(busybox | awk 'NR==1{print $2}') 2>/dev/null
MEM=$(free -m | awk '/Mem:/{print $2}') 2>/dev/null
mem=$(free | grep Mem |  awk '{print $2}') 2>/dev/null
VENDOR=$(getprop ro.product.brand) 2>/dev/null
ROM=$(getprop ro.build.display.id) 2>/dev/null
KERNEL=$(uname -r) 2>/dev/null
ARCH=$(grep -Eo "ro.product.cpu.abi(2)?=.+" $SYS/build.prop 2>/dev/null | grep -Eo "[^=]*$" | head -n1) 2>/dev/null
APP=$(getprop ro.product.model) 2>/dev/null
SDK=$(getprop ro.build.version.sdk) 2>/dev/null
ROOT=$(magisk -c) 2>/dev/null
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
 SOC="UNIDENTIFIED_SOC"
fi;
BATT=$(cat /sys/class/power_supply/battery/capacity)
if [ -e /sys/kernel/fast_charge/ac_charge_level ]; then
 if [ -e /sys/class/power_supply/battery/batt_slate_mode ]; then
  echo "0" > /sys/class/power_supply/battery/batt_slate_mode
 fi;
fi;

# CUTTER =========================================#
if [ -e $LOG ]; then
 rm $LOG
fi;

if [ -d /data/adb/modules ]; then
 SBIN=/data/adb/modules
elif [ -d /sbin/.core/img ]; then
 SBIN=/sbin/.core/img
elif [ -d /sbin/.magisk/img ]; then
 SBIN=/sbin/.magisk/img
fi;

BREAKER() {
echo "*...NFS WARNING...*" | tee -a $LOG;
echo "*...$IT FOUND...*" | tee -a $LOG;
echo "*...ABORTING FOR SECURITY PURPOSES...*" | tee -a $LOG;
exit 1
}

TACC=/proc/sys/net/ipv4/tcp_available_congestion_control
if [ -e /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors ]; then
 AGB=/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
elif [ -e /sys/devices/system/cpu/cpu1/cpufreq/scaling_available_governors ]; then
 AGB=/sys/devices/system/cpu/cpu1/cpufreq/scaling_available_governors
fi;
if [ -e /sys/block/mmcblk0/queue/scheduler ]; then
 SA=/sys/block/mmcblk0/queue/scheduler
elif [ -e /sys/block/sda/queue/scheduler ]; then
 SA=/sys/block/sda/queue/scheduler
elif [ -d /sys/block/dm-0/queue/scheduler ]; then
 SA=/sys/block/dm-0/queue/scheduler
elif [ -d /sys/block/loop0/queue/scheduler ]; then
 SA=/sys/block/loop0/queue/scheduler
fi;

if grep 'blu_schedutil' $AGB; then
 eas=1
elif grep 'sched' $AGB; then
 eas=1
elif grep 'pwrutil' $AGB; then
 eas=1
elif grep 'darkutil' $AGB; then
 eas=1
elif grep 'schedutil' $AGB; then
 eas=1
elif grep 'helix' $AGB; then
 eas=1
elif grep 'schedalucard' $AGB; then
 eas=1
elif grep 'electroutil' $AGB; then
 eas=1
else
 eas=0
fi;

battcheckgov() {
if grep 'blu_schedutil' $AGB; then
 gov=blu_schedutil
elif grep 'zzmoove' $AGB; then
 gov=zzmoove
elif grep 'smurfutil_flex' $AGB; then
 gov=smurfutil_flex
elif grep 'pixutil' $AGB; then
 gov=pixutil
elif grep 'pwrutilx' $AGB; then
 gov=pwrutilx
elif grep 'helix_schedutil' $AGB; then
 gov=helix_schedutil
elif grep 'pixel_schedutil' $AGB; then
 gov=pixel_schedutil
elif grep 'schedutil' $AGB; then
 gov=schedutil
elif grep 'cultivation' $AGB; then 
 gov=cultivation
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
elif grep 'darkness' $AGB; then
 gov=darkness
elif grep 'blu_active' $AGB; then
 gov=blu_active
elif grep 'phantom' $AGB; then
 gov=phantom
elif grep 'elementalx' $AGB; then
 gov=elementalx
elif grep 'ondemand' $AGB; then
 gov=ondemand
elif grep 'performance' $AGB; then
 gov=performance
fi;
}
balcheckgov() {
if grep 'smurfutil_flex' $AGB; then
 gov=smurfutil_flex
elif grep 'pixutil' $AGB; then
 gov=pixutil
elif grep 'schedutil' $AGB; then
 gov=schedutil
elif grep 'pwrutilx' $AGB; then
 gov=pwrutilx
elif grep 'helix_schedutil' $AGB; then
 gov=helix_schedutil
elif grep 'pixel_schedutil' $AGB; then
 gov=pixel_schedutil
elif grep 'interactive' $AGB; then
 gov=interactive
elif grep 'cultivation' $AGB; then
 gov=cultivation
elif grep 'interactivepro' $AGB; then
 gov=interactivepro
elif grep 'interactive_pro' $AGB; then
 gov=interactive_pro
elif grep 'interactiveplus' $AGB; then
 gov=interactiveplus
elif grep 'interactivex' $AGB; then
 gov=interactivex
elif grep 'darkness' $AGB; then
 gov=darkness
elif grep 'elementalx' $AGB; then
 gov=elementalx
elif grep 'blu_active' $AGB; then
 gov=blu_active
elif grep 'phantom' $AGB; then
 gov=phantom
elif grep 'blu_schedutil' $AGB; then
 gov=blu_schedutil
elif grep 'zzmoove' $AGB; then
 gov=zzmoove
elif grep 'ondemand' $AGB; then
 gov=ondemand
elif grep 'performance' $AGB; then
 gov=performance
fi;
}
perfcheckgov() {
if grep 'smurfutil_flex' $AGB; then
 gov=smurfutil_flex
elif grep 'pixutil' $AGB; then
 gov=pixutil
elif grep 'schedutil' $AGB; then
 gov=schedutil
elif grep 'pwrutilx' $AGB; then
 gov=pwrutilx
elif grep 'helix_schedutil' $AGB; then
 gov=helix_schedutil
elif grep 'pixel_schedutil' $AGB; then
 gov=pixel_schedutil
elif grep 'elementalx' $AGB; then
 gov=elementalx
elif grep 'interactive' $AGB; then
 gov=interactive
elif grep 'cultivation' $AGB; then
 gov=cultivation
elif grep 'interactivepro' $AGB; then
 gov=interactivepro
elif grep 'interactive_pro' $AGB; then
 gov=interactive_pro
elif grep 'interactiveplus' $AGB; then
 gov=interactiveplus
elif grep 'interactivex' $AGB; then
 gov=interactivex
elif grep 'darkness' $AGB; then
 gov=darkness
elif grep 'blu_active' $AGB; then
 gov=blu_active
elif grep 'phantom' $AGB; then
 gov=phantom
elif grep 'blu_schedutil' $AGB; then
 gov=blu_schedutil
elif grep 'zzmoove' $AGB; then
 gov=zzmoove
elif grep 'ondemand' $AGB; then
 gov=ondemand
elif grep 'performance' $AGB; then
 gov=performance
fi;
}
battcheckio() {
if grep 'anxiety' $SA; then
 sch=anxiety
elif grep 'maple' $SA; then
 sch=maple
elif grep 'zen' $SA; then
 sch=zen
elif grep 'noop' $SA; then
 sch=noop
elif grep 'tripndroid' $SA; then
 sch=tripndroid
elif grep 'row' $SA; then
 sch=row
elif grep 'deadline' $SA; then
 sch=deadline
elif grep 'cfq' $SA; then
 sch=cfq
elif grep 'bfq' $SA; then
 sch=bfq
fi;
}
balcheckio() {
if grep 'tripndroid' $SA; then
 sch=tripndroid
elif grep 'cfq' $SA; then
 sch=cfq
elif grep 'row' $SA; then
 sch=row
elif grep 'bfq' $SA; then
 sch=bfq
elif grep 'deadline' $SA; then
 sch=deadline
elif grep 'anxiety' $SA; then
 sch=anxiety
elif grep 'maple' $SA; then
 sch=maple
elif grep 'zen' $SA; then
 sch=zen
elif grep 'noop' $SA; then
 sch=noop
fi;
}
perfcheckio() {
if grep 'sioplus' $SA; then
 sch=sioplus
elif grep 'deadline' $SA; then
 sch=deadline
elif grep 'cfq' $SA; then
 sch=cfq
elif grep 'row' $SA; then
 sch=row
elif grep 'tripndroid' $SA; then
 sch=tripndroid
elif grep 'bfq' $SA; then
 sch=bfq
elif grep 'anxiety' $SA; then
 sch=anxiety
elif grep 'maple' $SA; then
 sch=maple
elif grep 'zen' $SA; then
 sch=zen
elif grep 'noop' $SA; then
 sch=noop
fi;
}
if grep -l 'ascarex' $TACC; then
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

# CHECK BREAKER =========================================#

if [ -d $SBIN/legendary_kernel_tweaks ]; then
 IT=LKT_MODULE
 BREAKER
elif [ -d $SBIN/FDE ]; then
 IT=FDE.AI
 BREAKER
elif [ -d /data/app/v.uni* ]; then
 IT=VULMAX
 BREAKER
elif [ -d $SBIN/MAGNETAR ]; then
 IT=MAGNETAR
 BREAKER
fi;

# SMART CONTROL  =========================================#

if [ "$MEM" -lt 2048 ]; then
 RAMCAP=0
 level=0
 stage=Low_Ram
elif [ "$MEM" -lt 2560 ]; then
 RAMCAP=1
 level=1
 stage=Middle_Range
elif [ "$MEM" -lt 3840 ]; then
 RAMCAP=1
 level=2
 stage=Middle_Range
elif [ "$MEM" -lt 5120 ]; then
 RAMCAP=1
 level=3
 stage=High_Ram
elif [ "$MEM" -lt 6400 ]; then
 RAMCAP=1
 level=4
 stage=Flagship
else
 RAMCAP=1
 level=4
 stage=Flagship_Killer
fi;

if [ -d /data/data/com.FDGEntertainment.Oceanhorn.gp ]; then
 play=1
elif [ -d /data/data/com.ironhidegames.android.ironmarines ]; then
 play=1
elif [ -d /data/data/com.ironhidegames.android.kingdomrush4 ]; then
 play=1
elif [ -d /data/data/com.bandainamcoent.dblegends_ww ]; then
 play=1
elif [ -d /data/data/com.ea.games.r3_row ]; then
 play=1
elif [ -d /data/data/com.epicgames.fortnite ]; then
 play=1
elif [ -d /data/data/com.jagex.runescape.android ]; then
 play=1
elif [ -d /data/data/com.nianticlabs.pokemongo ]; then
 play=1
elif [ -d /data/data/com.namcobandaigames.pacmantournaments ]; then
 play=1
elif [ -d /data/data/com.nintendo.zara ]; then
 play=1
elif [ -d /data/data/com.supercell.clashroyale ]; then
 play=1
elif [ -d /data/data/com.supercell.clashofclans ]; then
 play=1
elif [ -d /data/data/jp.konami.pesam ]; then
 play=1
elif [ -d /data/data/com.lilithgame.roc.gp ]; then
 play=1
elif [ -d /data/data/com.supercell.brawlstars ]; then
 play=1
elif [ -d /data/data/com.activision.callofduty.shooter ]; then
 play=1
elif [ -d /data/data/com.garena.game.codm ]; then
 play=1
elif [ -d /data/data/com.nintendo.zaga ]; then
 play=1
elif [ -d /data/data/com.netmarble.revolutionthm ]; then
 play=1
elif [ -d /data/data/com.neowiz.game.koh ]; then
 play=1
elif [ -d /data/data/com.fours.rrre ]; then
 play=1
elif [ -d /data/data/com.dts.freefireth ]; then
 play=1
elif [ -d /data/data/com.robtopx.geometryjump ]; then
 play=1
elif [ -d /data/data/com.t2ksports.nba2k19 ]; then
 play=1
elif [ -d /data/data/com.squareenixmontreal.hitmansniperandroid ]; then
 play=1
elif [ -d /data/data/com.vg.bsm ]; then
 play=1
elif [ -d /data/data/com.nekki.shadowfight3 ]; then
 play=1
elif [ -d /data/data/com.nekki.shadowfight ]; then
 play=1
elif [ -d /data/data/com.ea.game.nfs14_row ]; then
 play=1
elif [ -d /data/data/com.FireproofStudios.TheRoom4 ]; then
 play=1
elif [ -d /data/data/com.netease.lztgglobal ]; then
 play=1
elif [ -d /data/data/com.gameloft.android.ANMP.GloftA9HM ]; then
 play=1
elif [ -d /data/data/com.theonegames.gunshipbattle ]; then
 play=1
elif [ -d /data/app/com.tencent* ]; then
 play=1
elif [ -d /data/app/com.pubg* ]; then
 play=1
elif [ -d /data/app/com.rekoo* ]; then
 play=1
elif [ -d /data/data/com.mobile.legends ]; then
 play=1
else
 play=0
fi;

if [ $level -eq "0" ] && [ $play -eq "0" ]; then
 land=1
elif [ $level -eq "0" ] && [ $play -eq "1" ]; then
 land=2
elif [ $level -eq "1" ] && [ $play -eq "0" ]; then
 land=0
elif [ $level -eq "1" ] && [ $play -eq "1" ]; then
 land=1
elif [ $level -eq "2" ] && [ $play -eq "0" ]; then
 land=1
elif [ $level -eq "2" ] && [ $play -eq "1" ]; then
 land=1
elif [ $level -eq "3" ] && [ $play -eq "0" ]; then
 land=0
elif [ $level -eq "3" ] && [ $play -eq "1" ]; then
 land=1
elif [ $level -eq "4" ] && [ $play -eq "0" ]; then
 land=3
elif [ $level -eq "4" ] && [ $play -eq "1" ]; then
 land=0
fi;

if [ $land -eq "0" ]; then
 balcheckgov
 balcheckio
elif [ $land -eq "1" ]; then
 perfcheckgov
 perfcheckio
elif [ $land -eq "2" ]; then
 perfcheckgov
 perfcheckio
elif [ $land -eq "3" ]; then
 battcheckgov
 battcheckio
fi;

# WAITING TIME =========================================#

while ! pgrep com.android; do
 sleep 100
done

# SETTINGS =========================================#

if [ ! -e $NFS/governor.txt ]; then
 echo "$gov" > $NFS/governor.txt
fi;
if [ ! -e $NFS/scheduler.txt ]; then
 echo "$sch" > $NFS/scheduler.txt
fi;
if [ ! -e $NFS/tcp.txt ]; then
 echo "$tcp" > $NFS/tcp.txt
fi;
if [ ! -e $NFS/mode.txt ]; then
 echo "$land" > $NFS/mode.txt
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

if [ ! -e $NFS/support.txt ]; then
 SP=$NFS/support.txt
 echo "** GOVERNOR'S AVAILABLE : $(cat $AGB) *" | tee -a $SP;
 echo "" | tee -a $SP;
 echo "** SCHEDULER'S AVAILABLE : $(cat $SA) *" | tee -a $SP;
 echo "" | tee -a $SP;
 echo "** TCP'S AVAILABLE : $(cat $TACC) *" | tee -a $SP;
fi;

# LOGGING =========================================#

echo "================================================" | tee -a $LOG;
echo "//////// ⚡ NFS-INJECTOR(TM) LOGGING SYSTEM ⚡ ~~ " | tee -a $LOG;
echo "//////// UNIVERSAL MAGISK MODULE ~~ " | tee -a $LOG;
echo "//////// CodeName : $Code ~~ " | tee -a $LOG;
#echo "//////// CodeTest : $CodeT ~~ " | tee -a $LOG;
echo "//////// Version : $V ~~ " | tee -a $LOG;
echo "//////// Status : $S ~~ " | tee -a $LOG;
if [ "$ST" == "Clean" ]; then
 echo "//////// Flash : $ST ~~ " | tee -a $LOG;
fi;
echo "//////// Date : $Date ~~ " | tee -a $LOG;
echo "================================================" | tee -a $LOG;
echo "" | tee -a $LOG;
echo "** DEVICE CONFIGURATION *" | tee -a $LOG;
echo "** VENDOR : $VENDOR *" | tee -a $LOG;
echo "** DEVICE : $APP *" | tee -a $LOG;
echo "** SOC : $SOC *" | tee -a $LOG;
echo "** TYPE : $stage *" | tee -a $LOG;
echo "** ROM : $ROM *" | tee -a $LOG;
echo "** AARCH : $ARCH *" | tee -a $LOG;
echo "** ROOT : $ROOT *" | tee -a $LOG;
echo "** ANDROID : $(getprop ro.build.version.release) *" | tee -a $LOG;
echo "** SDK : $SDK *" | tee -a $LOG;
echo "** KERNEL : $KERNEL *" | tee -a $LOG;
echo "** RAM : $MEM Mb *" | tee -a $LOG;
echo "** BUSYBOX : $box *" | tee -a $LOG;
echo "** BATTERY LEVEL : $BATT % *" | tee -a $LOG;

if [ -d /data/data/com.kerneladiutor.mod ]; then
 echo "** KERNEL ADIUTOR MOD : INSTALLED *" | tee -a $LOG;
fi;
if [ -d /data/data/com.grarak.kerneladiutor ]; then
 echo "** KERNEL ADIUTOR : INSTALLED *" | tee -a $LOG;
fi;
if [ -d /data/data/flar2.exkernelmanager ]; then
 echo "** EX KERNEL MANAGER : INSTALLED *" | tee -a $LOG;
fi;
if [ -d /data/app/com.paget96.lspeedoptimizer* ]; then
 echo "**...NFS WARNING...*" | tee -a $LOG;
 echo "**...LSPEED APP FOUND...*" | tee -a $LOG;
 echo "**...USE BOTH AT YOUR OWN RISK...*" | tee -a $LOG;
 echo "" | tee -a $LOG;
elif [ -d /data/app/com.paget96.lspeed* ]; then
 echo "**...NFS WARNING...*" | tee -a $LOG;
 echo "**...LSPEED APP FOUND...*" | tee -a $LOG;
 echo "**...USE BOTH AT YOUR OWN RISK...*" | tee -a $LOG;
 echo "" | tee -a $LOG;
fi;
if [ -d /data/data/com.FDGEntertainment.Oceanhorn.gp ]; then
 Game=OCEANHORN
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.ironhidegames.android.ironmarines ]; then
 Game="IRON_MARINES"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.ironhidegames.android.kingdomrush4 ]; then
 Game="KINGDOM_RUSH"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.bandainamcoent.dblegends_ww ]; then
 Game="DRAGON_BALL_LEGEND"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.ea.games.r3_row ]; then
 Game="REAL_RACING"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.epicgames.fortnite ]; then
 Game=FORTNITE
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.jagex.runescape.android ]; then
 Game=RUNESCAPE
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.nianticlabs.pokemongo ]; then
 Game="POKEMON_GO"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.namcobandaigames.pacmantournaments ]; then
 Game="PACMAN"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.nintendo.zara ]; then
 Game="SUPERMARIO_RUN"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.supercell.clashroyale ]; then
 Game="CLASH_ROYALE"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.supercell.clashofclans ]; then
 Game="CLASH_OF_CLANS"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/jp.konami.pesam ]; then
 Game="PES_2019"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.lilithgame.roc.gp ]; then
 Game="RISE_OF_KINGDOM"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.supercell.brawlstars ]; then
 Game="BRAWL_STARS"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.activision.callofduty.shooter ]; then
 Game="CALL_OF_DUTY"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.garena.game.codm ]; then
 Game="CALL_OF_DUTY"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.nintendo.zaga ]; then
 Game="DRAGOLIAN_LOST"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.neowiz.game.koh ]; then
 Game="KINGDOM_OF_HERO"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.fours.rrre ]; then
 Game="MONS_TRAINER"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.dts.freefireth ]; then
 Game="GARENA_FREE_FIRE"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.robtopx.geometryjump ]; then
 Game="GEOMETRY"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.t2ksports.nba2k19 ]; then
 Game="NBA_2019"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.squareenixmontreal.hitmansniperandroid ]; then
 Game="HITMAN_SNIPER"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.vg.bsm ]; then
 Game="BLACKSHOT"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.nekki.shadowfight3 ]; then
 Game="SHADOW_FIGHT3"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.nekki.shadowfight ]; then
 Game="SHADOW_FIGHT2"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.ea.game.nfs14_row ]; then
 Game="NFS_NO_LIMIT"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.FireproofStudios.TheRoom4 ]; then
 Game="THE_ROOM"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.netease.lztgglobal ]; then
 Game="CYBER_HUNTER"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.gameloft.android.ANMP.GloftA9HM ]; then
 Game="ASPHALT9"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.theonegames.gunshipbattle ]; then
 Game="GUNSHIP_BATTLE"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/app/com.tencent* ]; then
 Game=PUBG
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/app/com.pubg* ]; then
 Game=PUBG
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/app/com.rekoo* ]; then
 Game=PUBG
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.mobile.legends ]; then
 Game="MOBILE_LEGENDS"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;
if [ -d /data/data/com.netmarble.revolutionthm ]; then
 Game="LINEAGE2"
 echo "** GAME : $Game *" | tee -a $LOG;
fi;

echo "" | tee -a $LOG;

# VARIABLES =========================================#

MODE=$(cat $NFS/mode.txt)
SE=$(cat $NFS/linux.txt)
CPU=/sys/devices/system/cpu
GOV=$(cat $NFS/governor.txt)
SY=$(cat $NFS/sync.txt)
current1=$(getprop dalvik.vm.dex2oat-threads)
current2=$(getprop dalvik.vm.boot-dex2oat-threads)
current4=$(getprop dalvik.vm.image-dex2oat-threads)
current5=$(getprop ro.sys.fw.dex2oat_thread_count)
CP=$(cat $NFS/comp.txt)
CC=$(cat $NFS/tcp.txt)
DNS=$(cat $NFS/dns.txt)
FC=$(cat /sys/kernel/fast_charge/force_fast_charge)

if [ $MODE -eq "2" ]; then
 M=GAMING
elif [ $MODE -eq "1" ]; then
 M=ULTRA
elif [ $MODE -eq "3" ]; then
 M=BATTERY_SAVER
elif [ $MODE -eq "0" ]; then
 M=BALANCED
fi;

if [ "$land" == "$MODE" ]; then
 echo "* SMART CONTROL = ACTIVE *" | tee -a $LOG;
else 
 echo "* USER MODE = ACTIVE *" | tee -a $LOG;
fi;
echo "* RUNNING $M *" | tee -a $LOG;

echo "" | tee -a $LOG;
echo "* START OF OPTIMIZATIONS : $( date +"%m-%d-%Y %H:%M:%S" ) *" | tee -a $LOG;

# Panic Off =========================================#

sysctl -e -w vm.panic_on_oom=0 2>/dev/null
sysctl -e -w kernel.panic_on_oops=0 2>/dev/null
sysctl -e -w kernel.panic=0 2>/dev/null
sysctl -e -w kernel.panic_on_warn=0 2>/dev/null
echo "* KERNEL PANIC = DISABLED *" | tee -a $LOG;

# SELINUX CENTER =========================================#

if [ -e /sys/fs/selinux/enforce ]; then
 if [ $SE -eq 1 ]; then
  setenforce 1
  echo "$SE" > /sys/fs/selinux/enforce
 fi;
 if [ $SE -eq 0 ]; then
  setenforce 0
  echo "$SE" > /sys/fs/selinux/enforce
 fi;
fi;

LIN=$(cat /sys/fs/selinux/enforce)

if [ $LIN -eq 1 ]; then
 echo "* Security-Enhanced Linux = Enforcing *" | tee -a $LOG;
fi;
if [ $LIN -eq 0 ]; then
 echo "* SELINUX = PERMISSIVE *" | tee -a $LOG;
fi;

# MMC CRC =========================================#

MMC() {
echo "* MMC CRC = DISABLED *" | tee -a $LOG;
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
 echo "* TUNER SYSCTL = DISABLED *" | tee -a $LOG;
fi;

# VM TWEAKS =========================================#

sync;
chmod 0644 /proc/sys/* 2>/dev/null

if [ "$MODE" -eq "2" ]; then
 sysctl -e -w vm.dirty_ratio=10 2>/dev/null
 sysctl -e -w vm.dirty_background_ratio=3 2>/dev/null
 sysctl -e -w vm.drop_caches=3 2>/dev/null
elif [ "$MODE" -eq "1" ]; then
 sysctl -e -w vm.dirty_ratio=80 2>/dev/null
 sysctl -e -w vm.dirty_background_ratio=20 2>/dev/null
elif [ "$MODE" -eq "3" ]; then
 sysctl -e -w vm.dirty_ratio=20 2>/dev/null
 sysctl -e -w vm.dirty_background_ratio=5 2>/dev/null
elif [ "$MODE" -eq "0" ]; then
 sysctl -e -w vm.dirty_ratio=40 2>/dev/null
 sysctl -e -w vm.dirty_background_ratio=10 2>/dev/null
fi;
sysctl -e -w vm.drop_caches=0 2>/dev/null
sysctl -e -w vm.vfs_cache_pressure=100 2>/dev/null
sysctl -e -w vm.block_dump=0 2>/dev/null
sysctl -e -w vm.overcommit_ratio=0 2>/dev/null
sysctl -e -w vm.oom_dump_tasks=1 2>/dev/null
sysctl -e -w vm.dirty_writeback_centisecs=0 2>/dev/null
sysctl -e -w vm.dirty_expire_centisecs=0 2>/dev/null
sysctl -e -w fs.leases-enable=1 2>/dev/null
sysctl -e -w fs.dir-notify-enable=0 2>/dev/null
sysctl -e -w fs.lease-break-time=10 2>/dev/null
sysctl -e -w vm.compact_memory=1 2>/dev/null
sysctl -e -w vm.compact_unevictable_allowed=1 2>/dev/null
sysctl -e -w vm.swappiness=0 2>/dev/null
sysctl -e -w vm.page-cluster=0 2>/dev/null
echo "* VIRTUAL MEMORY = TUNED *" | tee -a $LOG;

# LOW MEM KILLER =========================================#

if [ "$MODE" -eq "2" ]; then
 FP=$((($MEM*3/100)*1024/4))
 VP=$((($MEM*4/100)*1024/4))
 SR=$((($MEM*5/100)*1024/4))
 HP=$((($MEM*7/100)*1024/4))
 CR=$((($MEM*11/100)*1024/4))
 EP=$((($MEM*15/100)*1024/4))
 ADJ1=0; ADJ2=352; ADJ3=470; ADJ4=588; ADJ5=705; ADJ6=1000 # NFS GAMING
elif [ "$MODE" -eq "1" ]; then
 FP=$((($MEM*3/100)*1024/4))
 VP=$((($MEM*4/100)*1024/4))
 SR=$((($MEM*5/100)*1024/4))
 HP=$((($MEM*7/100)*1024/4))
 CR=$((($MEM*11/100)*1024/4))
 EP=$((($MEM*15/100)*1024/4))
 ADJ1=0; ADJ2=117; ADJ3=235; ADJ4=411; ADJ5=823; ADJ6=1000 # NFS
elif [ "$MODE" -eq "3" ]; then
 FP=$((($MEM*2/100)*1024/4))
 VP=$((($MEM*3/100)*1024/4))
 SR=$((($MEM*5/100)*1024/4))
 HP=$((($MEM*7/100)*1024/4))
 CR=$((($MEM*10/100)*1024/4))
 EP=$((($MEM*12/100)*1024/4))
 ADJ1=0; ADJ2=117; ADJ3=235; ADJ4=411; ADJ5=823; ADJ6=1000 # NFS
else
 FP=$((($MEM*2/100)*1024/4))
 VP=$((($MEM*3/100)*1024/4))
 SR=$((($MEM*5/100)*1024/4))
 HP=$((($MEM*6/100)*1024/4))
 CR=$((($MEM*10/100)*1024/4))
 EP=$((($MEM*12/100)*1024/4))
 ADJ1=0; ADJ2=117; ADJ3=235; ADJ4=411; ADJ5=823; ADJ6=1000 # NFS
fi;

if [ -e /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk ]; then
 chmod 0644 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
 echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
 setprop lmk.autocalc false
 echo "* ADAPTIVE LMK = DISABLED *" | tee -a $LOG;
fi;
if [ -e /sys/module/lowmemorykiller/parameters/debug_level ]; then
 chmod 0644 /sys/module/lowmemorykiller/parameters/debug_level
 echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
 echo "* DEBUG LEVEL = DISABLED *" | tee -a $LOG;
fi;
if [ -e  /sys/module/lowmemorykiller/parameters/oom_reaper ]; then
 chmod 0644 /sys/module/lowmemorykiller/parameters/oom_reaper
 echo "1" >  /sys/module/lowmemorykiller/parameters/oom_reaper
 echo "* OOM REPEAR = ACTIVATED *" | tee -a $LOG;
fi;
if [ -e /sys/module/lowmemorykiller/parameters/trust_adj_chain ]; then
 chmod 0644 /sys/module/lowmemorykiller/parameters/trust_adj_chain
 echo "N" > /sys/module/lowmemorykiller/parameters/trust_adj_chain
 echo "* TRUST ADJ CHAIN = DISABLED *" | tee -a $LOG;
fi;
if [ -e /sys/module/lowmemorykiller/parameters/adj_max_shift ]; then
 chmod 0644 /sys/module/lowmemorykiller/parameters/adj_max_shift
 echo "0" > /sys/module/lowmemorykiller/parameters/adj_max_shift
 echo "* ADJ MAX SHIFT = DISABLED *" | tee -a $LOG;
fi;
if [ -e /sys/module/lowmemorykiller/parameters/lmk_fast_run ]; then
 chmod 0644 /sys/module/lowmemorykiller/parameters/lmk_fast_run
 echo "0" > /sys/module/lowmemorykiller/parameters/lmk_fast_run
 echo "* FAST RUN = DISABLED *" | tee -a $LOG;
fi;
if [ -e /sys/module/lowmemorykiller/parameters/time_measure ]; then
 chmod 0644 /sys/module/lowmemorykiller/parameters/time_measure
 echo "0" > /sys/module/lowmemorykiller/parameters/time_measure
 echo "* TIME MEASURE = DISABLED *" | tee -a $LOG;
fi;
if [ -e /sys/module/lowmemorykiller/parameters/quick_select ]; then
 chmod 0644 /sys/module/lowmemorykiller/parameters/quick_select
 echo "0" > /sys/module/lowmemorykiller/parameters/quick_select
 echo "* QUICK SELECT = DISABLED *" | tee -a $LOG;
fi;
if [ -e /sys/module/lowmemorykiller/parameters/batch_kill ]; then
 chmod 0644 /sys/module/lowmemorykiller/parameters/batch_kill
 echo "0" > /sys/module/lowmemorykiller/parameters/batch_kill
 echo "* BATCH KILLl = DISABLED *" | tee -a $LOG;
fi;

chmod 0644 /sys/module/lowmemorykiller/parameters/adj
chmod 0644 /sys/module/lowmemorykiller/parameters/minfree
echo "$ADJ1,$ADJ2,$ADJ3,$ADJ4,$ADJ5,$ADJ6" > /sys/module/lowmemorykiller/parameters/adj
echo "$FP,$VP,$SR,$HP,$CR,$EP" > /sys/module/lowmemorykiller/parameters/minfree

MFK=$(($MEM*4))
MFK1=$(($MFK/2))

sysctl -e -w vm.min_free_kbytes=$MFK 2>/dev/null

if [ -e /proc/sys/vm/extra_free_kbytes ]; then
 sysctl -e -w vm.extra_free_kbytes=$MFK1 2>/dev/null
 setprop sys.sysctl.extra_free_kbytes $MFK1
fi;
echo "* LOW MEMORY KILLER = TUNED *" | tee -a $LOG;

# CPU_BOOST =========================================#

if [ "$MODE" -eq "2" ]; then
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "120" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* BOOST INPUT DURATION = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms
  echo "120" > /sys/module/cpu_boost/parameters/input_boost_ms
  echo "* BOOST MS = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms_s2 ]; then
  chmod 0644 /sys/module/parameters/input_boost_ms_s2
  echo "60" > /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "*BOOST MS2 = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "30" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "* DYN BOOST = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "60" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "* DYN BOOST = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "120" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* BOOST DURATION = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/general_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/general_stune_boost
  echo "10" > /sys/module/cpu_input_boost/parameters/general_stune_boost
  echo "* BOOST GEN = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/dsboost/parameters/input_boost_duration
  echo "120" > /sys/module/dsboost/parameters/input_boost_duration
  echo "* DSBOOST DURATION = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/input_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/input_stune_boost
  echo "120" > /sys/module/dsboost/parameters/input_stune_boost
  echo "* DSBOOST STUNE = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/sched_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/sched_stune_boost
  echo "10" > /sys/module/dsboost/parameters/sched_stune_boost
  echo "* DSBOOST SCHED = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/cooldown_boost_duration ]; then
  chmod 0644 /sys/module/dsboost/parameters/cooldown_boost_duration
  echo "120" > /sys/module/dsboost/parameters/cooldown_boost_duration
  echo "* DSBOOST COOLDOWN = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/cooldown_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/cooldown_stune_boost
  echo "10" > /sys/module/dsboost/parameters/cooldown_stune_boost
  echo "* DSBOOST COOLDOWN STUNE = ENABLED *" | tee -a $LOG;
 fi;
elif [ "$MODE" -eq "1" ]; then
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "120" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* BOOST INPUT DURATION = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms
  echo "120" > /sys/module/cpu_boost/parameters/input_boost_ms
  echo "* BOOST MS = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms_s2 ]; then
  chmod 0644 /sys/module/parameters/input_boost_ms_s2
  echo "60" > /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "*BOOST MS2 = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "30" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "* DYN BOOST = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "50" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "* DYN BOOST = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "120" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* BOOST DURATION = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/general_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/general_stune_boost
  echo "10" > /sys/module/cpu_input_boost/parameters/general_stune_boost
  echo "* BOOST GEN = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/dsboost/parameters/input_boost_duration
  echo "120" > /sys/module/dsboost/parameters/input_boost_duration
  echo "* DSBOOST DURATION = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/input_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/input_stune_boost
  echo "120" > /sys/module/dsboost/parameters/input_stune_boost
  echo "* DSBOOST STUNE = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/sched_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/sched_stune_boost
  echo "10" > /sys/module/dsboost/parameters/sched_stune_boost
  echo "* DSBOOST SCHED = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/cooldown_boost_duration ]; then
  chmod 0644 /sys/module/dsboost/parameters/cooldown_boost_duration
  echo "120" > /sys/module/dsboost/parameters/cooldown_boost_duration
  echo "* DSBOOST COOLDOWN = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/cooldown_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/cooldown_stune_boost
  echo "10" > /sys/module/dsboost/parameters/cooldown_stune_boost
  echo "* DSBOOST COOLDOWN STUNE = ENABLED *" | tee -a $LOG;
 fi;
elif [ "$MODE" -eq "3" ]; then
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "0" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* BOOST INPUT DURATION = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms
  echo "0" > /sys/module/cpu_boost/parameters/input_boost_ms
  echo "* BOOST MS = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms_s2 ]; then
  chmod 0644 /sys/module/parameters/input_boost_ms_s2
  echo "0" > /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "*BOOST MS2 = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "0" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "* DYN BOOST = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "0" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "* DYN BOOST = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "0" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* BOOST DURATION = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/general_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/general_stune_boost
  echo "0" > /sys/module/cpu_input_boost/parameters/general_stune_boost
  echo "* BOOST GEN = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/dsboost/parameters/input_boost_duration
  echo "0" > /sys/module/dsboost/parameters/input_boost_duration
  echo "* DSBOOST DURATION = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/input_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/input_stune_boost
  echo "0" > /sys/module/dsboost/parameters/input_stune_boost
  echo "* DSBOOST STUNE = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/sched_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/sched_stune_boost
  echo "0" > /sys/module/dsboost/parameters/sched_stune_boost
  echo "* DSBOOST SCHED = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/cooldown_boost_duration ]; then
  chmod 0644 /sys/module/dsboost/parameters/cooldown_boost_duration
  echo "0" > /sys/module/dsboost/parameters/cooldown_boost_duration
  echo "* DSBOOST COOLDOWN = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/cooldown_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/cooldown_stune_boost
  echo "0" > /sys/module/dsboost/parameters/cooldown_stune_boost
  echo "* DSBOOST COOLDOWN STUNE = DISABLED *" | tee -a $LOG;
 fi;
elif [ "$MODE" -eq "0" ]; then
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "60" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* BOOST INPUT DURATION = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms
  echo "60" > /sys/module/cpu_boost/parameters/input_boost_ms
  echo "* BOOST MS = ENABLED  *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/input_boost_ms_s2 ]; then
  chmod 0644 /sys/module/parameters/input_boost_ms_s2
  echo "20" > /sys/module/cpu_boost/parameters/input_boost_ms_s2
  echo "*BOOST MS2  = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "10" > /sys/module/cpu_boost/parameters/dynamic_stune_boost
  echo "* DYN BOOST = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/dynamic_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "30" > /sys/module/cpu_input_boost/parameters/dynamic_stune_boost
  echo "* DYN BOOST = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "60" > /sys/module/cpu_input_boost/parameters/input_boost_duration
  echo "* BOOST DURATION = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/cpu_input_boost/parameters/general_stune_boost ]; then
  chmod 0644 /sys/module/cpu_input_boost/parameters/general_stune_boost
  echo "10" > /sys/module/cpu_input_boost/parameters/general_stune_boost
  echo "* BOOST GEN = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/input_boost_duration ]; then
  chmod 0644 /sys/module/dsboost/parameters/input_boost_duration
  echo "60" > /sys/module/dsboost/parameters/input_boost_duration
  echo "* DSBOOST DURATION = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/input_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/input_stune_boost
  echo "60" > /sys/module/dsboost/parameters/input_stune_boost
  echo "* DSBOOST STUNE = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/sched_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/sched_stune_boost
  echo "10" > /sys/module/dsboost/parameters/sched_stune_boost
  echo "* DSBOOST SCHED = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/cooldown_boost_duration ]; then
  chmod 0644 /sys/module/dsboost/parameters/cooldown_boost_duration
  echo "60" > /sys/module/dsboost/parameters/cooldown_boost_duration
  echo "* DSBOOST COOLDOWN = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/dsboost/parameters/cooldown_stune_boost ]; then
  chmod 0644 /sys/module/dsboost/parameters/cooldown_stune_boost
  echo "10" > /sys/module/dsboost/parameters/cooldown_stune_boost
  echo "* DSBOOST COOLDOWN STUNE = ENABLED *" | tee -a $LOG;
 fi;
fi;

#=========================================#

if [ -e /sys/module/msm_performance/parameters/touchboost ]; then
 chmod 0644 /sys/module/msm_performance/parameters/touchboost
 echo "0" > /sys/module/msm_performance/parameters/touchboost
 echo "* TOUCHBOOST MSM = DISABLED *" | tee -a $LOG;
fi;
if [ -e /sys/module/cpu_boost/parameters/boost_ms ]; then
 chmod 0644 /sys/module/cpu_boost/parameters/boost_ms
 echo "0" > /sys/module/cpu_boost/parameters/boost_ms
 echo "* CPU BOOST MS = DISABLED *" | tee -a $LOG;
fi;
if [ -e /sys/module/cpu_boost/parameters/sched_boost_on_input ]; then
 chmod 0644 /sys/module/cpu_boost/parameters/sched_boost_on_input
 echo "N" > /sys/module/cpu_boost/parameters/sched_boost_on_input
 echo "* CPU SCHED BOOST = DISABLED *" | tee -a $LOG;
fi;
if [ -e /sys/power/pnpmgr/touch_boost ]; then
 chmod 0644 /sys/power/pnpmgr/touch_boost
 echo "0" > /sys/power/pnpmgr/touch_boost
 echo "* TOUCHBOOST PNP =  DISABLED *" | tee -a $LOG;
fi;

# I/O SCHED =========================================#

ALL=$(ls -d /sys/block/*)
SCH=$(cat $NFS/scheduler.txt)

if [ "$MODE" -eq "2" ]; then
 RQ=2
 NOM=0
 NR=128
 KB=128
elif [ "$MODE" -eq "1" ]; then
 RQ=2
 NOM=0
 NR=128
 KB=128
elif [ "$MODE" -eq "3" ]; then
 RQ=0
 NOM=0
 NR=64
 KB=64
elif [ "$MODE" -eq "0" ]; then
 RQ=2
 NOM=0
 NR=128
 KB=128
fi;

for X in $ALL; do
 echo "$SCH" > $X/queue/scheduler 2>/dev/null
 echo "0" > $X/queue/rotational 2>/dev/null
 echo "0" > $X/queue/iostats 2>/dev/null
 echo "0" > $X/queue/add_random 2>/dev/null
 echo "$NR" > $X/queue/nr_requests 2>/dev/null
 echo "$NOM" > $X/queue/nomerges 2>/dev/null
 echo "$RQ" > $X/queue/rq_affinity 2>/dev/null
 echo "$KB" > $X/queue/read_ahead_kb 2>/dev/null
 echo "0" > $X/queue/iosched/slice_idle 2>/dev/null
 echo "16" > $X/queue/iosched/fifo_batch 2>/dev/null
 echo "1" > $X/queue/iosched/front_merges 2>/dev/null
 echo "2" > $X/queue/iosched/writes_starved 2>/dev/null
 echo "500" > $X/queue/iosched/read_expire 2>/dev/null
 echo "5000" > $X/queue/iosched/write_expire 2>/dev/null
 echo "500" > $X/queue/iosched/sync_read_expire 2>/dev/null
 echo "5000" > $X/queue/iosched/sync_write_expire 2>/dev/null
 echo "500" > $X/queue/iosched/async_read_expire 2>/dev/null
 echo "5000" > $X/queue/iosched/async_write_expire 2>/dev/null
done

if [ "`ls /sys/devices/virtual/bdi/179*/read_ahead_kb`" ]; then
 for RH in /sys/devices/virtual/bdi/179*/read_ahead_kb; do
  echo "$KB" > $RH
 done
fi; 2>/dev/null

for I in find /sys/devices/platform -name iostats; do
 echo "0" > $I
done

echo "* SCHEDULER $SCH = ENABLED *" | tee -a $LOG;
echo "* I/O SCHEDULING = TUNED *" | tee -a $LOG;

# CPU POWER =========================================#

if [ -d $CPU/cpu9 ]; then
 for C in 0 1 2 3 4 5 6 7 8 9; do
  chmod 0644 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0644 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
 done

 CORES=DECA-CORE
 core=10
 ML=/sys/devices/system/cpu/cpu0/cpufreq/$GOV
 MB=/sys/devices/system/cpu/cpu5/cpufreq/$GOV
 if [ -e /sys/devices/system/cpu/cpufreq/$GOV ]; then
  ML=/sys/devices/system/cpu/cpufreq/$GOV
 fi;
elif [ -d $CPU/cpu7 ]; then
 for C in 0 1 2 3 4 5 6 7; do
  chmod 0644 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0644 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
 done

 CORES=OCTA-CORE
 core=8
 ML=/sys/devices/system/cpu/cpu0/cpufreq/$GOV
 MB=/sys/devices/system/cpu/cpu4/cpufreq/$GOV
 if [ -e /sys/devices/system/cpu/cpufreq/$GOV ]; then
  ML=/sys/devices/system/cpu/cpufreq/$GOV
 fi;
elif [ -d $CPU/cpu5 ]; then
 for C in 0 1 2 3 4 5; do
  chmod 0644 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0644 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
 done

 CORES=HEXA-CORE
 core=6
 ML=/sys/devices/system/cpu/cpu0/cpufreq/$GOV
 MB=/sys/devices/system/cpu/cpu3/cpufreq/$GOV
 if [ -e /sys/devices/system/cpu/cpufreq/$GOV ]; then
  ML=/sys/devices/system/cpu/cpufreq/$GOV
 fi;
elif [ -d $CPU/cpu3 ]; then
 for C in 0 1 2 3; do
  chmod 0644 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0644 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
 done

 CORES=QUAD-CORE
 core=4
 ML=/sys/devices/system/cpu/cpu0/cpufreq/$GOV
 MB=/sys/devices/system/cpu/cpu2/cpufreq/$GOV
 if [ -e /sys/devices/system/cpu/cpufreq/$GOV ]; then
  ML=/sys/devices/system/cpu/cpufreq/$GOV
 fi;
elif [ -d $CPU/cpu1 ]; then
 for C in 0 1; do
  chmod 0644 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0644 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  echo "$GOV" > /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
  chmod 0444 /sys/devices/system/cpu/cpu$C/cpufreq/scaling_governor
 done

 CORES=DUAL-CORE
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
 TUNE=TUNED
elif [ "$GOV" == "pixutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "pwrutilx" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "pixel_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "helix_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "blu_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "1000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "1000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "intelliactive" ]; then
 echo "0" > $ML/boost 2>/dev/null
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
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "blu_active" ]; then
 echo "0" > $ML/boost 2>/dev/null
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
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "darkness" ]; then
 echo "0" > $ML/boost 2>/dev/null
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
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
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
 TUNE=TUNED
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
 TUNE=TUNED
elif [ "$GOV" == "cultivation" ]; then
 echo "0" > $ML/boost 2>/dev/null
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
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "interactiveplus" ]; then
 echo "0" > $ML/boost 2>/dev/null
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
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "interactive_pro" ]; then
 echo "0" > $ML/boost 2>/dev/null
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
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "interactivepro" ]; then
 echo "0" > $ML/boost 2>/dev/null
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
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "interactive" ]; then
 echo "0" > $ML/boost 2>/dev/null
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
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "interactivex" ]; then
 echo "0" > $ML/boost 2>/dev/null
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
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "phantom" ]; then
 echo "0" > $ML/boost 2>/dev/null
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
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
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
 TUNE=TUNED
else
TUNE=NOT_TUNED
fi;

chmod 0444 $ML
chmod 0444 $MB
echo "* CPU POWER $CORES $GOV = $TUNE *" | tee -a $LOG;
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
 TUNE=TUNED
elif [ "$GOV" == "pixutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "2000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "pwrutilx" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "2000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "pixel_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "2000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "helix_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "2000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "2000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "blu_schedutil" ]; then
 echo "1000" > $MB/up_rate_limit_us 2>/dev/null
 echo "2000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "1000" > $ML/up_rate_limit_us 2>/dev/null
 echo "2000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "intelliactive" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "95" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
elif [ "$GOV" == "blu_active" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "95" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "darkness" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "95" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
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
 TUNE=TUNED
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
 TUNE=TUNED
elif [ "$GOV" == "interactiveplus" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "95" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "cultivation" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "95" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "interactive_pro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "95" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "interactivepro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "95" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "interactive" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "95" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "interactivex" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "95" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
elif [ "$GOV" == "phantom" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "95" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
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
 TUNE=TUNED
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
 TUNE=TUNED
else
TUNE=NOT_TUNED
fi;

chmod 0444 $ML
chmod 0444 $MB
echo "* CPU POWER $CORES $GOV = $TUNE *" | tee -a $LOG;
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
 TUNE=TUNED
elif [ "$GOV" == "pixutil" ]; then
 echo "2000" > $MB/up_rate_limit_us 2>/dev/null
 echo "5000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "2000" > $ML/up_rate_limit_us 2>/dev/null
 echo "5000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "pwrutilx" ]; then
 echo "2000" > $MB/up_rate_limit_us 2>/dev/null
 echo "5000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "2000" > $ML/up_rate_limit_us 2>/dev/null
 echo "5000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "pixel_schedutil" ]; then
 echo "2000" > $MB/up_rate_limit_us 2>/dev/null
 echo "5000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "2000" > $ML/up_rate_limit_us 2>/dev/null
 echo "5000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "helix_schedutil" ]; then
 echo "2000" > $MB/up_rate_limit_us 2>/dev/null
 echo "5000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "2000" > $ML/up_rate_limit_us 2>/dev/null
 echo "5000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "schedutil" ]; then
 echo "2000" > $MB/up_rate_limit_us 2>/dev/null
 echo "5000" > $MB/down_rate_limit_us 2>/dev/null
 echo "0" > $MB/iowait_boost_enable 2>/dev/null
 echo "2000" > $ML/up_rate_limit_us 2>/dev/null
 echo "5000" > $ML/down_rate_limit_us 2>/dev/null
 echo "0" > $ML/iowait_boost_enable 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "intelliactive" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "blu_active" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "darkness" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 TUNE=TUNED
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
 TUNE=TUNED
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
 TUNE=TUNED
elif [ "$GOV" == "interactiveplus" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "cultivation" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "interactive_pro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "interactivepro" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "interactive" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "interactivex" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 TUNE=TUNED
elif [ "$GOV" == "phantom" ]; then
 echo "0" > $ML/boost 2>/dev/null
 echo "0" > $ML/boostpulse_duration 2>/dev/null
 echo "1" > $ML/fastlane 2>/dev/null
 echo "0" > $ML/align_windows 2>/dev/null
 echo "1" > $ML/use_migration_notif 2>/dev/null
 echo "1" > $ML/use_sched_load 2>/dev/null
 echo "0" > $ML/enable_prediction 2>/dev/null
 echo "1" > $ML/fast_ramp_down 2>/dev/null
 echo "90" > $ML/go_hispeed_load 2>/dev/null
 echo "10000" > $ML/timer_rate 2>/dev/null
 echo "0" > $ML/io_is_busy 2>/dev/null
 echo "40000" > $ML/min_sample_time 2>/dev/null
#############################################
 echo "0" > $MB/boost 2>/dev/null
 echo "0" > $MB/boostpulse_duration 2>/dev/null
 echo "1" > $MB/fastlane 2>/dev/null
 echo "0" > $MB/align_windows 2>/dev/null
 echo "1" > $MB/use_migration_notif 2>/dev/null
 echo "1" > $MB/use_sched_load 2>/dev/null
 echo "0" > $MB/enable_prediction 2>/dev/null
 echo "1" > $MB/fast_ramp_down 2>/dev/null
 echo "85" > $MB/go_hispeed_load 2>/dev/null
 echo "12000" > $MB/timer_rate 2>/dev/null
 echo "0" > $MB/io_is_busy 2>/dev/null
 echo "60000" > $MB/min_sample_time 2>/dev/null
 TUNE=TUNED
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
 TUNE=TUNED
else
TUNE=NOT_TUNED
fi;

chmod 0444 $ML
chmod 0444 $MB
echo "* CPU POWER $CORES $GOV = $TUNE *" | tee -a $LOG;
}

if [ "$MODE" -eq "2" ]; then
 CPUULTRA
elif [ "$MODE" -eq "1" ]; then
 CPUULTRA
elif [ "$MODE" -eq "3" ]; then
 CPUBATTERY
elif [ "$MODE" -eq "0" ]; then
 CPUBALANCE
fi;

# GPU OPTIMIZER =========================================#

if [ -d /sys/class/kgsl/kgsl-3d0 ]; then
 GPU=/sys/class/kgsl/kgsl-3d0
else
 GPU=/sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0
fi; 
if [ -e $GPU/max_pwrlevel ]; then 
 echo "0" > $GPU/max_pwrlevel
 echo "* GPU SCALING = TUNED *" | tee -a $LOG;
fi;

if [ -e /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate ]; then 
 echo "1" > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
 echo "Y" > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
 echo "* GPU ALGORITHM = ACTIVATED *" | tee -a $LOG;
fi;

if [ -e $GPU/throttling ]; then
 echo "0" > $GPU/throttling
 echo "* GPU FREQUENCY THROTTLING = DISABLED *" | tee -a $LOG;
fi;

GPUUL() {
if [ -e $GPU/devfreq/adrenoboost ]; then 
 echo "2" > $GPU/devfreq/adrenoboost
 echo "* ADRENOBOOST = MEDIUM *" | tee -a $LOG;
fi;
}
GPUBAT() {
if [ -e $GPU/devfreq/adrenoboost ]; then 
 echo "0" > $GPU/devfreq/adrenoboost
 echo "* ADRENOBOOST = DISABLED *" | tee -a $LOG;
fi;
}
GPUBAL() {
if [ -e $GPU/devfreq/adrenoboost ]; then 
 echo "1" > $GPU/devfreq/adrenoboost
 echo "* ADRENOBOOST = LOW *" | tee -a $LOG;
fi;
}

if [ "$MODE" -eq "2" ]; then
 GPUUL
elif [ "$MODE" -eq "1" ]; then
 GPUUL
elif [ "$MODE" -eq "3" ]; then
 GPUBAT
elif [ "$MODE" -eq "0" ]; then
 GPUBAL
fi;

if [ -e /sys/devices/14ac0000.mali/dvfs ]; then
 chmod 0000 /sys/devices/14ac0000.mali/dvfs
 chmod 0000 /sys/devices/14ac0000.mali/dvfs_max_lock
 chmod 0000 /sys/devices/14ac0000.mali/dvfs_min_lock
 echo "* DVFS = Disabled *" | tee -a $LOG;
fi;

# SPECIFIC EAS/HMP KERNEL =========================================#

easbatt() {
if [ "$eas" -eq "1" ]; then
 echo "32" > /proc/sys/kernel/sched_nr_migrate
 echo "1" > /proc/sys/kernel/sched_cstate_aware
 echo "0" > /proc/sys/kernel/sched_initial_task_util
 if [ -e /proc/sys/kernel/sched_use_walt_task_util ]; then
	echo "0" > /proc/sys/kernel/sched_use_walt_task_util
	echo "0" > /proc/sys/kernel/sched_use_walt_cpu_util
 fi;
 echo "* EAS KERNEL = TUNED *" | tee -a $LOG;
fi;
}

easbal() {
if [ "$eas" -eq "1" ]; then
 echo "64" > /proc/sys/kernel/sched_nr_migrate
 echo "1" > /proc/sys/kernel/sched_cstate_aware
 echo "0" > /proc/sys/kernel/sched_initial_task_util
  if [ -e /proc/sys/kernel/sched_use_walt_task_util ]; then
	 echo "1" > /proc/sys/kernel/sched_use_walt_task_util
	 echo "1" > /proc/sys/kernel/sched_use_walt_cpu_util
	fi;
 echo "* EAS KERNEL = TUNED *" | tee -a $LOG;
fi;
}

easperf() {
if [ "$eas" -eq "1" ]; then
 echo "96" > /proc/sys/kernel/sched_nr_migrate
 echo "1" > /proc/sys/kernel/sched_cstate_aware
 echo "10" > /proc/sys/kernel/sched_initial_task_util
 if [ -e /proc/sys/kernel/sched_autogroup_enabled ]; then
  echo "0" > /proc/sys/kernel/sched_autogroup_enabled
 fi;
 if [ -e /proc/sys/kernel/sched_is_big_little ]; then
  echo "1" > /proc/sys/kernel/sched_is_big_little
 fi;
 if [ -e /proc/sys/kernel/sched_use_walt_task_util ]; then
  echo "1" > /proc/sys/kernel/sched_use_walt_task_util
	echo "1" > /proc/sys/kernel/sched_use_walt_cpu_util
 fi;
 echo "* EAS KERNEL = TUNED *" | tee -a $LOG;
fi;
}

hmpbatt() {
if [ "$eas" -eq "0" ]; then
 echo "95" > /proc/sys/kernel/sched_upmigrate
 echo "100" > /proc/sys/kernel/sched_group_upmigrate
 echo "80" > /proc/sys/kernel/sched_downmigrate
 echo "90" > /proc/sys/kernel/sched_group_downmigrate
 echo "15" > /proc/sys/kernel/sched_small_wakee_task_load
 echo "0" > /proc/sys/kernel/sched_init_task_load
 if [ -e /proc/sys/kernel/sched_enable_power_aware ]; then
  echo "1" > /proc/sys/kernel/sched_enable_power_aware
 fi;
 echo "1" > /proc/sys/kernel/sched_enable_thread_grouping
 echo "35" > /proc/sys/kernel/sched_big_waker_task_load
 echo "3" > /proc/sys/kernel/sched_window_stats_policy
 echo "5" > /proc/sys/kernel/sched_ravg_hist_size
 if [ -e /proc/sys/kernel/sched_upmigrate_min_nice ]; then
  echo "0" > /proc/sys/kernel/sched_upmigrate_min_nice
 fi;
 echo "5" > /proc/sys/kernel/sched_spill_nr_run
 echo "100" > /proc/sys/kernel/sched_spill_load
 echo "1" > /proc/sys/kernel/sched_enable_thread_grouping
 echo "1" > /proc/sys/kernel/sched_restrict_cluster_spill
 if [ -e /proc/sys/kernel/sched_wakeup_load_threshold ]; then
  echo "110" > /proc/sys/kernel/sched_wakeup_load_threshold
 fi;
 echo "10" > /proc/sys/kernel/sched_rr_timeslice_ms
 if [ -e "/proc/sys/kernel/sched_enable_power_aware" ]; then
  echo "1" > /proc/sys/kernel/sched_enable_power_aware
 fi;
 if [ -e /proc/sys/kernel/sched_migration_fixup ]; then
  echo "1" > /proc/sys/kernel/sched_migration_fixup
 fi;
 echo "* HMP KERNEL = TUNED *" | tee -a $LOG;
fi;
}

hmpbal() {
if [ "$eas" -eq "0" ]; then
 echo "75" > /proc/sys/kernel/sched_upmigrate
 echo "85" > /proc/sys/kernel/sched_group_upmigrate
 echo "60" > /proc/sys/kernel/sched_downmigrate
 echo "70" > /proc/sys/kernel/sched_group_downmigrate
 echo "10" > /proc/sys/kernel/sched_small_wakee_task_load
 echo "10" > /proc/sys/kernel/sched_init_task_load
 if [ -e /proc/sys/kernel/sched_enable_power_aware ]; then
  echo "1" > /proc/sys/kernel/sched_enable_power_aware
 fi;
 echo "1" > /proc/sys/kernel/sched_enable_thread_grouping
 echo "30" > /proc/sys/kernel/sched_big_waker_task_load
 echo "2" > /proc/sys/kernel/sched_window_stats_policy
 echo "5" > /proc/sys/kernel/sched_ravg_hist_size
 if [ -e /proc/sys/kernel/sched_upmigrate_min_nice ]; then
  echo "9" > /proc/sys/kernel/sched_upmigrate_min_nice
 fi;
 echo "5" > /proc/sys/kernel/sched_spill_nr_run
 echo "95" > /proc/sys/kernel/sched_spill_load
 echo "1" > /proc/sys/kernel/sched_enable_thread_grouping
 echo "1" > /proc/sys/kernel/sched_restrict_cluster_spill
 if [ -e /proc/sys/kernel/sched_wakeup_load_threshold ]; then
  echo "110" > /proc/sys/kernel/sched_wakeup_load_threshold
 fi;
 echo "10" > /proc/sys/kernel/sched_rr_timeslice_ms
 if [ -e /proc/sys/kernel/sched_enable_power_aware ]; then
  echo "1" > /proc/sys/kernel/sched_enable_power_aware
 fi;
 if [ -e /proc/sys/kernel/sched_migration_fixup ]; then
  echo "1" > /proc/sys/kernel/sched_migration_fixup
 fi;
 echo "* HMP KERNEL = TUNED *" | tee -a $LOG;
fi;
}

hmpperf() {
if [ "$eas" -eq "0" ]; then
 echo "65" > /proc/sys/kernel/sched_upmigrate
 echo "75" > /proc/sys/kernel/sched_group_upmigrate
 echo "50" > /proc/sys/kernel/sched_downmigrate
 echo "60" > /proc/sys/kernel/sched_group_downmigrate
 echo "5" > /proc/sys/kernel/sched_small_wakee_task_load
 echo "15" > /proc/sys/kernel/sched_init_task_load
 if [ -e /proc/sys/kernel/sched_enable_power_aware ]; then
  echo "1" > /proc/sys/kernel/sched_enable_power_aware
 fi;
 echo "1" > /proc/sys/kernel/sched_enable_thread_grouping
 echo "25" > /proc/sys/kernel/sched_big_waker_task_load
 echo "3" > /proc/sys/kernel/sched_window_stats_policy
 echo "5" > /proc/sys/kernel/sched_ravg_hist_size
 if [ -e /proc/sys/kernel/sched_upmigrate_min_nice ]; then
  echo "9" > /proc/sys/kernel/sched_upmigrate_min_nice
 fi;
 echo "5" > /proc/sys/kernel/sched_spill_nr_run
 echo "85" > /proc/sys/kernel/sched_spill_load
 echo "1" > /proc/sys/kernel/sched_enable_thread_grouping
 echo "1" > /proc/sys/kernel/sched_restrict_cluster_spill
 if [ -e /proc/sys/kernel/sched_wakeup_load_threshold ]; then
  echo "110" > /proc/sys/kernel/sched_wakeup_load_threshold
 fi;
 echo "10" > /proc/sys/kernel/sched_rr_timeslice_ms
 if [ -e /proc/sys/kernel/sched_enable_power_aware ]; then
  echo "1" > /proc/sys/kernel/sched_enable_power_aware
  fi;
 if [ -e /proc/sys/kernel/sched_migration_fixup ]; then
  echo "1" > /proc/sys/kernel/sched_migration_fixup
 fi;
 echo "* HMP KERNEL = TUNED *" | tee -a $LOG;
fi;
}

if [ "$MODE" -eq "2" ]; then
 easperf
 hmpperf
elif [ "$MODE" -eq "1" ]; then
 easperf
 hmpperf
elif [ "$MODE" -eq "3" ]; then
 easbatt
 hmpbatt
elif [ "$MODE" -eq "0" ]; then
 easbal
 hmpbal
fi;

# LPM LEVELS =========================================#

LPM=/sys/module/lpm_levels

if [ -d $LPM/parameters ]; then
 echo "4" > $LPM/enable_low_power/l2 2>/dev/null
 echo "Y" > $LPM/parameters/lpm_prediction 2>/dev/null
 echo "0" > $LPM/parameters/sleep_time_override 2>/dev/null
 echo "N" > $LPM/parameters/sleep_disable 2>/dev/null
 echo "N" > $LPM/parameters/menu_select 2>/dev/null
 echo "N" > $LPM/parameters/print_parsed_dt 2>/dev/null
 echo "100" > $LPM/parameters/red_stddev 2>/dev/null
 echo "100" > $LPM/parameters/tmr_add 2>/dev/null
 echo "Y" > $LPM/system/system-pc/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/system-pc/suspend_enabled 2>/dev/null
 echo "Y" > $LPM/system/system-wifi/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/system-wifi/suspend_enabled 2>/dev/null
 echo "N" > $LPM/system/perf/perf-l2-dynret/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/perf/perf-l2-dynret/suspend_enabled 2>/dev/null
 echo "Y" > $LPM/system/perf/perf-l2-pc/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/perf/perf-l2-pc/suspend_enabled 2>/dev/null
 echo "N" > $LPM/system/perf/perf-l2-ret/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/perf/perf-l2-ret/suspend_enabled 2>/dev/null
 echo "Y" > $LPM/system/perf/perf-l2-wifi/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/perf/perf-l2-wifi/suspend_enabled 2>/dev/null
 echo "N" > $LPM/system/pwr/pwr-l2-dynret/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/pwr/pwr-l2-dynret/suspend_enabled 2>/dev/null
 echo "Y" > $LPM/system/pwr/pwr-l2-pc/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/pwr/pwr-l2-pc/suspend_enabled 2>/dev/null
 echo "N" > $LPM/system/pwr/pwr-l2-ret/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/pwr/pwr-l2-ret/suspend_enabled 2>/dev/null
 echo "Y" > $LPM/system/pwr/pwr-l2-wifi/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/pwr/pwr-l2-wifi/suspend_enabled 2>/dev/null
for i in 4 5 6 7; do
 echo "Y" > $LPM/system/perf/cpu$i/pc/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/perf/cpu$i/pc/suspend_enabled 2>/dev/null
 echo "N" > $LPM/system/perf/cpu$i/ret/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/perf/cpu$i/ret/suspend_enabled 2>/dev/null
 echo "Y" > $LPM/system/perf/cpu$i/wfi/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/perf/cpu$i/wfi/suspend_enabled 2>/dev/null
done
for i in 0 1 2 3; do
 echo "Y" > $LPM/system/pwr/cpu$i/pc/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/pwr/cpu$i/pc/suspend_enabled 2>/dev/null
 echo "N" > $LPM/system/pwr/cpu$i/ret/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/pwr/cpu$i/ret/suspend_enabled 2>/dev/null
 echo "Y" > $LPM/system/pwr/cpu$i/wfi/idle-enabled 2>/dev/null
 echo "Y" > $LPM/system/pwr/cpu$i/wfi/suspend_enabled 2>/dev/null
done
echo "* LPM LEVELS = TUNED *" | tee -a $LOG;
fi;

# DALVIK TUNER =========================================#

if [ ! "$current1" = "" ]; then
 setprop dalvik.vm.dex2oat-threads $core
 echo "* DALVIK VM DEX2OAT = TUNED *" | tee -a $LOG;
fi;
if [ ! "$current2" = "" ]; then
 setprop dalvik.vm.boot-dex2oat-threads $core
 echo "* DALVIK VM BOOT DEX2OAT = TUNED *" | tee -a $LOG;
fi;
if [ ! "$current4" = "" ]; then
 setprop dalvik.vm.image-dex2oat-threads $core
 echo "* DALVIK VM IMG DEX2OAT = TUNED *" | tee -a $LOG;
fi;
if [ ! "$current5" = "" ]; then
 setprop ro.sys.fw.dex2oat_thread_count $core
 echo "* DALVIK VM FW DEW2OAT = TUNED *" | tee -a $LOG;
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
 echo "* ZRAM0 = DISABLED *" | tee -a $LOG;
fi;
if [ -e /dev/block/zram1 ]; then
 swapoff /dev/block/zram1
 setprop vnswap.enabled false
 setprop ro.config.zram false
 setprop ro.config.zram.support false
 setprop zram.disksize 0
 echo "* ZRAM1 = DISABLED *" | tee -a $LOG;
fi;
if [ -e /dev/block/zram2 ]; then
 swapoff /dev/block/zram2
 setprop vnswap.enabled false
 setprop ro.config.zram false
 setprop ro.config.zram.support false
 setprop zram.disksize 0
 echo "* ZRAM2 = DISABLED *" | tee -a $LOG;
fi;
if [ -e /dev/block/vnswap0 ]; then
 swapoff /dev/block/vnswap0
 setprop vnswap.enabled false
 echo "* VNSWAP = DISABLED *" | tee -a $LOG;
fi;
}

swapON() {
if [ -e /dev/block/zram0 ]; then
 swapoff /dev/block/zram0
 echo "1" > /sys/block/zram0/reset
 echo "$((ZR*1024*1024))" > /sys/block/zram0/disksize
 mkswap /dev/block/zram0
 swapon /dev/block/zram0
 #sysctl -e -w vm.swappiness=20
 setprop vnswap.enabled true
 setprop ro.config.zram true
 setprop ro.config.zram.support true
 setprop zram.disksize $ZR
 echo "* ZRAM0 = ACTIVATED $ZR MB *" | tee -a $LOG;
fi;
if [ -e /dev/block/zram1 ]; then
 swapoff /dev/block/zram1
 echo "1" > /sys/block/zram1/reset
 echo "$((ZR*1024*1024))" > /sys/block/zram1/disksize
 mkswap /dev/block/zram1
 swapon /dev/block/zram1
 #sysctl -e -w vm.swappiness=20
 setprop vnswap.enabled true
 setprop ro.config.zram true
 setprop ro.config.zram.support true
 setprop zram.disksize $ZR
 echo "* ZRAM1 = ACTIVATED $ZR MB *" | tee -a $LOG;
fi;
if [ -e /dev/block/zram2 ]; then
 swapoff /dev/block/zram2
 echo "1" > /sys/block/zram2/reset
 echo "$((ZR*1024*1024))" > /sys/block/zram2/disksize
 mkswap /dev/block/zram2
 swapon /dev/block/zram2
 #sysctl -e -w vm.swappiness=20
 setprop vnswap.enabled true
 setprop ro.config.zram true
 setprop ro.config.zram.support true
 setprop zram.disksize $ZR
 echo "* ZRAM2 = ACTIVATED $ZR MB *" | tee -a $LOG;
fi;
if [ -e /dev/block/vnswap0 ]; then
 swapon /dev/block/vnswap0
 setprop vnswap.enabled true
 echo "* VNSWAP = ENABLED *" | tee -a $LOG;
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
 #sysctl -e -w vm.swappiness=30
 echo "* ZSWAP = ACTIVATED *" | tee -a $LOG;
fi;
}

zswapOFF() {
if [ -e /sys/module/zswap/parameters/enabled ]; then
 echo "N" > /sys/module/zswap/parameters/enabled
 echo "* ZSWAP = DISABLED *" | tee -a $LOG;
fi;
}

ZR=$(($MEM*2/3))

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
 echo "0" > /sys/kernel/mm/uksm/run
 setprop ro.config.ksm.support false
 echo "* UKSM = DISABLED *" | tee -a $LOG;
elif [ -e /sys/kernel/mm/ksm/run ]; then
 echo "0" > /sys/kernel/mm/ksm/run
 setprop ro.config.ksm.support false
 echo "* KSM = DISABLED *" | tee -a $LOG;
fi;

# DEEP SLEEP ENHANCEMENT =========================================#

for i in $(ls /sys/class/scsi_disk/); do
 echo "temporary none" > /sys/class/scsi_disk/"$i"/cache_type
 if [ -e /sys/class/scsi_disk/"$i"/cache_type ]; then
  DP=1
 fi;
done

if [ "$DP" -eq "1" ]; then
 echo "* DEEP SLEEP FIX = ACTIVATED *" | tee -a $LOG;
fi;

# KERNEL TASK  =========================================#
 
if [ -e /sys/kernel/debug/sched_features ]; then
 echo "NO_GENTLE_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features
 echo "NEXT_BUDDY" > /sys/kernel/debug/sched_features
 echo "LAST_BUDDY" > /sys/kernel/debug/sched_features
 echo "TTWU_QUEUE" > /sys/kernel/debug/sched_features
 echo "RT_RUNTIME_SHARE" > /sys/kernel/debug/sched_features
 echo "* CPU SCHEDULER = TUNED *" | tee -a $LOG;
fi;

if [ -e /sys/kernel/sched/gentle_fair_sleepers ]; then
 echo "0" > /sys/kernel/sched/gentle_fair_sleepers
 echo "* GFS = DISABLED *" | tee -a $LOG;
fi;

# NETWORK SPEED =========================================#

echo "$CC" > /proc/sys/net/ipv4/tcp_congestion_control
echo "* NETWORK TCP : $CC = ACTIVATED *" | tee -a $LOG;
sysctl -e -w net.ipv4.tcp_timestamps=0
sysctl -e -w net.ipv4.tcp_sack=1
sysctl -e -w net.ipv4.tcp_fack=1
sysctl -e -w net.ipv4.tcp_window_scaling=1
sysctl -e -w net.ipv4.tcp_rfc1337=1
sysctl -e -w net.ipv4.tcp_workaround_signed_windows=1
sysctl -e -w net.ipv4.tcp_low_latency=1
sysctl -e -w net.ipv4.ip_no_pmtu_disc=0
sysctl -e -w net.ipv4.tcp_mtu_probing=1
sysctl -e -w net.ipv4.tcp_frto=2
echo "* IPV4 TRAFFIC = TUNED *" | tee -a $LOG;

# GUARD / CLOUDFLARE / GOOGLE / VERISIGN / CLEANBROWSING =========================================#

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
 echo "* GUARD DNS = ACTIVATED *" | tee -a $LOG;
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
 echo "* CLOUFLARE DNS = ACTIVATED *" | tee -a $LOG;
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
 echo "* GOOGLE PUBLIC DNS = ACTIVATED *" | tee -a $LOG;
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
 echo "* VERISIGN DNS = ACTIVATED *" | tee -a $LOG;
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
 echo "* CLEANBROWSING DNS = ACTIVATED *" | tee -a $LOG;
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
echo "* GOOGLE WAKELOCKS FIX = ACTIVATED *" | tee -a $LOG;

# WAKELOCKS =========================================#

if [ -e /sys/module/bcmdhd/parameters/wlrx_divide ]; then
 echo "4" > /sys/module/bcmdhd/parameters/wlrx_divide 2>/dev/null
 echo "4" > /sys/module/bcmdhd/parameters/wlctrl_divide 2>/dev/null
 echo "* WLAN WAKELOCKS FIX = ACTIVATED *" | tee -a $LOG;
fi;

if [ -d /sys/module/wakeup/parameters ]; then
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
 echo "* WAKELOCKS FIX = ACTIVATED *" | tee -a $LOG;
fi;

if [ -e /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker ]; then
 echo "wlan_pno_wl;wlan_ipa;wcnss_filter_lock;[timerfd];hal_bluetooth_lock;IPA_WS;sensor_ind;wlan;netmgr_wl;qcom_rx_wakelock;wlan_wow_wl;wlan_extscan_wl;NETLINK;bam_dmux_wakelock;IPA_RM12" > /sys/devices/virtual/misc/boeffla_wakelock_blocker/wakelock_blocker
 echo "* BOEFFLA WAKELOCKS BLOCKER = ACTIVATED *" | tee -a $LOG;
elif [ -e /sys/class/misc/boeffla_wakelock_blocker/wakelock_blocker ]; then
 echo "wlan_pno_wl;wlan_ipa;wcnss_filter_lock;[timerfd];hal_bluetooth_lock;IPA_WS;sensor_ind;wlan;netmgr_wl;qcom_rx_wakelock;wlan_wow_wl;wlan_extscan_wl;NETLINK;bam_dmux_wakelock;IPA_RM12" > /sys/class/misc/boeffla_wakelock_blocker/wakelock_blocker
 echo "* BOEFFLA WAKELOCKS BLOCKER = ACTIVATED *" | tee -a $LOG;
fi;

# ZRAM/ZSWAP/SWAP ADJUSTEMENTS =========================================#

ZR=$(grep -l zram0 /proc/swaps)
SW=$(grep -l swap /proc/swaps)
ZS=$(grep -l zswap /proc/swaps)

if [ -e /proc/swaps ]; then
 if [ "$ZR" == "/proc/swaps" ]; then
  sysctl -e -w vm.swappiness=65
  #sysctl -e -w vm.page-cluster=2
  echo "* VIRTUAL SWAP = TUNED *" | tee -a $LOG;
 elif [ "$SW" == "/proc/swaps" ]; then
  sysctl -e -w vm.swappiness=65
  #sysctl -e -w vm.page-cluster=2
  echo "* SWAP PARTITION = TUNED *" | tee -a $LOG;
 elif [ "$ZS" == "/proc/swaps" ]; then
  sysctl -e -w vm.swappiness=65
  #sysctl -e -w vm.page-cluster=2
  echo "* WRITEBACK CACHE = TUNED *" | tee -a $LOG;
 fi;
fi;

# KERNEL / MODULES / MASKS DEBUGGERS OFF =========================================#

if [ -e proc/sys/debug/exception-trace ]; then
 echo "0" > /proc/sys/debug/exception-trace
fi;
if [ -e /proc/sys/kernel/compat-log ]; then
 echo "0" > /proc/sys/kernel/compat-log
fi;
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

echo "* DEBUG LOGGING KILLER = ACTIVATED *" | tee -a $LOG;

# MISC MODES =========================================#

if [ -e /sys/class/lcd/panel/power_reduce ]; then
 echo "1" > /sys/class/lcd/panel/power_reduce
 echo "* LCD POWER = ACTIVATED *" | tee -a $LOG;
fi;
if [ "$MODE" -eq "2" ]; then
 if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
  chmod 0644 /sys/module/workqueue/parameters/power_efficient
  echo "N" > /sys/module/workqueue/parameters/power_efficient
  echo "* POWER EFFICIENT WQ = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/adreno_idler/parameters/adreno_idler_active ]; then
  chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "0" > /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "* ADRENO IDLER = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/kernel/sched/arch_power ]; then
  echo "0" > /sys/kernel/sched/arch_power
  echo "* ARCH POWER = DISABLED *" | tee -a $LOG;
 fi;
elif [ "$MODE" -eq "1" ]; then
 if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
  chmod 0644 /sys/module/workqueue/parameters/power_efficient
  echo "N" > /sys/module/workqueue/parameters/power_efficient
  echo "* POWER EFFICIENT WQ = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/adreno_idler/parameters/adreno_idler_active ]; then
  chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "0" > /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "* ADRENO IDLER = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/kernel/sched/arch_power ]; then
  echo "0" > /sys/kernel/sched/arch_power
  echo "* ARCH POWER = DISABLED *" | tee -a $LOG;
 fi;
elif [ "$MODE" -eq "3" ]; then
 if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
  chmod 0644 /sys/module/workqueue/parameters/power_efficient
  echo "Y" > /sys/module/workqueue/parameters/power_efficient
  echo "* POWER EFFICIENT = ACTIVATED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/adreno_idler/parameters/adreno_idler_active ]; then
  chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "1" > /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "* ADRENO IDLER = ACTIVATED *" | tee -a $LOG;
 fi;
 if [ -e /sys/kernel/sched/arch_power ]; then
  echo "1" > /sys/kernel/sched/arch_power
  echo "* ARCH POWER = ENABLED *" | tee -a $LOG;
 fi;
elif [ "$MODE" -eq "0" ]; then
 if [ -e /sys/module/workqueue/parameters/power_efficient ]; then
  chmod 0644 /sys/module/workqueue/parameters/power_efficient
  echo "N" > /sys/module/workqueue/parameters/power_efficient
  echo "* POWER EFFICIENT WQ = ACTIVATED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/adreno_idler/parameters/adreno_idler_active ]; then
  chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "0" > /sys/module/adreno_idler/parameters/adreno_idler_active
  echo "* ADRENO IDLER = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/kernel/sched/arch_power ]; then
  echo "0" > /sys/kernel/sched/arch_power
  echo "* ARCH POWER = DISABLED *" | tee -a $LOG;
 fi;
fi;

# FAST CHARGE =========================================#

if [ "$FC" -eq "2" ]; then
 echo "* FAST CHARGE = ACTIVATED *" | tee -a $LOG;
elif [ "$FC" -eq "1" ]; then
 echo "* FAST CHARGE CUSTOM = ACTIVATED *" | tee -a $LOG;
fi;

# FSYNC ON/OFF =========================================#

if [ "$SY" -eq "1" ]; then
 if [ -e /sys/kernel/dyn_fsync/Dyn_fsync_active ]; then
  echo "1" > /sys/kernel/dyn_fsync/Dyn_fsync_active
  echo "* DYN FSYNC = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/class/misc/fsynccontrol/fsync_enabled ]; then
  echo "1" > /sys/class/misc/fsynccontrol/fsync_enabled
  echo "* FSYNC CONTROL = ENABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/sync/parameters/fsync ]; then
  echo "1" > /sys/module/sync/parameters/fsync
  echo "* FSYNC = ACTIVATED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/sync/parameters/fsync_enabled ]; then
  echo "Y" > /sys/module/sync/parameters/fsync_enabled
  echo "* FSYNC = ACTIVATED *" | tee -a $LOG;
 fi;
elif [ "$SY" -eq "0" ]; then
 if [ -e /sys/kernel/dyn_fsync/Dyn_fsync_active ]; then
  echo "0" > /sys/kernel/dyn_fsync/Dyn_fsync_active
  echo "* DYN FSYNC = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/class/misc/fsynccontrol/fsync_enabled ]; then
  echo "0" > /sys/class/misc/fsynccontrol/fsync_enabled
  echo "* FSYNC CONTROL = DISABLED *" | tee -a $LOG;
 fi; 
 if [ -e /sys/module/sync/parameters/fsync ]; then
  echo "0" > /sys/module/sync/parameters/fsync
  echo "* FSYNC = DISABLED *" | tee -a $LOG;
 fi;
 if [ -e /sys/module/sync/parameters/fsync_enabled ]; then
  echo "N" > /sys/module/sync/parameters/fsync_enabled
  echo "* FSYNC = DISABLED *" | tee -a $LOG;
 fi;
fi;

# SQLITE QUERY OPTIMIZER =========================================#

ARM(){
echo "* SQLITE OPTIMIZER = ARM NOT SUPPORTED *" | tee -a $LOG;
}

SQLITE3() {
SQ=$NFS/sq3.log
RUN=172800 #2days
DATE=`date +%s`

if [ -e $SQ ]; then
 LAST=`stat -t $SQ | awk '{print $14}'`
else
 LAST=0
fi;

INTER=$(expr $DATE - $LAST)

if [ $INTER -gt $RUN ]; then
 if [ -e $SQ ]; then
  rm $SQ
 fi;

 for i in `find /d* -iname "*.db"`; do
  sqlite3 $i 'VACUUM;';
  resVac=$?
  if [ $resVac == 0 ]; then
   resVac="DONE"
  else
   resVac="ERROR-$resVac"
  fi;
		
  sqlite3 $i 'REINDEX;';
  resIndex=$?
  if [ $resIndex == 0 ]; then
   resIndex="DONE"
  else
   resIndex="ERROR-$resIndex"
  fi;
  echo "DATABASE $i:  VACUUM=$resVac  REINDEX=$resIndex" | tee -a $SQ;
 done
	  
 echo "* SQLITE OPTIMIZER = ACTIVATED *" | tee -a $LOG;
else
 echo "* SQLITE OPTIMIZER = ALREADY ACTIVATED *" | tee -a $LOG;
fi;
}

if [ "$ARCH" == "armeabi-v7a" ]; then
 ARM
elif [ "$ARCH" == "armeabi" ]; then
 ARM
elif [ -e $SYS/bin/sqlite3 ]; then
 SQLITE3
elif [ -e $SYS/xbin/sqlite3 ]; then
 SQLITE3
else
 echo "* SQLITE OPTIMIZER = MISSING BINARY *" | tee -a $LOG;
fi;

# CLEANER SYSTEM =========================================#

rm -f /data/anr/* 2>/dev/null
rm -f /data/system/usagestats/*.log 2>/dev/null
rm -f /data/system/usagestats/*.txt 2>/dev/null
rm -f /data/tombstones/*.log 2>/dev/null
rm -f /data/tombstones/*.txt 2>/dev/null

echo "* SYSTEM CLEANER = ACTIVATED *" | tee -a $LOG;

# CHECK  PROCESS =========================================#

if [ `cat /proc/sys/vm/min_free_kbytes` -eq "$MFK" ] && [ `cat /proc/sys/vm/oom_kill_allocating_task` -eq "0" ]; then
 echo "* FUNCTIONS : ALL = ACTIVATED *" | tee -a $LOG;
else
 echo "* FUNCTIONS : PARTIAL = ACTIVATED *" | tee -a $LOG;
fi;

echo "* END OF OPTIMIZATIONS : $( date +"%m-%d-%Y %H:%M:%S" ) *" | tee -a $LOG;
echo "================================================" | tee -a $LOG;
echo "* ⚡ NFS-INJECTOR(TM) ⚡ *" | tee -a $LOG;
echo "* (C) K1KS & TEAM 2019 *" | tee -a $LOG;
echo "* GIFT : paypal.me/k1ksxda *" | tee -a $LOG;
echo "* TELEGRAM : t.me/nfsinjector *" | tee -a $LOG;
echo "================================================" | tee -a $LOG;
exit 0
