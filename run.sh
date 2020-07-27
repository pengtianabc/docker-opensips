#!/bin/bash

HOST_IP=$(ip route get 8.8.8.8 | head -n +1 | tr -s " " | cut -d " " -f 7)

sed -i "s/listen=.*/listen=udp:${HOST_IP}:5060 use_workers 8 use_auto_scaling_profile PROFILE_SIP/g" /etc/opensips/opensips.cfg

# skip syslog and run opensips at stderr
/usr/sbin/opensips -FE -n 10 -N 20 -m 1024 -m 256
