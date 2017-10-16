#!/bin/bash

qemu-img create archlinux.img 25G
qemu -hda archlinux.img -cdrom arch-install-cd.iso -boot order menu=on -m 4G
