#!/bin/bash

kernel_sources=${1:=linux}
kernel_dir=${2:="/home/sonu/kernel"}
kernel_config=${3:="/home/sonu/kernels/config_latest"}

function help(){
echo
echo "Usage: updategentookernel.sh [kernel_sources] [kernel_dir] [kernel_config]"
echo "kernel_sources: The name of the compressed or uncompressed file [or folder] \
that contains the linux kernel sources."
echo "kernel_dir: The base directory of the compressed file containing the linux \
sources or that of the folder containing the uncompressed linux sources. For example, \
the ${kernel_dir} for /usr/src/linux/ would be /usr/src/."
echo "kernel_config: The full path of the configuration file for the last successfully \
compiled kernel."
exit
}

pushd ${kernel_dir}/${kernel_sources}
cp ../${kernel_config} ./.config 

genkernel --kerneldir "${kernel_dir}" --kernel-config "${kernel_config}" --lvm2--splash --no-install --no-clean --menuconfig all

