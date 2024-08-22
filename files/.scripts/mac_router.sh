#!/bin/bash

case "$1" in
    on)
      sudo sysctl -w net.inet.ip.forwarding=1
      echo "nat on en0 from ${2:-10.13.37.0/24} to any -> ${3:-192.168.178.82}" | sudo pfctl -v -ef - 
      ;;
    off)
      sudo sysctl -w net.inet.ip.forwarding=0
      sudo pfctl -F nat
      ;;
    *)
        echo "Missing arguments, brudda"
        exit 1
esac
