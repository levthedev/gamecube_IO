# Gamecube_IO
dolphin gamecube emulator IO
- - -
### what is it?
This is a tiny project meant to assist other in writing bots for the Dolphin Gamecube Emulator.
It recieves game state from MemoryWatcher, a dolphin feature that records any changes in a game's memory. It writes actions to to dolphin by using a UNIX socket to send inputs to a faked-out virtual controller.
- - -
### how do I build bots with it?
Put AI logic in the main `evaluate_state` loop. in here, you have access to the game's state (`@state`) and can write virtual controller inputs to dolphin using predefined methods like `press(button)`, `release(button)`, and `main_stick(x, y)`. The `Locations.txt` I included has memory addresses for [Super Smash Bros Melee](https://en.wikipedia.org/wiki/Super_Smash_Bros._Melee), but if you are building bots for a different game, you will need to find a resource with useful memory addresses for that game. You will also want to add them into the `update_address_value` method in `memreader.rb` so that they are set in the `@state` variable for use in the `evaluate_state` method.
- - -
### how do I set it up?
Make sure you have a newer version of [dolphin](https://dolphin-emu.org/download/)

Clone this repository (`git clone https://github.com/levthedev/Gamecube_IO.git`)

Find your dolphin home directory (usually `/Users/username/Library/Application Support/Dolphin` on OSX or `$HOME/.local/share/.dolphin-emu` on linux)

Create a named UNIX pipe in that directory and copy memory locations over to the MemoryWatcher directory
`$ cd /path/to/dolphin-emu`
`$ mkdir Pipes`
`$ mkfifo Pipes/pipe`
`$ mkdir MemoryWatcher`
`$ cp /path/to/MeleeAI/Locations.txt MemoryWatcher/`

Find your dolphin config directory (`/path/to/dolphin-emu/Config` or, if you're on Linux, `$HOME/.config/dolphin-emu`)
copy over a gamecube controller setup (`pipe.ini`)
`$ cd /path/to/dolphin-emu/config`
`$ mkdir -p Profiles/GCPad`
`$ cp /path/to/MeleeAI/pipe.ini Profiles/GCPad/`

Next, turn on background input. you can do this by opening dolphin and then following these steps.

Click on the 'Controllers' menu icon in the top right.
Under 'GameCube Controllers', click the drop-down menu next to 'Port 2' and select 'Standard Controller'. Then click 'Configure' to the right.
In the top left corner click the 'Device' drop-down menu. There should be an option to select 'Pipe/0/pipe' (possibly named 'Pipe/1/pipe'). If there is no such device, go back to Setup the Dolphin home folder and make sure that you have created the pipe file in the correct location.
Having selected the device, click the 'Profile' drop-down menu to the right. There should be an option to select 'pipe' — if not, return to the steps above and ensure that pipe.ini has been copied to the correct location. Select 'pipe' and click 'Load' to the right.
In the bottom right, under 'Options', click the box next to 'Background Input'. Then click 'OK' to exit the configure menu and 'OK' again to exit the controllers menu.

Finally, run `memorywatcher.rb` with an argument of your root dolphin path (unless you are on OSX, in which case it shouldn't need this)
