#!/bin/bash
# Copy the system to a mounted drive excluding problematic directories

SOURCE="/"
TARGET="/mnt/"
MOUNTPOINT="/mnt"
DRIVE="/dev/sdb1"
EXCLUDES="--exclude=/proc --exclude=/sys --exclude=/dev --exclude=/mnt --exclude=/boot --exclude=/etc/fstab"
LOG="logger $0:"
RSYNCOPTS="--stats -a --numeric-ids"
RSYNC="/usr/bin/rsync"


# check if /mnt is used and mount USB-Stick
if findmnt -m $MOUNTPOINT > /dev/null; then
  $LOG $MOUNTPOINT already in use
  exit 1
else
  mount $DRIVE $MOUNTPOINT
  $LOG $DRIVE mounted on $MOUNTPOINT
fi


# start copy
$LOG starting sync
$RSYNC $RSYNCOPTS $EXCLUDES $SOURCE $TARGET
$LOG finished sync

# umount /mnt
umount $MOUNTPOINT
$LOG $MOUNTPOINT unmounted