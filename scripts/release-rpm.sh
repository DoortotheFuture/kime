#!/usr/bin/env bash

KIME_PREFIX=51_kime

source $(dirname $0)/tool.sh

if [ -z "$1" ]; then
    echo "Usage: <release-rpm.sh> <out-path>"
    exit 1
fi

TARGET_PATH=$1
TMP_PATH=$(mktemp -d)
ARCH=$(uname -m)
VER=$(cat ./VERSION)

mkdir -pv $TMP_PATH/BUILD
mkdir -pv $TMP_PATH/RPMS/$ARCH
mkdir -pv $TMP_PATH/SOURCES
mkdir -pv $TMP_PATH/SPECS
mkdir -pv $TMP_PATH/SRPMS

cp scripts/kime.spec $TMP_PATH/SPECS
sed -i "s/%VER%/$VER/; s/%ARCH%/$ARCH/" $TMP_PATH/SPECS/kime.spec

KIME_INSTALL_HEADER=0 \
KIME_LIB_DIR=usr/lib64 \
KIME_QT5_DIR=usr/lib64/qt5 \
KIME_QT6_DIR=usr/lib64/qt6 \
scripts/install.sh $TMP_PATH/BUILD

rpmbuild -bb --target $ARCH --buildroot $TMP_PATH/BUILD $TMP_PATH/SPECS/kime.spec

mv $TMP_PATH/RPMS/$ARCH/*.rpm "${TARGET_PATH}/kime_$ARCH.rpm"
