#!/bin/bash

wget http://www.scheme.com/download/pcsv8.4-i3le.tar.gz

tar xzf pcsv8.4-i3le.tar.gz

cd csv8.4/custom

./configure
make
make install