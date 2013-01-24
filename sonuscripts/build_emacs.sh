#!/bin/bash

work_dir=/opt/sources/emacs_dev_git_depth_1

pushd $work_dir
#echo "In `pwd`"
make distclean && ./autogen.sh && ./configure --prefix=/opt/emacs_dev && make bootstrap && make && make install

popd
