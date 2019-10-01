#!/bin/bash

#install the snapd
dnf install -y snapd
>&2 echo "Remember to logout/reboot to complete snap build"
