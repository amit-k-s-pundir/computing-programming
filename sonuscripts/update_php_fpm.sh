#!/bin/bash

pushd ${working_dir:="/home/sonu/programming/php"}

export PHP_VER=5.3.2
wget "http://launchpad.net/php-fpm/master/0.6/+download/php-fpm-0.6~$PHP_VER.tar.gz"
tar -zxvf "php-fpm-0.6~$PHP_VER.tar.gz"
"php-fpm-0.6-$PHP_VER/generate-fpm-patch"
