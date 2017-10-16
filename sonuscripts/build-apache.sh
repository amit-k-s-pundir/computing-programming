#!/bin/bash

# Notes: *socache*, *mod-privileges*, *mod-systemd* related modules are being omitted
# for now because of the lack of required pre-requisites. Probably,
# will try later.

config_opts="--with-included-apr --prefix=/opt/apache2 
--enable-maintainer-mode --enable-modules=all
--enable-mods-shared=all --enable-load-all-modules --enable-debugger-mode 
--enable-authn-anon --enable-authn-dbd --enable-authn-socache
--enable-authz-owner --enable-authz-dbd --enable-auth-form
--enable-auth-digest  --enable-apreq --enable-file-cache
--enable-cache --enable-cache-disk --enable-watchdog --enable-macro 
--enable-dbd --enable-bucketeer --enable-dumpio --enable-echo
--enable-example --enable-example-hooks --enable-case-filter --enable-case-filter-in
--enable-example-ipc --enable-buffer --enable-data --enable-ratelimit --enable-reqtimeout 
--enable-ext-filter --enable-request --enable-include --enable-reflector 
--enable-substitute --enable-charset-lite --enable-deflate
--enable-xml2enc --enable-proxy-html --enable-http --enable-log-debug
--enable-log-forensic --enable-logio --enable-mime-magic
--enable-expires --enable-headers --enable-ident --enable-usertrack
--enable-unique-id --enable-proxy --enable-proxy-connect
--enable-proxy-ftp --enable-proxy-http --enable-proxy-fcgi
--enable-proxy-scgi --enable-proxy-fdpass --enable-proxy-ajp
--enable-proxy-balancer --enable-session --enable-session-cookie
--enable-session-dbd --enable-ssl
--enable-optional-hook-export --enable-optional-hook-import
--enable-optional-fn-export --enable-optional-fn-import --enable-unixd 
 --enable-heartmonitor --enable-dav --enable-status --enable-asis --enable-info --enable-suexec 
--enable-cgi --enable-cgid --enable-dav-fs --enable-dav-lock --enable-vhost-alias 
--enable-imagemap --enable-actions --enable-speling --enable-userdir --enable-alisas 
--enable-rewrite --enable-suexec-capabilities --enable-v4-mapped
--enable-so";

#echo "${config_opts}";

pushd /opt/sources/apache/httpd-git/
./configure $config_opts && make && make install
popd

1			       
