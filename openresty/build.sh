#!/bin/bash


DISTRO='ubuntu'
D_RELEASE='precise'
OR_VERSION='1.9.7.4'

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


if [ $D_RELEASE == 'precise' ]
then 
   BUILDER=/build-scripts/build-package-ubuntu-precise
else 
   BUILDER=/build-scripts/build-package
fi

rm -rf out
mkdir out

docker run --rm -e DISTRO=$DISTRO \
                -e D_RELEASE=$D_RELEASE \
                -e OR_VERSION=$OR_VERSION \
                -v $(pwd)/build-scripts:/build-scripts:ro \
                -v $(pwd)/out:/out  \
                -w /build-scripts ${DISTRO}-${D_RELEASE}-fpm-build:1 \
                $BUILDER

cp out/*.deb ./
