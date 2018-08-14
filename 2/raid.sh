#!/bin/bash
# check for 1 partition exists
declare -a unparted
for disk in $(lsblk | grep disk | cut -d ' ' -f 1); do
	if [ ! -b /dev/${disk}1 ];
	then
	unparted=("${unparted[@]}" "${disk}")
	fi
done
# got list of unparted disks
echo ${unparted[@]}
# making partitions
for device in ${unparted[@]};
do
	echo $device;
	./create_partition.exp /dev/${device};
#	sleep 1;
done
# making partitions string
for dev in ${unparted[@]}; do
        devices_string+="/dev/${dev}1 ";
done
# partitions count
count=${#unparted[@]}
# creating raid
mdadm --create --verbose /dev/md0 --level=5 --raid-devices=${count} $devices_string
# create fs
mkfs.ext4 /dev/md0
# make config file
mkdir -p /etc/mdadm
mdadm --detail --scan >> /etc/mdadm/mdadm.conf
# make mount point
mkdir /raid
# automount raid
echo "/dev/md0      /raid     ext4    defaults    1 2" >> /etc/fstab
mount -a
