#!/bin/bash


DISTRO='ubuntu'
D_RELEASE='precise'
AWS_VERSION='1'

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
                -e AWS_VERSION=$AWS_VERSION \
                -v $(pwd)/build-scripts:/build-scripts:ro \
                -v $(pwd)/out:/out  \
                -w /build-scripts ${DISTRO}-${D_RELEASE}-fpm-build:1 \
                /build-scripts/build-package

#                $BUILDER

cp out/*.deb ./
