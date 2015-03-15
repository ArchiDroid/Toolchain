#!/bin/bash

#     _                _      _  _____              _
#    / \    _ __  ___ | |__  (_)|_   _|___    ___  | |
#   / _ \  | '__|/ __|| '_ \ | |  | | / _ \  / _ \ | |
#  / ___ \ | |  | (__ | | | || |  | || (_) || (_) || |
# /_/   \_\|_|   \___||_| |_||_|  |_| \___/  \___/ |_|
#
# Copyright 2015 Łukasz "JustArchi" Domeradzki
# Contact: JustArchi@JustArchi.net
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script is used to make additional symbolic links for arm-eabi- prefix
# Such prefix is required e.g. for AOSP tree, so toolchain can be used for building AOSP
# If you're not me, you don't need to run this script, unless you add some binaries to bin/

set -eu

cd "$(dirname "$0")"
if [[ -d "bin" ]]; then
	cd "bin"
	while read BINARY; do
		TOOL="arm-eabi-$(awk -F '-' '{print $NF}' < <(echo "$BINARY"))"
		if [[ ! -e "$TOOL" ]]; then
			ln -s "$BINARY" "$TOOL"
			echo "Linked: $TOOL"
		fi
	done < <(find . -type f)
else
	echo "ERROR: No bin folder?"
	exit 1
fi

exit 0
