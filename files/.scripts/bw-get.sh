#!/bin/bash
set -euo pipefail

KEYCHAIN_ITEM="bitwarden_session_token"

exec 2>/dev/null

export BW_SESSION=$(security find-generic-password -a "$USER" -s "$KEYCHAIN_ITEM" -w || true)

if [[ -z "$BW_SESSION" ]] || ! bw unlock --check --session "$BW_SESSION" >/dev/null; then
  MPW=$(osascript <<EOF
    display dialog "bw-get - enter bw password:" with hidden answer default answer "" buttons {"OK"} default button "OK"
    text returned of result
EOF
  )

  export BW_SESSION=$(bw unlock "$MPW" --raw)
  unset MPW

  security delete-generic-password -a "$USER" -s "$KEYCHAIN_ITEM" || true
  security add-generic-password -a "$USER" -s "$KEYCHAIN_ITEM" -w "$BW_SESSION"
fi

bw get password "$1" --session "$BW_SESSION"
