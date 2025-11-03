# Bizhawk Shuffler 2 Plugins and Modifications

 - [Hot Swap Timers Plugin](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Hot%20Swap%20Timers)
 - [Temporary Goods Plugin](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Temporary%20Goods)
 - [Weighted Odds Shuffle Mode Mod](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Weighted%20Odds%20Mod)
 - "YOU WIN" Plugin - Coming Soon(tm)


## What's all this then?

I'm working on some plugins and feature requests for the Bizhawk Shuffler 2. If you don't know what that is, [check it out here](https://github.com/authorblues/bizhawk-shuffler-2)! But in short, it swaps the game you're playing in the Bizhawk emulator at random intervals, allowing you to play multiple games for a few seconds (or however long you'd like) at a time.

The plugins can be installed by simply going to their release page and downloading them. Plugins are comfy and easy to use! Any "mods" that are not plugins have to be 'baked in' to the main Shuffler code. You'll want to read up more on those individually since it's modifying the Shuffler code itself. The Shuffler doesn't have any official "mods" (that's what the plugins are), so you're essentially downloading an unofficial release of the Shuffler.

That sounds ominous, but it really just means "I changed a few lines of code in the main shuffler app so if something breaks that's probably why."

## Hot Swap Timers - Plugin

* [Plugin page](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Hot%20Swap%20Timers) (download, instructions, etc.)
* [Download Latest Version](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/raw/refs/heads/main/Hot%20Swap%20Timers/Hot%20Swap%20Timers%20-%20BS2%20Plugin.zip) (v1.00)
* [Branch](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/hot-swap-timers) (for contributing to code)

By default, you have to set the minimum and maximum swap timers for the Shuffler at the start of your game, and you can't modify them again unless you stop playing and go back to the settings screen.  This lets you change the timers by modifying text files -- allowing for, say, donation incentives or other viewer interactions to change how often the Shuffler changes games.

## Temporary Goods - Plugin

* [Main Page](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Temporary%20Goods) (download, instructions, etc.)
* [Latest Version](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/raw/refs/heads/main/Temporary%20Goods/Temporary%20Goods%20-%20BS2%20Plugin.zip) (v1.00)
* [Branch](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/temporary-goods) (for contributing to code)


Temporary Goods allows you to choose a list of games you can set aside as "temporary." The typical reason for this is to allow a game into the Shuffler as a donation incentive -- say, for every $X in donations, you add one loop of Donkey Kong to the Shuffler.

Usually, this is an extremely complicated and clunky process, requiring multiple stoppages of play.  With this plugin, it's very easy!

## Weighted Odds - "Mod"

* [Main Page](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Weighted%20Odds%20Mod) (download, instructions, etc.)
* Currently no official release -- something broke when BS2 updated and I gotta fix it.
* [Branch](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/weighted-odds-mod) (for contributing to code)

The Shuffler has a "random" shuffler option that picks games at random.  That, technically, means that the game you played last swap is just as likely to be chosen again as every other game, including games you haven't played in a while.
This mod adds a Weighted Odds shuffle mode. The longer a game goes without being played, the more likely it is to be selected next. It can make the Shuffler "feel" more random, even if mathematically it technically isn't.

## Ye Olde "User Wins" Instant Notification - Plugin

Still In Development

Ye Olde "User Wins" Instant Notification simply displays in big, fancy letters on the game screen that YOU WIN! when you finish completing your Shuffler playlist. By default, the completion notification only appears within the Lua dialog box. Boring!

## Contributing

Please contribute to the indiviual plugin or mod branches, not the main branch.
