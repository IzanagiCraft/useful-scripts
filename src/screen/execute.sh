#!/bin/bash

#
#/*
# * ▪  ·▄▄▄▄• ▄▄▄·  ▐ ▄  ▄▄▄·  ▄▄ • ▪   ▄▄· ▄▄▄   ▄▄▄· ·▄▄▄▄▄▄▄▄
# * ██ ▪▀·.█▌▐█ ▀█ •█▌▐█▐█ ▀█ ▐█ ▀ ▪██ ▐█ ▌▪▀▄ █·▐█ ▀█ ▐▄▄·•██
# * ▐█·▄█▀▀▀•▄█▀▀█ ▐█▐▐▌▄█▀▀█ ▄█ ▀█▄▐█·██ ▄▄▐▀▀▄ ▄█▀▀█ ██▪  ▐█.▪
# * ▐█▌█▌▪▄█▀▐█ ▪▐▌██▐█▌▐█ ▪▐▌▐█▄▪▐█▐█▌▐███▌▐█•█▌▐█ ▪▐▌██▌. ▐█▌·
# * ▀▀▀·▀▀▀ • ▀  ▀ ▀▀ █▪ ▀  ▀ ·▀▀▀▀ ▀▀▀·▀▀▀ .▀  ▀ ▀  ▀ ▀▀▀  ▀▀▀
# *
# *
# *    @@@@@
# *    @@* *@@
# *      @@@  @@@
# *         @@@  @@ @@@       @@@@@@@@@@@
# *           @@@@@@@@   @@@@@@@@@@@@@@@@@@@@@
# *            @@@    @@@@@@@@@@@@@@@@@@@@@@@@@@@
# *                 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# *                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# *                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# *               #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# *               #@@@   @@                 @@  @@@@  @@@@
# *                @@@@      @@@      @@@@      @@@@   @@@
# *                @@@@@@                     @@@@@@    @@
# *                 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# *                  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# *                   @@@@@@@@@@@@@@@@@@@@@@@@@@@
# *                     @@@@@@@@@@@@@@@@@@@@@@@
# *                       @@@@@@@@@@@@@@@@@@@
# *                           @@@@@@@@@@@
# *
# * Copyright (c) 2023 - present | sanguine6660 <sanguine6660@gmail.com>
# * Copyright (c) 2023 - present | izanagicraft.com <contact@izanagicraft.com>
# * Copyright (c) 2023 - present | izanagicraft.com team and contributors
# *
# * This program is free software: you can redistribute it and/or modify
# * it under the terms of the GNU General Public License as published by
# * the Free Software Foundation, either version 3 of the License, or
# * (at your option) any later version.
# *
# * This program is distributed in the hope that it will be useful,
# * but WITHOUT ANY WARRANTY; without even the implied warranty of
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# * GNU General Public License for more details.
# *
# * You should have received a copy of the GNU General Public License
# * along with this program.  If not, see <https://www.gnu.org/licenses/>.
# */

SCREEN_NAME="$(cat .servicename)"
FINAL_SCREEN_NAME="$SCREEN_NAME"

if [ -z "$SCREEN_NAME" ]; then
    FINAL_SCREEN_NAME=$(basename "$(realpath .)")
else
    FINAL_SCREEN_NAME="$SCREEN_NAME"
fi

# Check if the screen session exists
if ! screen -list | grep -q "$FINAL_SCREEN_NAME"; then
    echo "Error: Screen session '$FINAL_SCREEN_NAME' not found."
    exit 1
fi

echo "Applying command to '$FINAL_SCREEN_NAME' '$1'"
screen -x $FINAL_SCREEN_NAME -X stuff "$1^M"
echo "Sent command to server!"
