#!/usr/bin/env bash
# Copyright 2023 JosSamLoh
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Tell this script to exit if there are any errors.
set -oue pipefail

FEDORA_VERSION="$(cat /usr/lib/os-release | grep -Po '(?<=VERSION_ID=)\d+')"
INSTALLED_KERNEL_PACKAGES="$(rpm -qa --qf "%{NAME}\n" | grep -P '^kernel(?!-tools).*')"

printf "### Fedora version ###\n$FEDORA_VERSION\n\n"

# Add required kernel repo
# Run script with sudo or add sudo to below if using script locally
wget -P /etc/yum.repos.d/ \
    "https://linux-libre.fsfla.org/pub/linux-libre/rpmfreedom/latest.repo"
# wget -P /etc/yum.repos.d/ ".REPO URL"

printf "### Packages to be replaced ###\n$INSTALLED_KERNEL_PACKAGES\n\n"
sleep 2

# Use rpm-ostree's cliwrap to allow dracut to run on the container and generate
# an initramfs.
### COMMENT OUT BELOW LINE IF USING LOCALLY ###
rpm-ostree cliwrap install-to-root / && \
rpm-ostree override remove $INSTALLED_KERNEL_PACKAGES --install=kernel
# rpm-ostree override remove $INSTALLED_KERNEL_PACKAGES --install=kernel-specified
# rpm-ostree override replace "URL/kernel-name.rpm"

#
## This script is best for repos which have named their packages nicely, like
## XanMod, where the above remove/replace lines usually work without issues and
## pulling files from the repo isn't necessary
#
