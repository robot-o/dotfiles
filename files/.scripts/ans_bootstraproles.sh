#!/bin/sh
set -eo pipefail

read -r -p "role directory: " roledir

read -r -p "specify roles (space separated): " rolelist

for x in $rolelist; do
  ansible-galaxy role init --offline --init-path "${roledir}" "${x}";
done

