# Orienteering
This mod adds several tools which mostly aid in orientation. When carrying them,
this will enhance the HUD by adding several interesting information such as the
coordinates or the viewing angles or enabling the use of the minimap.

Current version: 1.3

## Mod support
All dependencies are optional.

There is an optional dependency on default from Minetest Game.
It enables the use of crafting recipes.

There is an optional dependency on Achievements [`awards`] by rubenwardy. If
both this mod and the default mod are enabled, the achievement “Master of
Orienteering” will be added.

This mod includes item help texts for `doc_items` of the Documentation System
modpack.

## Tools
The orienteering tools are used automatically. To use them, you only need to
have them somewhere in your hotbar. Most tools add information at the top
section of your screen. The minimap is disabled by default, in this mod
you have to acquire the proper tool first.

The following tools are available:

* Altimeter: Shows height (Y)
* Triangulator: Shows X and Z coordinates
* Compass: Shows yaw (horizontal angle)
* Sextant: Shows pitch (vertical angle)
* Watch: Shows the time (hours and minutes)
* Speedometer: Shows speed in m/s (1 m = side length of a single cube)
* Automapper: Enables the usage of the minimap and radar (F7 key by default)
* GPS device: Shows X, Y, Z coordinates, yaw and time
* Quadcorder: Combination of everything above: Shows X, Y, Z coordinates, pitch,
  yaw, time, speed and enables minimap/radar

To toggle between 12h and 24h mode for the displayed time, wield any device
which is capable of displaying the time and press the left mouse button.

## Configuration
### Recommendations
Note that in Minetest, it is also possible to access the coordinates, angles,
etc. through the debug menu, but this would be generally considered cheating as
this defeats the purpose of this mod. Try to resist this urge.

To avoid accidentally enabling debug display with a key press, you can add the
following line into your `minetest.conf`:

    keymap_toggle_debug = 

### HUD text position
The text position can be configured by using Minetest's settings system. See
the advanced settings menu for more information.

## Crafting recipes
Crafting recipes are only available when the default mod (from Minetest Game) is used.

Symbols:

* S = Steel Ingot
* C = Copper Ingot
* B = Bronze Ingot
* T = Tin Ingot
* G = Gold Ingot
* M = Mese Crystal
* D = Diamond
* O = Obsidian Shard
* s = Stick
* g = Glass
* 1 = Altimeter
* 2 = Triangulator
* 3 = Compass
* 4 = Sextant
* 5 = Watch
* 6 = Speedometer
* 7 = Automapper
* 8 = GPS device

### Altimeter

    g
    C
    C

### Triangulator

     B
    B B

### Compass

     T
    TsT
     T

### Sextant

     G
    GGG

#### Watch

    C
    g
    C

### Speedometer
     G
    SsS
     S

### Automapper
    GGG
    MOM
    GGG

### GPS device

    G2G
    3B5
    T1T

### Quadcorder

    GGG
    6D7
    4D8

## License
Everything is licensed under WTFPL.

