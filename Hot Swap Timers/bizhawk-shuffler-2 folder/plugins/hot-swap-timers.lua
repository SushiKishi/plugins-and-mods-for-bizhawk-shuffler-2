local plugin = {}

plugin.name = "Hot Swap Timers"
plugin.author = "SushiKishi"
plugin.settings = { 
	{ name="combo", type="boolean", label="Use combo file?", default=false },
	{ name="showChanges", type="boolean", label="Show changes in Lua Console?", default=false },
	{ name="debugging", type="boolean", label="Show debugging messages in Lua Console?", default=false }

}

plugin.description =
[[ Hot Swap Timers
Plugin webpage: https://github.com/SushiKishi/plugins-and-mods-for-bizhawk-shuffler-2/tree/main/Hot%20Swap%20Timers
Plugin Version: v1.1.0

This plugin allows you to control the minimum and maximum swap timers by modifying text files on your computer. This lets you "hot swap" how quickly your Shuffler shuffles without having to restart your game. The timers will hot swap on every, well, swap.

The minimum, maximum, and combo min/max files are in the Plugins directory, under the "Hot Swap Timers" folder.

Something to note when using this plugin that seems obvious, but might sneak by you on initial use: this plugin overrides the minimum and maximum timer settings in the plugin's configuration screen. The values showing on the settings screen are ignored *entirely.* If you need to reset to a default number, for example at the start of your stream, you have to modify the *text files*, not the *config screen,* at the start of every session.

Settings description:

"Use combo file": Yes/Checked means the timers are controlled by combo.txt -- first line minimum, second line maximum.  No/Unchecked means timers are controlled by two files: min.txt and max.txt. Choose whichever suits your needs better.

"Show Changes": Puts a message in the Lua Console when the timer updates.

"Debugging": Only really useful for debugging purposes to try to find errors.


]]


function hot_swap_timers(minFileLoc, maxFileLoc, comboFileLoc, combo, bootUp, showChanges, debugging)

	local errorMsg = "\nNo error. This should not display.\n"
	errorType = "Unknown"
	local min = nil
	local max = nil
	local updateTimers = false

	if combo then --if using one file
		
		--Start processing data if combo file were found.
		local comboFile, err, code = io.open(comboFileLoc, "r") --load the combo value, as set in Plugin config
		comboErr = err
		comboCode = code
		
		if comboFile ~= nil then 

			minContents = comboFile:read("*line")
			maxContents = comboFile:read("*line")
			min = tonumber(minContents)
			max = tonumber(maxContents)
			comboFile:close()
			updateTimers = true
			
		else
			
			updateTimers = false
				
		
		end --end if nil/nil
		
	
	else
	
		--Start processing data if both files were found.
		minFile, err, code = io.open(minFileLoc, "r") --load the min value, as set in Plugin config
		minErr = err
		minCode = code
		
		maxFile, err, code  = io.open(maxFileLoc, "r") --load the max value, as set in Plugin config
		maxErr = err
		maxCode = code
		
		if minFile ~= nil and maxFile ~= nil then  --both files opened OK!
	
			min = tonumber(minContents)
			max = tonumber(maxContents)
			minFile:close()
			maxFile:close()
			updateTimers = true
			
			
		else
		--Error finding or opening file

			updateTimers = false
			
		end --end if nil/nil
		
		
		
		
	end
	--end if combo / else branch
	
	
	
	if updateTimers then 
		
		-- update the min/max only if both are numbers. Otherwise, do nothin'
		if type(min) == "number" and type(max) == "number" then 

			min = math.floor(min + 0.5)
			max = math.floor(max + 0.5)

			--check they're input in the right order...
			if min > max then min, max = max, min end
			
			
			--check if there's even a change.
			
			if config.min_swap ~= min or config.max_swap ~= max then --there was a change
					
				config.min_swap=min
				config.max_swap=max
					
				if showChanges or debugging then
					print("Hot Swap Timers:\nUpdating Timers! New Min/Max: " .. config.min_swap .. " / " .. config.max_swap .. "\n")
				end
				
				return true
					
			else if debugging then print("Hot Swap Timers:\nData read correctly, but no changes were found.\n") end
			
			end 
			--end checking if there was a real change

		else
		--one or both files did not contain numbers.

			errorMsg = "\nThe Hot Swap Timers plugin ran into an error reading your files.\nYour timer files could not be processed by the plugin, usually because they contain non-numerical data.\nYour minimum time file/line contained: " .. tostring(minContents) .. "\nYour maximum time file/line contained: " .. tostring(maxContents) .. "\nIf this error occurs frequently, you may need to check your timer files or setup.\nOtherwise, you can probably ignore it; it may be that your chatbot was editing the file at the same time the plugin read it."
			
			if debugging then  print(errorMsg) end
			return false
			
					
		end
		--end if min/max are numbers
	
	
	else 
		
		errorMsg = "Hot Swap Timers: Error loading your timer files as follows:\n"
		
		for _,value in pairs( { {comboErr,comboCode,"combo"}, {minErr,minCode,"min"}, {maxErr,maxCode,"max"} } ) do
		
			if value[1] ~= nil then
				errorMsg = "Error loading '" .. value[3] .. ".txt', Code " .. value[2] .. ": " .. value[1] .. "\n"
			end
			
			errorMsg = errorMsg .. "If this error occurs frequently, you may need to check your setup. Sometimes, it happens if your chat bot and the plugin are using the file at the same time."
			
		end
		--end for {errors}
		if debugging then  print(errorMsg) end
		return false
		
	end 
	--end "if updateTimers = true"
