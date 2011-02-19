#! /bin/bash

# Install script

thisDir="""$(dirname "$0")"""
: ${FSTAB_D_DIR:=/etc/fstab.d}
: ${RULES_D_DIR:=/etc/udev/rules.d}

for i in $(seq -f %02g 2); do
  # fstab.d mount rule
  install -Dm644 "${thisDir}/90-shareddata$i" "${ROOT_DIR}${FSTAB_D_DIR}/90-shareddata$i" || exit 1
  # udev rule
  install -Dm644 "${thisDir}/90-shareddata$i.rules" "${ROOT_DIR}${RULES_D_DIR}/90-shareddata$i.rules" || exit 1
  # mountpoint
  install -d "${ROOT_DIR}/mnt/shareddata$i" || exit 1
done
