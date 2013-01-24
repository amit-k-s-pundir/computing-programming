#!/bin/bash

# Setup apt repositories if they don't already exist.

aptitude update

# 1. Install and update grub if not already.
aptitude install grub
grub-install ${boot_partition}
update-grub

# Install ssh.

# rsync everything!

# Install Perl.

# Install xorg.

# Install xfce4.

# Install VirtualBox.

# Install apache, nginx, ruby, gdb, emacs-snapshot, gvim, firefox etc.