end
--end function


--This function is called once at the start of the session; if the plugin isn't called here, the first swap uses the "configuration screen" values.
function plugin.on_setup(data, settings)


	 --initialize folder/file locations
    data.PluginFolder = PLUGINS_FOLDER .. '/Hot Swap Timers/'
    data.MinFile = data.PluginFolder .. 'min.txt'
    data.MaxFile = data.PluginFolder .. 'max.txt'
	data.ComboFile = data.PluginFolder .. 'combo.txt'
	
	--make directories
    make_dir(data.PluginFolder)
    
	hstFileList = { {data.MinFile, config.min_swap}, {data.MaxFile, config.max_swap}, {data.ComboFile, config.min_swap .. "\n" .. config.max_swap} }
	
	
	for _,value in pairs(hstFileList) do
		
		if not file_exists(value[1]) then
			initTimer, err, code = io.open(value[1], "w")
			if not initTimer
				then error("Hot Swap Timer Error: Could not find nor create 'min.txt.'\nError: " .. code .. ": " .. err .. "\nPlease correct this error then restart the shuffler.")
			else
				print("Hot Swap Timer could not find " .. value[1] .. " and is creating it...")
				initTimer:write(value[2])
				initTimer:close()
				print("...done! " .. value[1] .. " initialized to:\n" .. value[2] .. "\n")
			end
			--end if not initTimer
		end
		--end if not file_Exists
	end
	--end for hstFileList
	
	--initialize some variables
	hstDisplayMsgFrames = 0
	bootUp = true
	errorType = "Unknown"
	hot_swap_timers(data.MinFile, data.MaxFile, data.ComboFile, settings.combo, bootUp, settings.showChanges)
	bootUp = false
	errorCount = 0
	
	--Start up message:
	startMSG = "Hot Swap Timers is in control of your swap timers! You've chosen to use the "
	if settings.combo then
		startMSG = startMSG .. "combo.txt file to control your timers. "
	else
		startMSG = startMSG .. "min.txt and max.txt files to control your timers. "
	end
	
	print(startMSG ..  "For more help, see the readme.\n")
	print("To start today's session, your minimum and maximum timers are: " .. config.min_swap .. " / " .. config.max_swap .. "\n\n")
	

end -- Ends the On_Setup part of the plugin


--This is called every time the shuffler makes a save state, right before a swap.
function plugin.on_game_save(data, settings)
	
	--keeping track of how many times in a row the plugin errors out.
	if hot_swap_timers(data.MinFile, data.MaxFile, data.ComboFile, settings.combo, bootUp, settings.showChanges) then
		errorCount = 0
	
	else errorCount = errorCount + 1
	
	end 
	
	if errorCount >= 5 then
		errorCount = 0
		print("You have debugging messages turned off, but the plugin ran into an error at least five times in a row. You may want to enable debugging and try to resolve the issue.")
		hstDisplayMsgFrames = 300
	end 
	--end errorCount
		

end -- Ends the on_game_Save part of the plugin

--executes every frame. Only needed to display error messages.
function plugin.on_frame(data, settings)
	
	if hstDisplayMsgFrames > 0 then --display error
		
		hstDisplayMsgFrames = hstDisplayMsgFrames - 1

		gui.use_surface('client')
		gui.drawText((client.screenwidth() / 2), 25, string.format("Hot Swap Timer ran into errors. See Lua Console."), 0xFFCCCCFF, 0xFF000000, 14, nil, nil, "center", nil)
	
	end --end error display
		

end --end on_frame plugin



return plugin