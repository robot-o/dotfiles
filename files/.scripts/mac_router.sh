#!/bin/bash
sudo sysctl -w net.inet.ip.forwarding=1
sudo sysctl -w net.inet.ip.fw.enable=1
echo "nat on en0 from ${1:-10.13.37.0/24} to any -> ${2:-192.168.178.82}" | sudo pfctl -v -ef - 
