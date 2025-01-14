on run argv
	set theMacro to (item 1 of argv)
	
	-- your script using the parameters follows
	
	tell application "Keyboard Maestro Engine"
		do script theMacro
	end tell
end run
