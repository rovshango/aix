#!/usr/bin/ksh
#
#              FCS Adapter Firmware number and Card ID
#              =======================================
#
#
# Example run:
# ksh fc_microcode_info.ksh
#
# 
################################################################################
# 20/05/2020 | Rovshan Pashayev     | v1.0   | Initial version
# 21/05/2020 | Rovshan Pashayev     | v1.1   | Virtual adapter check added
#
################################################################################

osversion=`oslevel -s`
servername=`hostname`

lsdev -C | grep fcs | grep -i virtual 1> /dev/null
if [ "$?" -eq "0" ]; then echo "cvai" | kdb | grep vscsi; fi

for i in `lsdev -C | grep fcs | grep -v -i virtual | awk {' print $1 '}`
do
echo $servername
echo $osversion
echo $i && lsmcode -r -d $i && lscfg -vl $i | grep "Customer Card ID Number" | tr -d " "
done | xargs -L 5
