# Hot Swap Timers - Plugin for Bizhawk Shuffler 2

* [Download Latest Version](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/raw/refs/heads/main/Hot%20Swap%20Timers/Hot%20Swap%20Timers%20-%20BS2%20Plugin.zip) (v1.00)
* [All releases](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Hot%20Swap%20Timers/all%20releases)
* [Branch](https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/hot-swap-timers) (for contributing to code)

## What's new this version?

* Added ability to use either one or two files to set timers.
* Forgot to keep the 1.00 version of the file, so this is version 1.00 now, so that it doesn't look like I messed up. <3

## What does this do?

This allows you to control the swap timers (minimum and maximum range) of the Bizhawk Shuffler 2 by modifying either one or two different text files.  This gives you the ability to, say, have your Twitch bot / StreamDeck / Whatever turn the timers up or down based on chat interaction.  You can also edit them manually by hand if you want.

## How do I use this?

**Outside of Bizhawk Shuffler**
1. **Figure out how you want to modify your timer files.**
	* Options include using stream bot to react to commands or interactions, StreamDeck, SAMMI, or manually changing the numbers yourself as needed with a text editor.
2. **Create your text files.**
	* You can place them anywhere and name them anything.
	* For the two-file setup, you'll need, well, two files. Each file should only contain one line of text -- the timer you want to use, in seconds.
	* For the combo or one-file setup, you'll jsut need one text file. It will have two lines -- first line for the minimum swap timer, second line for the max swap timer.

**Outside of Bizhawk Shuffler**
1. Put the .lua file in the Shuffler's plugins folder
2. Start the Shuffler and enable the plugin in the settings window.
3. In the plugin's settings, choose either a "combo" (one-file) setup or a two-file setup.
4. Set your file locations in the plugin's settings.
5. Play!


Feel free to test this "off-air" before taking it live by directly modifying your text files and seeing if the swaps happen faster or slower.

## FAQ

**Q: It doesn't seem to be working.**

A: Check Bizhawk's lua console window. The plugin will spit out error messages if it runs into an issue.

**Q: There are no error messages but the plugin doesn't seem to be working.** I tried setting minimum and maximum to 1-2 seconds and it still takes a long time to swap.

A: Make sure you have more than one game in the game list!  Make sure the Shuffler is actually running.  Make sure your files aren't set to read-only or being overwritten.