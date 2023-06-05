#!/usr/bin/ksh
#
# If AIX system has physical network adapters,
# with following "for" "loop" you can extract list of Aggregated, VLAN interfaces with IP address
#
################################################################################
# 02/06/2020 | Rovshan Pashayev     | v1.1   | Comments added
#
################################################################################

for i in `lsdev -Cc adapter | grep -e Aggregation -e VLAN | awk {' print $1 '}`
do
if=$(echo $i | sed 's/t//') 
echo === $i === 
echo ip_address `ifconfig $if | grep inet | awk {' print $2 '}`
lsattr -El $i | grep -e adapter -e vlan_tag_id | awk {' print $1, $2 '} | grep -v hash
done | tr " " "\t"