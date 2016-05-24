# Package Builder scripts


This repo contains various build scripts for producing third party vendor packages. All packages should provide a simple build.sh script which can be run to build the package. This script should also support the following arguments:

- -d The distro to build the package for

- -r The release of the distro to build the package for

- -v The version of the package source to build and package

