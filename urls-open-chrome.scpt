#!/usr/bin/osascript

#If you run AppleScript code via osascript in Terminal, then you need to add Terminal to System Preferences > Security & Privacy > Privacy > Accessibility, to allow it assistive access.

on run argv
    tell application "Google Chrome"
        activate

        repeat 40 times -- gives about 4 seconds to open Firefox if not opened
            if frontmost then exit repeat
            delay 0.1
        end repeat

        tell application "System Events" to tell application process "Google Chrome"
            set oldNbrOfWindow to (count of windows)
            keystroke "n" using command down
            repeat 20 times
                if ((count of windows) > oldNbrOfWindow) then exit repeat
                delay 0.1
            end repeat
        end tell

        repeat with the_url in argv
            open location the_url
        end repeat

        -- close the first default tab
        -- tell application "System Events"
        --     keystroke tab using control down
        --     delay 0.2
        --     keystroke "w" using command down
        -- end tell
    end tell
end run