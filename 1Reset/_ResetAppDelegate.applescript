--
--  _ResetAppDelegate.applescript
--  1Reset
--
--  Created by Calvin Barrie on 6/3/14.
--
--

script _ResetAppDelegate
	property parent : class "NSObject"
    property dropboxValue : missing value
    property iCloudValue : missing value
    property localValue : missing value
    property prefsValue : missing value
    property usrPass : missing value
    
	
	-- IBOutlets
	property window : missing value
    property aboutWindow : missing value
    property startUpWindow : missing value
    
    -----------------------------------------
    -- 'Actually program code' starts here --
    -----------------------------------------
    
    on dropboxChecked_(sender)
        -- When Dropbox checkbox is checked or uncheck this puts that info inside dropboxValue
        set dropboxValue to sender's intValue() as boolean
    end dropboxChecked_
    
    on iCloudChecked_(sender)
        -- When iCloud checkbox is checked or uncheck this puts that info inside iCloudValue
        set iCloudValue to sender's intValue() as boolean
    end iCloudChecked_
    
    on localChecked_(sender)
        -- When local checkbox is checked or uncheck this puts that info inside localValue
        set localValue to sender's intValue() as boolean
    end localChecked_
    
    on prefsChecked_(sender)
        -- When preferences checkbox is checked or uncheck this puts that info inside prefsValue
        set prefsValue to sender's intValue() as boolean
    end localChecked_
    
    on resetStarted_(sender)
        -- When the reset button is pressed this code is run.
        -- First step is to make sure passWorked is false.
        set passWorked to false
        -- Now we try to do something involving the current user and the password that the user is about to provide. If it works it will run the script.
        try
            -- Step 1: Ask user for Admin password
            set usrPass to the text returned of (display dialog "Please Enter Admin password" default answer "" with hidden answer)
            -- Step 2: Test provided password
            set testPass to do shell script "sudo cd ~/" user name (short user name of (system info)) password usrPass with administrator privileges
            -- Step 3a: Set passWorked to true so we know that the password worked. If password fails see 3b.
            set passWorked to true
            --------------- Original shell command note ------------------
            -- do shell script "sudo rm -r /System/test | echo " & usrPass
            --------------------------------------------------------------
            -- Step 4: Since the password worked go ahead and run the heart of the program
            if dropboxValue is true then do shell script "sudo rm -r /System/dropbox" user name (short user name of (system info)) password usrPass with administrator privileges
            if localValue is true then do shell script "sudo rm -r /System/local" user name (short user name of (system info)) password usrPass with administrator privileges
            if iCloudValue is true then do shell script "sudo rm -r /System/iCloud" user name (short user name of (system info)) password usrPass with administrator privileges
        end try
        -- Step 3b: If password did not work then prompt the user to try again.
        if passWorked is false then display dialog "The password provided did not work. Please try again. If this program is not being run on an administrator account please change accounts and try again."
    end resetStarted_
    
    --------------------------------------------------------------------------------------------------
    -- The following method is fo resetting my test folders and will be missing from the final build
    -- on resetTestFolders_(sender)
    --   if usrPass equals "" then set usrPass to the text returned of (display dialog "Please Enter Admin password" default answer "" with hidden answer)
    --    do shell script "sudo mkdir /System/dropbox > /dev/null 2>&1 &" user name (short user name of (system info)) password usrPass with administrator privileges
    --    do shell script "sudo mkdir /System/local > /dev/null 2>&1 &" user name (short user name of (system info)) password usrPass with administrator privileges
    --    do shell script "sudo mkdir /System/iCloud > /dev/null 2>&1 &" user name (short user name of (system info)) password usrPass with administrator privileges
    --end
    --------------------------------------------------------------------------------------------------
    
    on aboutMenuClicked_(sender)
        aboutWindow's orderFront_(me)
    end aboutMenuClicked_
    
    -- This method tell the application to quit upon the window being closed.
    on applicationShouldTerminateAfterLastWindowClosed_(theApplication)
        return YES
    end applicationShouldTerminateAfterLastWindowClosed_
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
        -- Makes sure that we have an empty space to put the user's password
        set usrPass to ""
        -- 65535 should be option keycode
        
        displayDialog
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script