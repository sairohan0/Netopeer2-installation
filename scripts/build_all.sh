#!/bin/bash

mkdir -p /opt/sysroots/x86_64/lib /opt/sysroots/x86_64/include /opt/sysroots/x86_64/pkgconfig
bash "$(dirname "$0")/install/x86/install_x86.sh"
mkdir -p /opt/sysroots/arm32/lib /opt/sysroots/arm32/include /opt/sysroots/arm32/pkgconfig
bash "$(dirname "$0")/install/arm32/install_arm32.sh"
mkdir -p /opt/sysroots/arm64/lib /opt/sysroots/arm64/include /opt/sysroots/arm64/pkgconfig
bash "$(dirname "$0")/install/arm64/install_arm64.sh"
