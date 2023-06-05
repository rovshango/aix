#!/usr/bin/ksh

# DURING DECOMMISIONING OF AIX LPAR
# USUALLY FOLLOWING INFORMATION NEEDED
# YOU CAN GET IP ADDRESS, LUNS ID AND WWNS

echo "=== IP ADDRESS ==="; ifconfig -a
echo "=== LUN ADDRESS ==="
for HD in `lspv | awk {' print $1 '}`
do VG=`lspv | grep -w $HD | awk {' print $3 '}`
CAP=`lsmpio -ql $HD | grep Capacity | awk {' print $2 '}`
VN=`lsmpio -ql $HD | grep "Volume Name" | awk {' print $3 '}`
VS=`lsmpio -ql $HD | grep "Volume Serial" | awk {' print $3 '}`
VM=`lsvg $VG | grep "VG Mode:" | awk {' print $3 '}`
echo $HD,$VG,$VM,$CAP,$VN,$VS
done 2> /dev/null
echo "=== WWN ==="
for f in `lsdev -Cc adapter | grep fcs | awk {' print $1 '}`; do echo $f && lscfg -vl $f | grep "Network Address"; done | xargs -L 2
