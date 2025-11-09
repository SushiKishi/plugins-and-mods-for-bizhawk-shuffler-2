local plugin = {}

plugin.name = "Temporary Goods"
plugin.author = "SushiKishi"
plugin.minversion = "2.10.0"
plugin.settings =
{
	{ name='verbose', type='boolean', label='Show Debugging/Verbose Error Messages?', default=false }
}

plugin.description =
[[
	Plugin Version: 1.1.0
	Plugin page, with setup guide: https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Temporary%20Goods
	
	The short version is that this plugin makes it easier for you to hotswap a list of "temporary games" into and out of the active game list as needed. The primary idea for this plugin is to set up a game as a "donation incentive" for your Shuffler playthrough that gets added when a goal is met, removed when the game is cleared, then added again if the goal is met again.
	
	***Multi-Disk, some MAME, and anything requiring multiple files** may need to create and use .XML files instead. See the link at the top.
	
	The short version of the workflow is:
	
	1) Put all games you want to be "temporary" games into <Plugin Folder>\TempGoods\storage
	2) Viewer redeems the rewards
    3) Your bot saves a file named "Donkey Kong.nes" (or Donkey Kong.nes.txt) to the <Plugin Folder>\TempGoods\restore\ directory. **The file's contents will be both ignored and DELETED.** Only the file name matters.
	4) On the next Shuffler Game Swap, the plugin adds any TempGoods you've triggered to the game list.
	...
	5) When a Temporary Good game is marked as completed, the plugin will store the game for later use and update the active game list.
    
]]


function updateListOfGoods(PluginsFolder, StorageGameFolder, ActiveGameFolder)

	--You can't just get_dir_whatever the TempGoods storage folder, because a TempGood may be in use.
	--So you have to: 1) check the TempGoods storage folder, 2) check the active Game Folder, 3) only take _TempGoods_ from the Game Folder.
	
	print("Temporary Goods: WTF!? Ok, so the  StorageGameFolder is: " .. StorageGameFolder .. " and active is " .. ActiveGameFolder)
	local storedGoods = get_dir_contents(StorageGameFolder, PluginsFolder .. "/__ALL_StoredGoods.txt", false)
	local activeGoods = get_dir_contents(ActiveGameFolder, PluginsFolder .. "/__ALL_ActiveGoods.txt", false)
	local allGoods = {}
	
	for _, gamename in ipairs(storedGoods) do
	
	
		table.insert(allGoods, gamename)
		table.insert(allGoods, gamename .. ".txt")
		
	end
--end of storedGoods
	
	for _, gamename in ipairs(activeGoods) do
	
	
		
		if string.find(gamename, '_TempGoods_', 1, true) then
			
			
			gamename = string.gsub(gamename, '_TempGoods_', '')
			table.insert(allGoods, gamename)
			table.insert(allGoods, gamename .. ".txt")
				
		end
--end if string.find
			
	
	end
--end ipairs(activeGoods)
	
	
	return allGoods

end
--end updateListOfGoods

function plugin.on_setup(data, settings)
    
	
    --set directory locations
    data.TempGoodsDir = PLUGINS_FOLDER .. '/TempGoods'
    data.StorageDir = PLUGINS_FOLDER .. '/TempGoods/storage'
    data.RestoreDir = PLUGINS_FOLDER .. '/TempGoods/restore'
	
	--make directories
    make_dir(data.StorageDir)
    make_dir(data.RestoreDir)
	
	
	--initialize some variables
    data.CompletedGameName = "No Last Game"
	data.ListOfGoods = updateListOfGoods(data.TempGoodsDir, data.StorageDir, GAMES_FOLDER)
	data.ListOfCommands = {"_UpdateGoods_", "_UpdateGameList_"}
	data.gamesLeft = #get_games_list()
    if settings.verbose then 
		print ("Temporary Goods: I found " .. data.gamesLeft .. "games on the active game list to start today's session!\n\n")
	end
    data.FrameCounter = -1
	data.Completed = false

end
--end on_setup


--Fires when a game is marked complete, but *before the game is swapped out*
function plugin.on_complete(data, settings)

    --when a game is marked complete, save the game about to be marked complete
    data.CompletedGameName = config.current_game
	data.Completed = true
	
end
--end on_complete

--Fires *after a game is swapped out*
function plugin.on_game_load(data, settings)

	data.gamesLeft = #get_games_list() --update game count
	
	if data.Completed then --a game was just marked as completed.
	
		data.Completed = false --turn off the switch
		
		if string.find(data.CompletedGameName, '_TempGoods_', 1, true) then --Game is a Temp Good
		
			if settings.verbose then --show debugging output
				print("Temporary Goods: **********\n**********\n**********\nTemp Good '" .. data.CompletedGameName .. "' is put back into storage!**********\n**********\n**********\n\n")
				print("Temporary Goods: There are now " .. data.gamesLeft .. " games remaining.\n\n")
			end
			--end verbose
		
		
			if data.gamesLeft == 1 then --down to last game, need to start forcing updates...
				data.FrameCounter = (config.min_swap + 1) * 60 --worried about 0 * 60 = 0...
			end --go to on_frame or whatever to see what this does
			--end data.gamesLeft 1
			
			
			err = "No error."
			code = "No error code."
				
			trimmedName = string.gsub(data.CompletedGameName, '_TempGoods_', '')
			
			ok, err, code = os.rename(GAMES_FOLDER .. '/' .. data.CompletedGameName, data.StorageDir .. '/' .. trimmedName)
			
			if not ok then --something went wrong...
			
				if code == 17 then --duplicate file?
				
					print("Temporary Goods: The game '" .. filename .. "' is already in the active game list. You have a duplicate file! Renaming the duplicate in storage, which should avoid this error in the future.")
					os.rename(GAMES_FOLDER .. '/' .. data.CompletedGameName, data.StorageDir .. '/' .. os.date("%Y%m%d-%H%M%S-") .. trimmedName)
					
				end
				--end code 17
				
			end
			--end if not ok
		
		table.remove(config.completed_games) --remove temp good from completed game list
		output_completed() --update the completed game list the shuffler spits out into the .txt file
		
		end
		--end string.find
		
	end
	--end if data.completed
	
