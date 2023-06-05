#!/usr/bin/ksh
#
#              AIX SYSTEM disk information
#              ===========================
#
# THIS SCRIPT WILL PROVIDE FOLLOWING INFORMATION PER (ALL) HDISK
# - HDISK NAME
# - VOLUME GROUP NAME
# - VOLUME GROUP MODE
# - DISK CAPACITY
# - LUN ID
# - LOGICAL VOLUMES AND MOUNT POINTS
#
# Example run:
# ksh total_disk_info.ksh
#
# Tips: later on output can be copied into Excel sheet with comma delimiter for filtering
# 
################################################################################
# 29/02/2020 | Rovshan Pashayev     | v1.0   | Initial version
#
################################################################################

for HD in `lspv | awk {' print $1 '}`
do VG=`lspv | grep -w $HD | awk {' print $3 '}`
CAP=`lsmpio -ql $HD | grep Capacity | awk {' print $2 '}`
VN=`lsmpio -ql $HD | grep "Volume Name" | awk {' print $3 '}`
VS=`lsmpio -ql $HD | grep "Volume Serial" | awk {' print $3 '}`
LM=`lsvg -l $VG | awk {' print $1,$7 '} | sed 1,2d | tr " " ":" | tr "\n" ","`
VM=`lsvg $VG | grep "VG Mode:" | awk {' print $3 '}`
echo $HD,$VG,$VM,$CAP,$VN,$VS,$LM
done 2> /dev/null
