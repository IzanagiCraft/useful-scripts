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

# Check if ./execute.sh exists and is executable
if [ -x "./execute.sh" ]; then
    # Pass parameters to execute.sh
    ./execute.sh "$@"
# Check if ./execute exists and is executable
elif [ -x "./execute" ]; then
    # Pass parameters to execute
    ./execute.sh "$@"
else
    echo "Error: Neither './execute.sh' nor './execute' found or not executable."
    exit 1
fi
