#!/bin/bash

function set_keyboard_layout () {
0
}

function verify_boot_mode {
0;
}

function ensure_internet_connection {
ping -w 10 -c 5 www.google.com | grep "64 bytes";
}

function update_system_clock {
timedatectl set-ntp true;
}

function partition_disks () {
0;
}

function format_the_partitions {
0
}



