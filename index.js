/**
 * ▪  ·▄▄▄▄• ▄▄▄·  ▐ ▄  ▄▄▄·  ▄▄ • ▪   ▄▄· ▄▄▄   ▄▄▄· ·▄▄▄▄▄▄▄▄
 * ██ ▪▀·.█▌▐█ ▀█ •█▌▐█▐█ ▀█ ▐█ ▀ ▪██ ▐█ ▌▪▀▄ █·▐█ ▀█ ▐▄▄·•██
 * ▐█·▄█▀▀▀•▄█▀▀█ ▐█▐▐▌▄█▀▀█ ▄█ ▀█▄▐█·██ ▄▄▐▀▀▄ ▄█▀▀█ ██▪  ▐█.▪
 * ▐█▌█▌▪▄█▀▐█ ▪▐▌██▐█▌▐█ ▪▐▌▐█▄▪▐█▐█▌▐███▌▐█•█▌▐█ ▪▐▌██▌. ▐█▌·
 * ▀▀▀·▀▀▀ • ▀  ▀ ▀▀ █▪ ▀  ▀ ·▀▀▀▀ ▀▀▀·▀▀▀ .▀  ▀ ▀  ▀ ▀▀▀  ▀▀▀
 *
 *
 *    @@@@@
 *    @@* *@@
 *      @@@  @@@
 *         @@@  @@ @@@       @@@@@@@@@@@
 *           @@@@@@@@   @@@@@@@@@@@@@@@@@@@@@
 *            @@@    @@@@@@@@@@@@@@@@@@@@@@@@@@@
 *                 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 *                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 *                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 *               #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 *               #@@@   @@                 @@  @@@@  @@@@
 *                @@@@      @@@      @@@@      @@@@   @@@
 *                @@@@@@                     @@@@@@    @@
 *                 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 *                  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
 *                   @@@@@@@@@@@@@@@@@@@@@@@@@@@
 *                     @@@@@@@@@@@@@@@@@@@@@@@
 *                       @@@@@@@@@@@@@@@@@@@
 *                           @@@@@@@@@@@
 *
 * Copyright (c) 2023 - present | sanguine6660 <sanguine6660@gmail.com>
 * Copyright (c) 2023 - present | izanagicraft.com <contact@izanagicraft.com>
 * Copyright (c) 2023 - present | izanagicraft.com team and contributors
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

const fs = require('fs').promises;
const bashMinifier = require('bash-minifier');

// Flag to determine whether to minify bash files
let minify = false;

// Check command line arguments for '--minify' flag
process.argv.forEach((arg) => {
    if (arg === '--minify') {
        minify = true;
    }
});

/**
 * Ensures that a directory exists, creating it if necessary.
 * @param {string} dir - The directory path.
 */
const ensureDirectoryExists = async (dir) => {
    try {
        await fs.access(dir);
    } catch (err) {
        await fs.mkdir(dir, { recursive: true });
    }
};

/**
 * Compares two file stats to check if they are equal.
 * @param {Object} object1 - The first file stat object.
 * @param {Object} object2 - The second file stat object.
 * @returns {boolean} - True if file stats are equal, false otherwise.
 */
function isStatEqual(object1, object2) {
    return Object.keys(object1).every((key) => object1[key] === object2[key]);
}

/**
 * Recursively walks through a directory, copying files and directories.
 * @param {string[]} ignore - Array of paths to ignore during copying.
 * @param {string} path - The source directory path.
 * @param {string} dist - The destination directory path.
 */
async function recursiveWalkAndCopy(ignore = [], path, dist = './dist') {
    console.log('Walking through ' + path);

    try {
        // Read the files in the source directory
        const files = await fs.readdir(path);

        for (const entity of files) {
            const currentPath = `${path}/${entity}`;
            const currentDest = currentPath.replace(path, dist);

            // Skip if the path is in the ignore list
            if (ignore.includes(currentPath) || ignore.includes(currentPath + '/')) continue;

            try {
                // Get the stats of the current file/directory
                const statCurrent = await fs.stat(currentPath);

                if (statCurrent.isDirectory()) {
                    // Recursively copy subdirectories
                    await recursiveWalkAndCopy(ignore, currentPath, currentDest);
                } else {
                    const distArgs = currentDest.split('/');
                    const filename = distArgs.pop();
                    const dir = distArgs.join('/');

                    // Ensure the destination directory exists
                    await ensureDirectoryExists(dir);

                    if (currentPath.endsWith('.sh')) {
                        // Process and minify bash files
                        const content = minify
                            ? bashMinifier(await fs.readFile(currentPath, 'utf8'))
                            : await fs.readFile(currentPath, 'utf8');
                        const newContent = (content.includes('#!/bin/bash') ? '' : '#!/bin/bash\n') + content;
                        const realDist = currentDest.replace(filename, filename.slice(0, -3));

                        // Check if content matches existing file
                        let oldContent = '';
                        try {
                            oldContent = await fs.readFile(realDist, 'utf8');
                        } catch (err) {}

                        if (newContent === oldContent) {
                            console.log('Skipping copy of', currentPath, 'content match in', realDist);
                            continue;
                        }

                        // Write minified content to destination
                        await fs.writeFile(realDist, newContent, { encoding: 'utf8', flag: 'w' });
                        console.log('Copied&Minified', currentPath, 'to', currentDest);
                        continue;
                    }

                    // Copy non-bash files
                    if (
                        await fs
                            .access(currentDest)
                            .then(() => true)
                            .catch(() => false)
                    ) {
                        console.log('Skipping copy of', currentPath, 'file exists', currentDest);
                        continue;
                    }

                    await fs.copyFile(currentPath, currentDest);
                    console.log('Copied', currentPath, 'to', currentDest);
                }
            } catch (error) {
                console.log('ERROR while Copying', currentPath, 'to', currentDest);
                console.error(error);
            }
        }
    } catch (error) {
        console.error('Error reading directory:', path);
        console.error(error);
    }
}

// Start recursive walk and copy from the source directory
recursiveWalkAndCopy(['.ignored/'], './src');
