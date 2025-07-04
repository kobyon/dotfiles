#!/bin/sh -e

LUKS_DEV=/dev/disk/by-uuid/f14dcf1f-1d92-4e6b-bebb-a3c4faf5662e
sudo systemd-cryptenroll --wipe-slot=tpm2 $LUKS_DEV
#sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs="1+7+8+11+14:sha256" --tpm2-with-pin=true "$@" $LUKS_DEV
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs="1+7+8+11+14:sha256" "$@" $LUKS_DEV
