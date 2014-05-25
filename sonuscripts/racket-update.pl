#!/bin/bash

# This creates an in-place install of racket which will then be move
# to the destination directory.
version=${1:-"6.0"}
os_type=${2:-"x86_64-linux-ubuntu-precise"}
racket_stable_download_url="http://mirror.racket-lang.org/installers/${version}/racket-${version}-${os-type}.sh"
# os-type is x86_64-linux-ubuntu-precise.sh"
download_dir=${2:-"/opt/downloads"}
