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

# Only process users with home directories, but skip the "root" user.
if [ "$(id -u)" != "0" ] && [ ! -z "$HOME" ] && [ -d "$HOME" ]; then
    # Ensure target file exists and is a symlink (not a regular file or dir).
    if [ ! -L "$HOME"/.config/autostart/ublue-firstboot.desktop ]; then
        # Remove any leftovers or incorrect (non-link) files with the same name.
        rm -rf "$HOME"/.config/autostart/ublue-firstboot.desktop

        # Create symlink to uBlue's autostart runner.
        # Note that "broken autostart symlinks" are harmless if they remain
        # after distro switching, and just cause a minor syslog warning. The
        # user can manually delete this file if they migrate away from uBlue.
        mkdir -p "$HOME"/.config/autostart
        ln -s "/usr/share/ublue-os/firstboot/launcher/autostart.desktop" "$HOME"/.config/autostart/ublue-firstboot.desktop
    fi
fi
