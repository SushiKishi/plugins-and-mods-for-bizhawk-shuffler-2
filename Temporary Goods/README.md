# Temporary Goods Plugin

* [Latest Version](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/raw/refs/heads/main/Temporary%20Goods/Temporary%20Goods%20-%20BS2%20Plugin.zip) (v1.00)
* [All Releases](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Temporary%20Goods/all%20releases)
* [Branch](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/temporary-goods) (for contributing to code)

## What's new this version?

* First public release!

Known Issues:

The plugin simply does nothing if there is only **one active game remaining** in the Shuffler list. It works around games being swapped, so if there are no game swaps, it can't function. Every option I have tried to work around this is very intrusive to game play.


## What does this do?

This allows you to set a list of games to be treated as "Temporary Goods." Temporary Goods can be added to the Shuffler's game list, just like any other game -- but when you mark them as "completed," the Shuffler will otherwise completely forget about them. This lets you add them back in very easily (trust me -- this is an entire ordeal otherwise).

Why would you want to do this? For viewer interaction, of course!  You can set up a trigger on Stream Deck, SAMMI, your bot, whatever, so that when a viewer redeems channel points or donates a certain amount, suddenly you have to do an extra playthrough of, say, Donkey Kong on the NES. Every $X means another loop, but even if you clear the game...it could come back!

## How do I use this?

**Outside of Bizhawk Shuffler**
1. **Extract** the download to your Bizhawk Shuffler\Plugins folder.

2. **Store your ROMS!**
	* Place the ROM files you want to make temporary goods in the **<Plugin>\TempGoods\storage** folder

2. **Figure out how you set up your triggers.**
	* The plugin will look in the **<Plugin Folder>\TempGoods\restore** folder to determine what games to 'release' from storage.
	* It's looking for a file either named:
		
		* Exactly the same as your rom file (e.g. an empty file named "Donkey Kong.nes")
		* A .txt file named exactly the same as your rom file (e.g. an empty file named "Donkey Kong.nes.txt")
	
**Inside Bizhawk Shuffler**
1. Enable the plugin on initial shuffler setup.
2. That's pretty much it; it'll handle things from there.

## FAQ

**Q: It doesn't seem to be working.**

A: Check Bizhawk's lua console window. The plugin will spit out error messages if it runs into an issue.

**Q: There are no error messages but the plugin doesn't seem to be working.**
A: Feel free to send me a friendly message @SushiKishi whereever at symbols are sold.

**Q: Why is it called "Temporary Goods?"**

A: It's an [unused item](https://tcrf.net/EarthBound) in the game EarthBound, which is my favorite game of all time.

