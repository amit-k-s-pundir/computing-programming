#!/bin/bash
#===============================================================================
#
#          FILE:  install_debian_on_new_partition.sh
# 
#         USAGE:  ./install_debian_on_new_partition.sh 
# 
#   DESCRIPTION:  Installs a fresh copy of debian on a new partition (or a hard disk) using an existing partition (or a hard disk) with a Linux OS.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Wednesday 21 April 2010 02:35:45  IST IST
#      REVISION:  ---
#===============================================================================

debian_mirror=http://http.us.debian.org/debian/dists/lenny/main/installer-i386/current/images
wget -N -c "${debian_mirror}/hd-media/initrd.gz"
wget -N -c "${debian_mirror}/hd-media/vmlinuz"

