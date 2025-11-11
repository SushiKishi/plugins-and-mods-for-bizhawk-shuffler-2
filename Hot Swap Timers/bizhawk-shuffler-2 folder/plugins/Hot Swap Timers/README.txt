# Hot Swap Timers - Plugin for Bizhawk Shuffler 2

https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Hot%20Swap%20Timers

## What's new this version?

* No longer have to set your file locations.
* Pre-made folder and package now included with the plugin
* Plugin will create default files if any are missing.
* Added tiers of verbosity regarding error / debugging messages
* Added ability to log when the plugin changes your timers.


## What does this do?

This allows you to control the swap timers (minimum and maximum range) of the Bizhawk Shuffler 2 by modifying either one or two different text files.  This gives you the ability to, say, have your Twitch bot / StreamDeck / Whatever turn the timers up or down based on chat interaction.  You can also edit them manually by hand if you want.

## How do I use this?

**Outside of Bizhawk Shuffler**
1. **Figure out how you want to modify your timer files.**
	* Options include using stream bot to react to commands or interactions, StreamDeck, SAMMI, or manually changing the numbers yourself as needed with a text editor.
	* The files in question are in:
		<Bizhawk Shuffler>/<plugins>/Hot Swap Timers/>
		
	* min.txt and max.txt control the minimum and maximum swap timers, respectively
		
	* combo.txt is used with the "Combo File" setting enabled. Line 1 is minimum, line 2 is maximum.
	
	* If you flip-flop the min and max, the plugin will handle it.


**Outside of Bizhawk Shuffler**
1. Put the .lua file in the Shuffler's plugins folder
2. Start the Shuffler and enable the plugin in the settings window.
3. In the plugin's settings, choose either a "combo" (one-file) setup or a two-file setup.
4. Play!

Feel free to test this "off-air" before taking it live by directly modifying your text files and seeing if the swaps happen faster or slower.

## FAQ

**Q: It doesn't seem to be working.**

A: Check Bizhawk's lua console window. The plugin will spit out error messages if it runs into an issue.  Turn on debugging messages in the plugin's settings if you need to.

**Q: I need to enable debugging without resetting the Shuffler.**

A: Go to
	<Bizhawk Shuffler>\shuffler-src\>
and make a backup of the file:
	<config.lua>

** Proceed at your own risk. **  Change the value of 

	plugins > hot-swap-timers > debugging

to

	true

.

**Q: There are no error messages but the plugin doesn't seem to be working. For example, I tried setting minimum and maximum to 1-2 seconds and it still takes a long time to swap.**

A: Make sure you have more than one game in the game list!  Make sure the Shuffler is actually running.  Make sure your files aren't set to read-only or being overwritten.