#!/bin/bash


PRESENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rm -r $PRESENT_DIR/sysroots
cd $PRESENT_DIR
docker compose up --build
cp -r $PRESENT_DIR/sysroots /opt
