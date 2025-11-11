local plugin = {}

plugin.name = "Hot Swap Timers"
plugin.author = "SushiKishi"
plugin.settings = { 
	{ name="minFile", type="file", label="<--Min Time File" },
	{ name="maxFile", type="file", label="<--Max Time File" },
	{ name="comboFile", type="file", label="<--Combo Time File" },
	{ name="combo", type="boolean", label="Use combo file?" },

}

plugin.description =
[[ Hot Swap Timers
Plugin webpage: 
Plugin Version: v1.00

This plugin allows you to control the minimum and maximum swap timers by modifying text files on your computer. This lets you "hot swap" how quickly your Shuffler shuffles without having to restart your game. Something to note when using this plugin that seems obvious, but might sneak by you on initial use is that this plugin overrides the minimum and maximum timer settings in the plugin's configuration screen. However, when using the plugin, the values on the settings screen are ignored entirely. If you have to reset these values to a default number, for example at the start of your stream, you have to modify the *text files*, not the *config screen,* at the start of every session.

Settings description:
Min and Max Swap Time files are just that -- two text files that contain your minimum and maximum swap time values, and nothing else.
The Combo Swap Time file is a two-line text file, with minimum value on one line, and maximum on line two. Vice-versa is OK, too.
The "Use combo file" question tells the plugin whether to use the combo file or the separated files.  The combined file might be easier to use if you are modifying the values by hand.

]]


