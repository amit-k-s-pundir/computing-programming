#!/bin/bash

BASEDIR=/opt/lisp/scheme/

pushd "${BASEDIR}"
svn checkout http://svn.plt-scheme.org/plt/trunk plt
pushd ./plt/
./configure && make && make install && make clean
popd
popd
