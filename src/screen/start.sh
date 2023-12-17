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

# Set the path to your Java application JAR file
JAR_PATH="server.jar"

# Set the maximum amount of RAM for the server
MAX_RAM="2G"

# Set additional Java arguments for the server
JAVA_ARGS="-Xms512M -XX:+ExitOnOutOfMemoryError"

# Additional recommended Java arguments
JAVA_ARGS="$JAVA_ARGS -XX:+UseG1GC"          # Use the Garbage-First (G1) Garbage Collector
JAVA_ARGS="$JAVA_ARGS -Dfile.encoding=UTF-8" # Set the file encoding to UTF-8

# Adjust the following values based on your application's requirements
JAVA_ARGS="$JAVA_ARGS -XX:MaxGCPauseMillis=200" # Set the maximum GC pause time goal
JAVA_ARGS="$JAVA_ARGS -XX:G1HeapRegionSize=16M" # Set the G1 Heap region size

# Set additional process arguments for the Java application (optional)
PROCESS_ARGS="nogui"

# Set the screen name (for screen session)
SCREEN_NAME="" # Empty or unset for automatic folder name

# =================================================================================================== #
# =================================================================================================== #
# =================================================================================================== #

FINAL_SCREEN_NAME=""

# Check if SCREEN_NAME is set; if not, use the parent folder name as the service name
if [ -z "$SCREEN_NAME" ]; then
    FINAL_SCREEN_NAME=$(basename "$(realpath .)")
else
    FINAL_SCREEN_NAME="$SCREEN_NAME"
fi

# output the servername as .servicename file
echo "$FINAL_SCREEN_NAME" > .servicename

# Start the server in a new screen session
if [ "$#" -eq 1 ]; then
    if [ "$1" == "inscreen" ]; then
        for i in 5 4 3 2 1; do
            echo "Starting Server in $i seconds..."
            sleep 1
        done
        # Executed when Parameter "inscreen"...
        while true; do
            java -server -Xmx$MAX_RAM $JAVA_ARGS -jar $JAR_PATH $PROCESS_ARGS
            echo "Attempting to restart server..."
            echo "To abort the restart, press Ctrl+C!"
            for i in 5 4 3 2 1; do
                echo "Restarting in $i seconds..."
                sleep 1
            done
            echo "-- Restarting Server --"
        done
    fi
else
    # Check if the screen utility is installed
    if ! command -v screen > /dev/null 2>&1; then
        echo "Error: 'screen' utility is not installed. Please install it before running the server."
        exit 1
    fi

    # Check if a screen session with the same name is already running
    if screen -list | grep -q "$FINAL_SCREEN_NAME"; then
        echo "Attaching to existing screen session '$FINAL_SCREEN_NAME'..."
        screen -x "$FINAL_SCREEN_NAME"
        exit 0
    fi
    screen -dmS $FINAL_SCREEN_NAME bash $0 inscreen
    echo "Java server started in a screen session. Use 'screen -x $FINAL_SCREEN_NAME' or re-run the start script to attach to the session."
fi
