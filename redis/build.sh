#!/bin/bash


DISTRO='ubuntu'
D_RELEASE='precise'
REDIS_VERSION='3.2.0'

for i in "$@"
do
    case $i in
        -d=*|--distro=*)
        DISTRO="${i#*=}"
        shift 
        ;;
        -r=*|--release=*)
        D_RELEASE="${i#*=}"
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
                -e D_RELEASE=$D_RELEASE \
                -e REDIS_VERSION=$REDIS_VERSION \
                -v $(pwd):/src_dir:ro \
                -v $(pwd)/out:/out  \
                -w /build-scripts ${DISTRO}-${D_RELEASE}-fpm-build:1 \
                /src_dir/build-scripts/build-package

#                $BUILDER

cp out/*.deb ./
