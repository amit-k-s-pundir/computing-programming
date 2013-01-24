#!/bin/bash

read -p "Enter the name of the Wt installation directory [~/programming/candcplusplus/wt/]:"
base_directory;
base_directory=${base_directory:="~/programming/candcplusplus/wt/"};
pushd ${base_directory};
cmake -DBOOST_DIR='/opt/boost/' -DBOOST_VERSION='1_39' -DBOOST_COMPILER='gcc43' -DCONNECTOR_FCGI='yes' -DEXAMPLE_CONNECTOR='wtfcgi' ../
popd
