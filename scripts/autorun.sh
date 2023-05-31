#!/usr/bin/env bash
# Copyright 2023 Jorge Castro
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

#
# AUTORUN:
#
# This script simplifies your "recipe.yml" management whenever you simply want
# to "run everything automatically" based on whatever script files exist on disk.
#

# Helper functions.
yell() { echo "${0}: ${*}"; }
abort() { yell "${*}"; exit 0; }
die() { yell "${*}"; exit 1; }

# Determine which directory and script category we're executing under.
SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
SCRIPT_MODE="${1:-}"
if [[ -z "${SCRIPT_MODE}" ]]; then
    die "Missing script mode argument."
fi

# Ensure that a "scripts/" sub-directory exists for the "script category".
# Note that symlinks to other directories will be accepted by the `-d` check.
RUN_DIR="${SCRIPT_DIR}/${SCRIPT_MODE}"
if [[ ! -d "${RUN_DIR}" ]]; then
    abort "Nothing to do, since \"${RUN_DIR}\" doesn't exist."
fi

# Generate a numerically sorted array of all scripts (or symlinks to scripts),
# without traversing into deeper subdirectories (to allow the user to store
# helper libraries in subfolders without accidental execution). Sorting is
# necessary for manually controlling the execution order via numeric prefixes.
mapfile -t buildscripts < <(find -L "${RUN_DIR}" -maxdepth 1 -type f -name "*.sh" | sort -n)

# Exit if there aren't any scripts in the directory.
if [[ ${#buildscripts[@]} -eq 0 ]]; then
    abort "Nothing to do, since \"${RUN_DIR}\" doesn't contain any scripts in its top-level directory."
fi

# Now simply execute all of the discovered scripts, and provide the name of the
# current "script category" as an argument, to match the behavior of "build.sh".
for script in "${buildscripts[@]}"; do
    echo "[autorun.sh] Running [${SCRIPT_MODE}]: ${script}"
    "$script" "${SCRIPT_MODE}"
done
