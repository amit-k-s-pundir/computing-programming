#!/bin/bash

#work_dir=/home/sonu/programming_docs/
pushd ${work_dir:=/home/sonu/programming_docs/linux_docs/abs_guide/}
wget -EN -ckp http://www.tldp.org/LDP/abs/html/abs-guide.html
popd
