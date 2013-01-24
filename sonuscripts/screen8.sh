#!/bin/bash

emacs -mm -q -l /home/sonu/.emacs_latest >&/dev/null 2>&1 &
/opt/firefox/firefox --no-remote -P reddit 1>&/dev/null 2>&1 &
#gsynaptics 1>&/dev/null 2>&1 &
echo "sonu" | sudo -S mount /dev/sda5 /mnt/debian/
