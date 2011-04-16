#! /bin/bash

# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.

# Install script

drives=(02 01)

thisDir="""$(dirname "$0")"""
: ${FSTAB_D_DIR:=/etc/fstab.d}
: ${RULES_D_DIR:=/etc/udev/rules.d}
: ${CONFDIR:=/usr/local/etc/farcaster}
: ${MNTDIR:=/mnt}
mkdir -p "${DESTDIR}/${CONFDIR}"
shScript="FARCASTER_MOUNTPOINTS=("

for i in "${drives[@]}"; do
  # fstab.d mount rule
  install -Dm644 "${thisDir}/90-shareddata$i" "${DESTDIR}${FSTAB_D_DIR}/90-shareddata$i" || exit 1
  # udev rule
  install -Dm644 "${thisDir}/90-shareddata$i.rules" "${DESTDIR}${RULES_D_DIR}/90-shareddata$i.rules" || exit 1
  # mountpoint
  install -d "${DESTDIR}/${MNTDIR}/shareddata$i" || exit 1
  shScript+="/${MNTDIR}/shareddata$i"$'\n''                       '
done
shScript+=")"$'\n'
echo "$shScript" > "${DESTDIR}/${CONFDIR}/storage.conf"


