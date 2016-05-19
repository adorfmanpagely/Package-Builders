#!/bin/bash


DISTRO='ubuntu'
RELEASE='precise'
VERSION='1.0.10'

for i in "$@"
do
    case $i in
        -d=*|--distro=*)
        DISTRO="${i#*=}"
        shift 
        ;;
        -r=*|--release=*)
        RELEASE="${i#*=}"
        shift  
        ;;
        -v=*|--version=*)
        VERSION="${i#*=}"
        shift
        ;;
        *)
        ;;
    esac
done

rm -rf out
mkdir out

docker run --rm -e DISTRO=$DISTRO \
                -e D_RELEASE=$RELEASE \
                -e LS_VERSION=$VERSION \
                -v $(pwd)/build-scripts:/build-scripts:ro \
                -v $(pwd)/out:/out  \
                -w /build-scripts ${DISTRO}-${RELEASE}-fpm-build:1 \
                /build-scripts/build-package

cp out/*.deb ./
