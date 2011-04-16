#! /bin/bash

# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.

# Install script

thisDir="""$(dirname "$0")"""
: ${FSTAB_D_DIR:=/etc/fstab.d}
: ${RULES_D_DIR:=/etc/udev/rules.d}
: ${CONFDIR:=/usr/local/etc/farcaster}

declare -A INSTALL_DIRS=()

INSTALL_DIRS=(["${thisDir}/fstab"]="${DESTDIR}${FSTAB_D_DIR}"
              ["${thisDir}/udev"]="${DESTDIR}${RULES_D_DIR}"
              ["${thisDir}/storage"]="${DESTDIR}${CONFDIR}/storage.d"
)

for d in "${!INSTALL_DIRS[@]}"; do
  for i in "$d"/*; do
    [ -f "$i" ] && install -Dm644 "$i" """${INSTALL_DIRS[$d]}/$(basename "$i")""" || exit 1
  done
done

mkdir -p "${DESTDIR}${CONFDIR}"
cat "${thisDir}/storage.in" | sed -e "s,@CONFDIR@,$CONFDIR,g" > "${DESTDIR}${CONFDIR}/storage.conf"
chmod 644 "${DESTDIR}${CONFDIR}/storage.conf"