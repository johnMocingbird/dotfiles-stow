execute AppleScript
set baseURL to "https://github.com/MyMOC/front-end/pulls"

tell application "Safari"
      if not (running) then
        -- Safari is not running, open the URL in a new window
        open location baseURL
        activate
    else
        -- Safari is running, check if a URL starting with the base URL is already open in a tab
        set found to false
        repeat with w in windows
            repeat with t in tabs of w
                set currentURL to URL of t
                -- Check if the URL starts with the base URL and has the correct protocol and subdomain
                if currentURL starts with baseURL then
                    -- Base URL is found, switch to this tab
                    set current tab of w to t
                    set index of w to 1 -- bring the window to the front
                    activate
                    set found to true
                    exit repeat
                end if
            end repeat
            if found then exit repeat
        end repeat
        
        if not found then
            -- URL not found in any tab, open it in a new tab
            tell window 1
                set newTab to make new tab with properties {URL:baseURL}
            end tell
            set current tab of window 1 to newTab
            set index of window 1 to 1 -- bring the window to the front
            activate
        end if
    end if
end tell
 Display trimmed results without errors briefly.
stop macro and notify on failure.
		 
