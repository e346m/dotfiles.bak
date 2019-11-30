#!/bin/sh
if [ ! -d ${DOT_DIR} ]; then
    useradd -u 11003 -d ${DOT_DIR} -s /bin/bash -m eiji -G adm
fi

sed -i '/^eiji:.*$/d' /etc/shadow
echo 'eiji:$6$E9dQABOz$wz4xgcG4dOL9qnGlt3AoP0NbjCA5MnyCODv4K19Z/bIz2o5jyL//qYianmLCU3Wv7mjN7M7DHpNUQJO1oTNSv/:17403:0:99999:7:::' >> /etc/shadow
