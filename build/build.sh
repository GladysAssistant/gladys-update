#!/bin/bash
set -e

if [ -z "$1" ]
  then
    echo "You must pass a specific tag."
    echo "Ex: ./build.sh v3.0.0"
    exit 1
fi

arch=$(arch)
os=$(uname -s)
dest_file=gladys-$1-$os-$arch.tar.gz

echo "Building file $dest_file"

# clean folder if exit
rm -rf gladys

# Cloning repository
git clone https://github.com/gladysassistant/Gladys gladys

# Go to folder
cd gladys

# Checkout to tags
git checkout tags/$1

# remove git folder
rm -rf .git

# install dependencies
yarn install

# build assets
grunt buildProd

# Move back
cd ..

# creating archive
tar zcvf $dest_file ./gladys