end
--end on_game_load

--Fires right before swapping games. Used to update the game list and restore TempGoods back to the game list.
function plugin.on_game_save(data, settings)

		gamesAdded = nil
		
		if settings.verbose then
				print("Temporary Goods: Your List of Goods and Commands are as follows: " .. table.concat(data.ListOfGoods, "\n") .. "\n" .. table.concat(data.ListOfCommands, "\n") .. "\n\n")
		end
		--end verbose
		
		--for every game on the List of Goods...
		for _,filename in ipairs(data.ListOfGoods) do

			
			if settings.verbose then
				print("Temporary Goods: Looking for '" .. filename .. " in " .. data.RestoreDir .. "\n" )
			end
			--end verbose
			
			addGame = nil
			err = "No error."
			code = "No error code."
			
			--...see if "restore"\NameOfGame.ext exists.
			addGame = os.rename(data.RestoreDir .. "/" .. filename, data.RestoreDir .. "/" .. filename)
			
			if addGame then
			
				if settings.verbose then
					print("Temporary Goods: Found '" .. data.RestoreDir .. "/" .. filename .. "'! Removing trigger file, adding game.\n")
				end
			--end verbose
				
				os.remove(data.RestoreDir .. "/" .. filename) --remove the text file so we don't try to add the game again.
			
				local extension = filename:match("%.[^.]+$")
				
				if extension == ".txt" then
				
					filename = string.sub(filename, 1, -5)
				
				end
				--end if extension
				
				ok, err, code = os.rename(data.StorageDir .. "/" .. filename, GAMES_FOLDER .. "/_TempGoods_" .. filename)
				
				if not ok then --something went wrong...
				
					isGameLive = file_exists(GAMES_FOLDER .. "/_TempGoods_" .. filename) --check if game is already active
					
					if isGameLive and settings.verbose then --couldn't copy game because game is already in live game Folder
					
						print("Temporary Goods: Could not add game " .. filename .. " to active game list. The game is already in the active game list.")
						
					end
					--end  if isgamelive && verbose
					
					if isGameLive and code == 17 then --code 17 means file exists. It's in both storage and active folders...
						print("Temporary Goods: The game '" .. filename .. "' is already in the active game list. You have a duplicate file! Renaming the duplicate in storage, which should avoid this error in the future.\nIf everything is still working OK, you can ignore this message.")
						os.rename(data.StorageDir .. "/" .. filename, data.StorageDir .. "/duplicate_" .. os.date("%Y%m%d-%H%M%S-") .. filename)
					end
					--end live & 17
					
					if not isGameLive then
					
						print("Temporary Goods: Error Message: Could not add the game " .. filename .. " to the active game list.\nError " .. code .. " -- " .. err .. "\n\n")
						
					end
					--end if isGameLive
					
				else

					gamesAdded = true
					if settings.verbose
						then print("Temporary Goods: Added the Temporary Good '" .. filename .. "' to the Shuffler's games folder.")
					end
					--end verbose
					
				end
				--end if not ok
			
			end
			--end if addGame
			
			
		end
		-- end ipairs(List of Goods)
		
		for _, filename in ipairs(data.ListOfCommands) do
			
			runCommand = nil
			runCommand = os.rename(data.RestoreDir .. "/" .. filename, data.RestoreDir .. "/" .. filename)
			
			if runCommand then
			
				if settings.verbose then
					print("Temporary Goods: Found '" .. data.RestoreDir .. "/" .. filename .. "'! Removing trigger file and attemping to run that command.\n")
				end
				--end verbose
			
				if filename == "_UpdateGameList_" then
				
					gamesAdded = true
					print("Temporary Goods: Forcing the Shuffler's game list to update per user request.\n\n")
				
				
				elseif filename == "_UpdateGoods_" then
				
					
					print("Temporary Goods: Forcing an update of the List of Temporary Goods available. This will almost certainly cause a hitch with the next game swap. Please stand by.\n")
					data.ListOfGoods = updateListOfGoods(data.StorageDir, GAMES_FOLDER)
					print ("Temporary Goods: Done updating the list of Temporary Goods!\n")
				
				end
				--end if updategamelist
				
			end
			--end if runCommand
			
		
		end
		--end iPairs(Commands)
		
		if gamesAdded then 
			print("Temporary Goods: Clearing Shuffler's game list!")
			os.remove(GAMES_FOLDER .. "/.games-list.txt")
		end
		--end GamesAdded
	

end
--end on_game_save

function plugin.on_frame(data, settings)

	if data.gamesLeft == 1 then --on last game, lets check for temp goods.
	
		if data.FrameCounter <= 0 then --force a check...
		
			if settings.verbose then --output debugging information
				print("Temporary Goods: 1 game left, 0 frames on the counter. Let's update game lists!\n\n")
			end
			
			data.FrameCounter = (config.min_swap + 1) * 60 --tee up the next check
			data.FrameCounter = data.FrameCounter + 1 --tee up the next check
			plugin.on_game_save(data, settings) --fire on_game_save, which does all the work of the plugin anyway
			
		
		end
		--end data.FrameConter <= 0
	
		data.FrameCounter = data.FrameCounter - 1
		
	end
	--end data.gamesLeft == 1
	

end
--end on_frame

return plugin