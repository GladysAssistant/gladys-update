#!/bin/bash

GLADYS_VERSION=3.5.1

TMP_HOOK_FOLDER="/tmp/gladys_hooks"
TMP_CACHE_FOLDER="/tmp/gladys_cache"
GLADYS_FOLDER="/home/pi/gladys"

# Cleaning Gladys hook folder
rm -rf $TMP_HOOK_FOLDER

# Cleaning Gladys cache folder
rm -rf $TMP_CACHE_FOLDER

# We copy the hooks repository of the old folder
cp -ar /home/pi/gladys/node_modules/gladys/api/hooks/. $TMP_HOOK_FOLDER

# We copy the cache folder of the old gladys
cp -ar /home/pi/gladys/node_modules/gladys/cache/. $TMP_CACHE_FOLDER

# download update
wget https://s3-eu-west-1.amazonaws.com/gladys-build/gladys-$GLADYS_VERSION-Linux-armv6l.tar.gz

# stop gladys
pm2 stop --silent gladys

# Delete current gladys install
rm -rf $GLADYS_FOLDER

#  install gladys 
tar zxvf gladys-$GLADYS_VERSION-Linux-armv6l.tar.gz gladys/

# move back hooks & cache
mv $TMP_HOOK_FOLDER $GLADYS_FOLDER/api/hooks
mv $TMP_CACHE_FOLDER $GLADYS_FOLDER/cache

# init 
cd $GLADYS_FOLDER
node init.js

# build assets
grunt buildProd

# restart gladys
pm2 start gladys