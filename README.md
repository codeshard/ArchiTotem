# ArchiTotem (TWoW Edition 1.18.0 🐢)

![GitHub Release](https://img.shields.io/github/v/release/codeshard/ArchiTotem?style=for-the-badge)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/codeshard/ArchiTotem/total?style=for-the-badge)


Shaman addon to keep track of totems timers, area of effect and simplify the totem management.

Based on https://github.com/Road-block/ArchiTotem, and https://github.com/Bombg/pfUI-bettertotems, but with some heavy refactoring, code cleanup and QoL improvements focused on [Turtle WoW](http://turtle-wow.org).

## Features
 - All totems in a single bar.
 - Fixed totems tooltips and descriptions to match TWoW 1.17.2
 - Track totems cooldowns and timers.
 - Tracks out of range indicator per totems that apply an aura on the player.
 - Included Totemic Recall(TWoW Spell) in the bar.
 - Accounts for using the Totemic Mastery talent (v1.18.0)

For more insights plz check the [Changelog](https://github.com/codeshard/ArchiTotem/blob/master/Changelog.txt).

## Screenshots

#### Totem bar.

![](https://i.ibb.co/qgHYVXk/Screenshot-2025-01-08-58-1920x1080.png)

#### Totems timers and cooldowns.

![](https://i.ibb.co/M5QWYGZ/Screenshot-2025-01-08-12-1920x1080.png)

#### Out of range indicator (timer in red).

![](https://i.ibb.co/3zVwcDn/Screenshot-2025-01-08-32-1920x1080.png)



## Installation
 - Download the [Latest Release](https://github.com/codeshard/ArchiTotem/releases/latest)
 - Unpack the zip file.
 - Rename the folder to `ArchiTotem`.
 - Copy the folder to `TWoW-Directory\Interface\AddOns`
 - Restart TWoW Client

## Commands
You can use either `/architotem` or `/at` to run a command
```
/at set <earth/fire/water/air> #    Sets the totems shown of that element to #
/at direction <up/down> - Set the direction totems pop up.
/at order <element 1, element 2, element 3, element 4> - Sets the order of the totems, from left to right.
/at scale # - Sets the scale of ArchiTotem, default is 1.
/at showall - Toggles show all mode, displaying all totems on mouseover.
/at bottomcast - Toggles moving totems to the bottom line when cast
/at timers - Toggles showing timers
/at tooltip - Toggles showing tooltips
/at debug - Toggles debuging
```

Moving the bar:
 - Ctrl-RightClick and Drag any of the main buttons
 - Ordering totems of same element:
    - Ctrl-LeftClick any of the buttons

## Known Issues
- The addon is displayed even if you have not learned a specific totem.
- There's no way to down-rank a totem launched by the addon.
