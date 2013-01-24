#!/bin/bash

dir=${1:-"/home/sonu/workspace/programming/sources"};

pushd $dir;

find ${dir} -regextype posix-extended -maxdepth 4 -type d -iregex '.*\.svn$' -o -iregex '.*\.git$'

popd;
