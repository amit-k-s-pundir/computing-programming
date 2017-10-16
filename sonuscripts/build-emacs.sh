#!/bin/bash

work_dir=/opt/sources/emacs

pushd $work_dir
#echo "In `pwd`"
make distclean && ./autogen.sh && ./configure --prefix=/opt/emacs-dev && make bootstrap && make && make install

popd
