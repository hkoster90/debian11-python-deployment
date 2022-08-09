#!/bin/bash

CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

apt update
apt upgrade -y
apt dist-upgrade -y

apt install wget git curl build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y

mkdir /tmp/debian11-python-deployment

git clone https://github.com/nerdlertech/debian11-python-deployment.git /tmp/debian11-python-deployment

cd /tmp/debian11-python-deployment

wget wget https://www.python.org/ftp/python/3.10.5/Python-3.10.5.tgz
tar -xf Python-3.10.*.tgz
cd Python-3.10.*/
./configure --enable-optimizations
make -j $CORES
make altinstall
python3.10 --version
cd ..
pip3.10 install -r requirements.txt
