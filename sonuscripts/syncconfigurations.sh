#!/bin/bash

# Configure files to be copied.
CONFIGURATION_FILES=".emacs* .vim* .gvim* .plt* .azureus/ .bash* .clisp
.clojure* .psql* .recently-used .sbcl/ .sbcl* .slime/ .slime* .config/
.config_latest .elinks/ .emacs.d/ .inputrc .links/ .lispworks
.lispworks-config/ .mozilla/ .opera/ .w3m/ .wallpapers/ .xsession"

SRC_DIR={1:-"/home/sonu"}
DEST_DIR={2:-"/mnt/usbstorage/linux/installation/home/sonu"}

if [2 -ne "$#"]; then echo "This command onlt accepts arguments in thre rsync
	format"; fi

for file in CONFIGURATION_FILES
do rsync SRC_DIR/file DEST_DIR/
done

