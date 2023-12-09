#!/bin/bash

ci/build_zst.sh
scripts/release-rpm.sh /opt/kime-out
