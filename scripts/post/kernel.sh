#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
rpm-ostree override replace https://linux-libre.fsfla.org/pub/linux-libre/rpmfreedom/latest/RPMS/x86_64/kernel-6.3.5_gnu-1.x86_64.rpm
