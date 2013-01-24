#!/bin/sh

for x in */ ; do
  tar cf - --exclude .svn "$x" | gzip > "${x%/}.tar.gz"
done

