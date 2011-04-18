#!/bin/bash
#===============================================================================
#
#          FILE:  s.sh
# 
#         USAGE:  ./s.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   (), 
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  Wednesday 16 December 2009 08:45:23  IST IST
#      REVISION:  ---
#===============================================================================

sqlite3 test.db "create table t1 (t1key INTEGER PRIMARY KEY,
data TEXT, num double, timeEnter date);"
sqlite3 test.db "insert into t1 (data,num) values ('This is sample data', 3);"
sqlite3 test.db "select * from sqlite_master"
sqlite3 test.db "select * from t1 limit 2;"
sqlite3 test.db "insert into t1 (data, num) values('More sample data', 6);"
sqlite3 test.db "insert into t1 (data, num) values('And a little more', 9);"







