#!/bin/bash

rm -rf out
mkdir out
                                                                                              
docker run --rm -v $(pwd)/build-scripts:/build-scripts:ro \
                -v $(pwd)/out:/out  \
                -w /build-scripts ubuntu-xenial-fpm-build:1 \
                /build-scripts/build-package

cp out/*.deb ./
