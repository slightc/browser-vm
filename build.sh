#!/usr/bin/env bash

BUILD_ROOT_RELEASE=2022.08.1

mkdir -p source
mkdir -p dist

get_source() {
    (
        cd source
        wget -c http://buildroot.org/downloads/buildroot-${BUILD_ROOT_RELEASE}.tar.gz
        tar xzf buildroot-${BUILD_ROOT_RELEASE}.tar.gz
    )
}

start_build() {
    (
        cd source/buildroot-${BUILD_ROOT_RELEASE}
        echo $PWD
        make BR2_EXTERNAL=../../buildroot-v86 v86_defconfig \
            && make legal-info \
            && make
    )
}

get_source
# start_build
