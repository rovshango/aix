#!/usr/bin/ksh
#
#              Check given filesystems volume group free space
#              ===============================================
#
# Script requires input as filesystem's full path
# As a result it will print its logical volume, volume group and free space in volume group
#
# Please note that this script written for only for AIX systems
# 
# Example run:
# ksh free_space.ksh /opt/example/path
#
################################################################################
# 19/03/2020 | Rovshan Pashayev     | v1.0   | Initial version
#
################################################################################

if [ "$1" == "" ]
then
        echo Provide file system path
        echo Example: ksh free_space.ksh /opt/example/path
        exit 1
else
        lv=`lsfs $1 | grep -v Name | awk {' print $1 '} | cut -f3 -d "/"`

        vg=`lslv $lv | grep "VOLUME GROUP" | awk {' print $6 '}`

        fvg=`lsvg $vg | grep FREE | awk -F'[()]' '{print $2}'`

        echo "$1 $lv $vg $fvg"
fi
