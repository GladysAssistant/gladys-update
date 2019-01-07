#!/bin/bash

GLADYS_VERSION=3.7.4

TMP_HOOK_FOLDER="/tmp/gladys_hooks"
TMP_CACHE_FOLDER="/tmp/gladys_cache"
GLADYS_FOLDER="/home/pi/gladys"

# Cleaning Gladys hook folder
rm -rf $TMP_HOOK_FOLDER

# Cleaning Gladys cache folder
rm -rf $TMP_CACHE_FOLDER

# Creating temp folder
mkdir $TMP_HOOK_FOLDER
mkdir $TMP_CACHE_FOLDER

# We copy the hooks repository of the old folder
cp -ar $GLADYS_FOLDER/api/hooks/. $TMP_HOOK_FOLDER

# We copy the cache folder of the old gladys
cp -ar $GLADYS_FOLDER/cache/. $TMP_CACHE_FOLDER

# download update (-N allow to don't retrieve file unless newer than local)
wget -N https://github.com/gladysassistant/Gladys/releases/download/v3.7.4/gladys-v3.7.4-Linux-armv6l.tar.gz

# stop gladys
pm2 stop --silent gladys

# Delete current gladys install
rm -rf $GLADYS_FOLDER

#  install gladys 
tar zxvf gladys-v$GLADYS_VERSION-Linux-armv6l.tar.gz

# move back hooks & cache
cp -ar $TMP_HOOK_FOLDER/. $GLADYS_FOLDER/api/hooks
cp -ar $TMP_CACHE_FOLDER/. $GLADYS_FOLDER/cache

# init 
cd $GLADYS_FOLDER
node init.js

# build assets
grunt buildProd

# restart gladys
pm2 start /home/pi/gladys/app.js --name gladys