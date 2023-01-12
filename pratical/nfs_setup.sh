#!/bin/bash

# Run as root
rm /mnt/nfs/* -rf
mkdir -p /mnt/nfs/ctfd/202{1,2}/{log,opt,uploads}
mkdir -p /mnt/nfs/redis/202{1,2}
chown nobody:nogroup -R /mnt/nfs
chmod 777 -R /mnt/nfs
