local plugin = {}

plugin.name = "Temporary Goods"
plugin.author = "SushiKishi"
plugin.settings =
{
	{ name='verbose', type='boolean', label='Show Debugging/Verbose Error Messages?', default=false }
}

plugin.description =
[[
	Full details available here: https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Temporary%20Goods
	Plugin version: 1.00
	
	The short version is that this plugin makes it easier for you to hotswap games into, out of, and then BACK INTO the Shuffler game list. The primary use for this plugin is to set up a game as a "donation incentivce" for your Shuffler playthrough. For reasons too long to get into in this dialog box, this is a Very Difficult Process normally, but the plugin makes it much, much simpler.
	
	As a heads up -- updating either the Shuffler's Game List of the plugin's List of Goods can cause a bit of a hitch on the game swap that updates the list. Your other game swaps should be unaffected. If you need more information about how the plugin works, how to update the Shuffler and plugin game lists mid-stream, or how to handle **multi-disc** or **multi-file** games as a Temp Good, use the link above.	
	
	The short version of the workflow is:
	
	--Your viewer redeems the rewards (donates, channel points, whatever)
    --Your bot saves a file named "Donkey Kong.nes" (or Donkey Kong.nes.txt) to the <Plugin Folder>\TempGoods\restore\ directory. The file's contents will be both ignored and DELETED. Only the file name matters.
	--Your bot handles any reactions to this (e.g. updating a tally of redemptions, setting off alert, etc.)
    --On the next Shuffler Game Swap, the plugin handles adding your TempGoods to the game list by copying and renaming the files needed and forcing an update to the game list.
	
	
    
]]


function updateListOfGoods(PluginsFolder, StorageGameFolder, ActiveGameFolder)

	--You can't just get_dir_whatever the TempGoods storage folder, because a TempGood may be in use.
	--So you have to: 1) check the TempGoods storage folder, 2) check the active Game Folder, 3) only take _TempGoods_ from the Game Folder.
	
	local storedGoods = get_dir_contents(StorageGameFolder, PluginsFolder .. "/__StoredGoods.txt", false)
	local activeGoods = get_dir_contents(ActiveGameFolder, PluginsFolder .. "/__ActiveGoods.txt", false)
	local allGoods = {}
	
	
	for _, gamename in ipairs(storedGoods) do
	
		table.insert(allGoods, gamename)
		table.insert(allGoods, gamename .. ".txt")
		
	end --end of storedGoods
	
	for _, gamename in ipairs(activeGoods) do
	
		if string.find(gamename, '_TempGoods_', 1, true) then
			
			gamename = string.gsub(gamename, '_TempGoods_', '')
			table.insert(allGoods, gamename)
			table.insert(allGoods, gamename .. ".txt")
				
		end --end if string.find
			
	
	end --end ipairs(activeGoods)
	
	

	return allGoods

end --end updateListOfGoods

function plugin.on_setup(data, settings)
    
	
    --set directory locations
    data.TempGoodsDir = PLUGINS_FOLDER .. '/TempGoods'
    data.StorageDir = PLUGINS_FOLDER .. '/TempGoods/storage'
    data.RestoreDir = PLUGINS_FOLDER .. '/TempGoods/restore'
	
	--make directories
    make_dir(data.StorageDir)
    make_dir(data.RestoreDir)
	
	
	--initialize some variables
    data.LastGame = "No Last Game"
	data.ListOfGoods = updateListOfGoods(data.TempGoodsDir, data.StorageDir, GAMES_FOLDER)
	data.ListOfCommands = {"_UpdateGoods_", "_UpdateGameList_"}
	
    
    


end --end on_setup


--Fires when a game is marked complete, but *before the game is swapped out*
function plugin.on_complete(data, settings)

    --when a game is marked complete, save the game about to be marked complete
    data.LastGame = config.current_game
	
	if settings.verbose and string.find(data.LastGame, '_TempGoods_', 1, true) then
		print("**********\nTemp Good '" .. data.LastGame .. "' is put back into storage!\n**********\n\n")
	end --end settings.verbose
		

end --on_complete

--Fires *after a game is swapped out*
function plugin.on_game_load(data, settings)

	

   if string.find(data.LastGame, '_TempGoods_', 1, true) then
        
		table.remove(config.completed_games)
		
		err = "No error."
		code = "No error code."
			
		trimmedName = string.gsub(data.LastGame, '_TempGoods_', '')
        
		ok, err, code = os.rename(GAMES_FOLDER .. '/' .. data.LastGame, data.StorageDir .. '/' .. trimmedName)
		
		if not ok then --something went wrong...
		
			if code == 17 then --duplicate file?
			
				print("The game '" .. filename .. "' is already in the active game list. You have a duplicate file! Renaming the duplicate in storage, which should avoid this error in the future.")
				os.rename(GAMES_FOLDER .. '/' .. data.LastGame, data.StorageDir .. '/' .. os.date("%Y%m%d-%H%M%S-") .. trimmedName)
				
			end --end code 17
			
		end --end if not ok
		
		output_completed()
		
		
	end --end string.find
	
