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

while true; do
    echo "Which server do you want to connect to?"
    echo ""
    echo "1. Connect to root@izanagicraft."
    echo ""
    echo "0. Exit script."
    echo ""
    read -p "Choice: " option

    case $option in
        1)
            echo "Connecting via ssh to root@izanagicraft..."
            sleep 1
            ssh -p 22 root@127.0.0.1
            ;;
        0)
            echo "Bye :)"
            sleep 1
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            ;;
    esac
done