function hot_swap_timers(minFileLoc, maxFileLoc, comboFileLoc, combo, bootUp)

	local errorMsg = "\nNo error. This should not display.\n"
	errorType = "Unknown"
	local min = nil
	local max = nil
	local updateTimers = false

	if combo then --if using one file
		
		--Start processing data if combo file were found.
		local comboFile = io.open(comboFileLoc, "r") --load the combo value, as set in Plugin config
	
		if comboFile ~= nil then 

			minContents = comboFile:read("*line")
			maxContents = comboFile:read("*line")
			min = tonumber(minContents)
			max = tonumber(maxContents)
			comboFile:close()
			updateTimers = true
			
		else --file not found.
		
			errorMsg = "\n(" .. os.date("%H:%M:%S") .. ") :: The Hot Swap Timers plugin ran into an error loading your files.\nThe files you selected in the plugin's settings could not be found.\nCombo timer file location: " .. tostring(comboFileLoc) .. "\n"
			
			errorType = "File Not Found"
			
			if bootUp then
				
				errorMsg = "\n" .. os.date("%H:%M:%S") .. " :: The Shuffler could not start due to an error with the Hot Swap Timers plugin.\n" .. errorMsg
				error(errorMsg)
				
			else
				
				hstDisplayMsgFrames = 300
				print(errorMsg)
				
			end
			
		end --end if nil/nil
		
	
	end --end if combo
	
	


	if not combo then --if using two files
	
		--Start processing data if both files were found.
		minFile = io.open(minFileLoc, "r") --load the min value, as set in Plugin config
		maxFile = io.open(maxFileLoc, "r") --load the max value, as set in Plugin config
	
		if minFile ~= nil and maxFile ~= nil then 

			minContents = minFile:read()
			maxContents = maxFile:read()
			min = tonumber(minContents)
			max = tonumber(maxContents)
			minFile:close()
			maxFile:close()
			updateTimers = true
			
			-- update the min/max only if both are numbers. Otherwise, do nothin'
			if type(min) == "number" and type(max) =="number" then 

				min = math.floor(min + 0.5)
				max = math.floor(max + 0.5)

				--check they're input in the right order...
				if min > max then min, max = max, min end
				
				config.min_swap=min
				config.max_swap=max

			--one or both files did not contain numbers.
			else

				errorMsg = "\n(" .. os.date("%H:%M:%S") .. ") :: The Modifiable Swap Timers plugin ran into an error reading your files.\nYour timer files could not be processed by the plugin, usually because they contain non-numerical data.\nYour minimum time file contained: " .. tostring(minContentsLoc) .. "\nYour maximum time file contained: " .. tostring(maxContentsLoc) .. "\n"
				
				if bootUp then 
				
					errorMsg = "\n" .. os.date("%H:%M:%S") .. " :: The Shuffler could not start due to an error with the Hot Swap Timers plugin.\n" .. errorMsg
					error(errorMsg)
				
				else
				
					hstDisplayMsgFrames = 300
					print(errorMsg)
				
				end --end if bootUP
				
			end --end if min/max are numbers
		
		
		else --continues from if nil/nil. one or both files were not found.
		
			errorType = "File Not Found"
			errorMsg = "\n(" .. os.date("%H:%M:%S") .. ") :: The Hot Swap Timers plugin ran into an error loading your files.\nThe files you selected in the plugin's settings could not be found.\nMinimum timer file location: " .. tostring(minFile) .. "\nMaximum timer file location: " .. tostring(maxFile) .. "\n"
			
			if bootUp then
				
				errorMsg = "\n" .. os.date("%H:%M:%S") .. " :: The Shuffler could not start due to an error with the Hot Swap Timers plugin.\n" .. errorMsg
				error(errorMsg)
				
			else
				
				hstDisplayMsgFrames = 300
				print(errorMsg)
				
			end
			
		end --end if nil/nil
		
	
	end --end if not combo
	
	
	if updateTimers then 
		-- update the min/max only if both are numbers. Otherwise, do nothin'
		if type(min) == "number" and type(max) =="number" then 

			min = math.floor(min + 0.5)
			max = math.floor(max + 0.5)

			--check they're input in the right order...
			if min > max then min, max = max, min end
			
			config.min_swap=min
			config.max_swap=max

		--one or both files did not contain numbers.
		else

			errorType = "Numerical"
			errorMsg = "\n(" .. os.date("%H:%M:%S") .. ") :: The Modifiable Swap Timers plugin ran into an error reading your files.\nYour timer files could not be processed by the plugin, usually because they contain non-numerical data.\nYour minimum time file contained: " .. tostring(minContents) .. "\nYour maximum time file contained: " .. tostring(maxContents) .. "\nIf this error occurs frequently, you may need to check your timer files or setup.\nOtherwise, you can probably ignore it."
			
			if bootUp then 
			
				errorMsg = "\n" .. os.date("%H:%M:%S") .. " :: The Shuffler could not start due to an error with the Hot Swap Timers plugin.\n" .. errorMsg
				error(errorMsg)
			
			else
			
				hstDisplayMsgFrames = 0
				print(errorMsg)
				--I've decided not to have "numerical" type errors pop up on the screen, as it could simply be a case of "bot was saving file when plugin was reading it," and it will resolve itself on the next game swap.
			
			end --end if bootUP
					
		end --end if min/max are numbers
	
	end	 --end if updateTimers
end --end function


--This function is called once at the start of the session; if the plugin isn't called here, the first swap uses the "configuration screen" values.
function plugin.on_setup(data, settings)

	--initialize some variables
	hstDisplayMsgFrames = 0
	bootUp = true
	errorType = "Unknown"
	hot_swap_timers(settings.minFile, settings.maxFile, settings.comboFile, settings.combo, bootUp)
	bootUp = false

end -- Ends the On_Setup part of the plugin


--This is called every time the shuffler makes a save state, right before a swap.
function plugin.on_game_save(data, settings)
	
	hot_swap_timers(settings.minFile, settings.maxFile, settings.comboFile, settings.combo, bootUp)

end -- Ends the on_game_Save part of the plugin

--executes every frame. Only needed to display error messages.
function plugin.on_frame(data, settings)
	
	if hstDisplayMsgFrames > 0 then --display error
		
		hstDisplayMsgFrames = hstDisplayMsgFrames - 1

		gui.use_surface('client')
		gui.drawText((client.screenwidth() / 2), 25, string.format("Hot Swap Timer: " .. errorType.. " Error. See Lua Console."), 0xFFCCCCFF, 0xFF000000, 14, nil, nil, "center", nil)
	
	end --end error display
		

end --end on_frame plugin



return plugin