end --end on_game_load

--Fires right before swapping games. Used to update the game list and restore TempGoods back to the game list.
function plugin.on_game_save(data, settings)

		gamesAdded = nil
		
		
		if settings.verbose then
				print("Debugging: Your List of Goods and Commands are as follows: " .. table.concat(data.ListOfGoods, "\n") .. "\n" .. table.concat(data.ListOfCommands, "\n") .. "\n\n")
		end --end verbose
		
		--for every game on the List of Goods...
		for _,filename in ipairs(data.ListOfGoods) do

			
			if settings.verbose then
				print("Looking for '" .. filename .. "' or '" .. filename .. ".txt' in " .. data.RestoreDir .. "\n" )
			end --end verbose
			
			addGame = nil
			err = "No error."
			code = "No error code."
			
			--...see if "restore"\NameOfGame.ext exists.
			addGame = os.rename(data.RestoreDir .. "/" .. filename, data.RestoreDir .. "/" .. filename)
			
			
			if addGame then
			
				if settings.verbose then
					print("Found '" .. data.RestoreDir .. "/" .. filename .. "'! Removing it and attemping to add that game.\n")
				end --end verbose
				
				os.remove(data.RestoreDir .. "/" .. filename) --remove the text file so we don't try to add the game again.
			
				local extension = filename:match("%.[^.]+$")
				
				if extension == ".txt" then
				
					filename = string.sub(filename, 1, -5)
				
				end --end if extension
				
				ok, err, code = os.rename(data.StorageDir .. "/" .. filename, GAMES_FOLDER .. "/_TempGoods_" .. filename)
				
				if not ok then --something went wrong...
				
					isGameLive = file_exists(GAMES_FOLDER .. "/_TempGoods_" .. filename) --check if game is already active
					
					if isGameLive and settings.verbose then --couldn't copy game because game is already in live game Folder
					
						print("Debug Message: Could not add game " .. filename .. " to active game list. The game is already in the active game list.")
						
					end --end  if isgamelive && verbose
					
					if isGameLive and code == 17 then --code 17 means file exists. It's in both storage and active folders...
						print("The game '" .. filename .. "' is already in the active game list. You have a duplicate file! Renaming the duplicate in storage, which should avoid this error in the future.")
						os.rename(data.StorageDir .. "/" .. filename, data.StorageDir .. "/duplicate_" .. os.date("%Y%m%d-%H%M%S-") .. filename)
					end --end live & 17
					
					if not isGameLive then
					
						print("Error Message: Could not add the game " .. filename .. " to the active game list.\nError " .. code .. " -- " .. err .. "\n\n")
						
					end --close if isGameLive
					
				else

					gamesAdded = true
					if settings.verbose
						then print("Added the Temporary Good '" .. filename .. "' to the Shuffler's games folder.")
					end --end verbose
					
				end --end if not ok
			
			end --end if addGame
			
			
		end -- end ipairs(List of Goods)
		
		for _, filename in ipairs(data.ListOfCommands) do
			
			runCommand = nil
			runCommand = os.rename(data.RestoreDir .. "/" .. filename, data.RestoreDir .. "/" .. filename)
			
			if runCommand then
			
				if settings.verbose then
					print("Found '" .. data.RestoreDir .. "/" .. filename .. "'! Removing it and attemping to run that command.\n")
				end --end verbose
			
				if filename == "_UpdateGameList_" then
				
					gamesAdded = true
					print("Forcing the Shuffler's game list to update per user request.\n\n")
				
				
				elseif filename == "_UpdateGoods_" then
				
					
					print("Forcing an update of the List of Temporary Goods available. This will almost certainly cause a hitch with the next game swap...")
					data.ListOfGoods = updateListOfGoods(data.StorageDir, GAMES_FOLDER)
					print ("Done updating Temporary Goods list!")
				
				end --end if updategamelist
				
			end --end if runCommand
			
		
		end --end iPairs(Commands)
		
		if gamesAdded then 
			print("Clearing and remaking the Shuffler's game list!")
			os.remove(GAMES_FOLDER .. "/.games-list.txt")
		end --end GamesAdded
	

end --end on_game_save


return plugin