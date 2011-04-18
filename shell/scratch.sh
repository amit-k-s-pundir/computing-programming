#!/bin/bash

proj_name=${1};
proj_base_dir=${2:-"/home/sonu/workspace/projects/tc/design"};
working_dir="$proj_base_dir/$proj_name"
prog_name="$0"

#main;
usage () {
echo "sonu\n"
 echo "`basename ${prog_name}` proj_name [proj_dir]"
 exit 1;
 }

init! () {
#    read -p "Enter the name of the project (default is 
    [[ -z "${proj_name}" ]] && usage
   # usage
    }

function finish! {
    popd;
    }

function main {
    init!;               
   
    mkdir $working_dir;
    pushd $working_dir;

    #proj_name = ${proj_name:?"Enter the project's name"}
    
    wget -N -c http://topcoder.com/wiki/download/attachments/38671991/PSD-Source.zip
   
    finish!;
   
    exit 0;
    }

    main;
