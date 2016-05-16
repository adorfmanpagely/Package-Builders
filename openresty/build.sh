#!/bin/bash


DISTRO='ubuntu'
RELEASE='precise'
VERSION='1.9.7.4'

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


if [ $RELEASE == 'precise' ]
then 
   BUILDER=/build-scripts/build-package-ubuntu-precise
else 
   BUILDER=/build-scripts/build-package
fi

rm -rf out
mkdir out

docker run --rm -e DISTRO=$DISTRO \
                -e RELEASE=$RELEASE \
                -e VERSION=$VERSION \
                -v $(pwd)/build-scripts:/build-scripts:ro \
                -v $(pwd)/out:/out  \
                -w /build-scripts ${DISTRO}-${RELEASE}-fpm-build:1 \
                $BUILDER

cp out/*.deb ./
