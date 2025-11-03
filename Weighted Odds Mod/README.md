# Bizhawk Shuffler 2 Plugins and Modifications

 - [Modified Swap Timer Plugin](https://github.com/SushiKishi/bizhawk-shuffler-2/tree/releases/Modifiable%20Swap%20Timers)
 - [Weighted Odds Shuffle Mode Mod](https://github.com/SushiKishi/bizhawk-shuffler-2/tree/releases/Weighted%20Odds)
 - Temporary Goods Plugin - Under Development
 - "YOU WIN" Plugin - Under Development


## What's all this then?

I'm working on some plugins and feature requests for the Bizhawk Shuffler 2. If you don't know what that is, [check it out here](https://github.com/authorblues/bizhawk-shuffler-2)! But in short, it swaps the game you're playing in the Bizhawk emulator at random intervals, allowing you to play multiple games for a few seconds (or however long you'd like) at a time.

The plugins can be installed by simply going to their release page and downloading them. Plugins are comfy and easy to use! Any "mods" that are not plugins, but have to be 'baked in' to the main Shuffler code, can be downloaded in the same way, but you'll want to read up more on those individually since it's modifying the Shuffler code itself. The Shuffler doesn't have any official "mods" (that's what the plugins are), so you're essentially downloading an unofficial release of the Shuffler.

That sounds ominous, but it really just means "I changed a few lines of code in the main shuffler app so if something in the Shuffler breaks that's probably why."

## Modifiable Swap Timers - Plugin

[Plugin page](https://github.com/SushiKishi/bizhawk-shuffler-2/tree/releases/Modifiable%20Swap%20Timers) (download, instructions, etc.)
[Branch](https://github.com/SushiKishi/bizhawk-shuffler-2/tree/modifiable-swap-timers) (for contributing to code)

By default, you have to set the minimum and maximum swap timers for the Shuffler at the start of your game, and you can't modify them again unless you stop playing and go back to the settings screen.  This lets you change the timers by modifying text files -- allowing for, say, donation incentives or other viewer interactions to change how often the Shuffler changes games.

## Weighted Odds - "Mod"

[Main Page](https://github.com/SushiKishi/bizhawk-shuffler-2/tree/releases/Weighted%20Odds) (download, instructions, etc.)
[Branch](https://github.com/SushiKishi/bizhawk-shuffler-2/tree/weighted-odds) (for contributing to code)

The Shuffler has a "random" shuffler option that picks games at random.  That, technically, means that the game you played last swap is just as likely to be chosen again as every other game, including games you haven't played in a while.
This mod adds a Weighted Odds shuffle mode. The longer a game goes without being played, the more likely it is to be selected next. It can make the Shuffler "feel" more random, even if mathematically it technically isn't.

## Temporary Goods - Plugin

Still in development

Temporary Goods allows you to choose a list of games you can set aside as "temporary." This could be used to have, say, donation incentives to play certain games in the Shuffler.  For example, if a viewer tips $X, then the streamer has to play 1 full loop of Donkey Kong on the NES.

To do this, you need to add Donkey Kong to the play list, but you'll be swapping it into and out of the game list innumerable times throughout your stream.  This plugin makes that process much, much simpler.

## Ye Olde "User Wins" Instant Notification - Plugin

Still In Development

Ye Olde "User Wins" Instant Notification simply displays in big, fancy letters on the game screen that YOU WIN! when you finish completing your Shuffler playlist. By default, the completion notification only appears within the Lua dialog box. Boring!

## Contributing

Other than this Readme page, this main branch is an exact fork of Bizhawk Shuffler 2 as it was pulled in April 2025. If you want to push changes to any of the plugins or feature additions, make sure you push to the correct branch:

 - Modified Swap Timer plugin: modified-swap-timer
 - Weighted Odds shuffle mode: weighted-odds
 - Temporary Goods plugin: temp-goods
 - Ye Older "User Wins" Instant Notification plugin: you-win
