#!/bin/sh
# post-build.sh for OrangePi taken from CubieBoard's post-build.sh
# 2013, Carlo Caione <carlo.caione@gmail.com>

BOARD_DIR="$(dirname $0)"
MKIMAGE=$HOST_DIR/bin/mkimage
BOOT_CMD=$BOARD_DIR/boot.cmd
BOOT_CMD_H=$BASE_DIR/target/boot/boot.scr

# U-Boot script
$MKIMAGE -C none -A arm -T script -d $BOOT_CMD $BOOT_CMD_H

FEX2BIN=$HOST_DIR/bin/fex2bin
SCRIPT_BIN=$BOARD_DIR/script.fex
SCRIPT_BIN_H=$BASE_DIR/target/boot/script.bin

$FEX2BIN $SCRIPT_BIN $SCRIPT_BIN_H
