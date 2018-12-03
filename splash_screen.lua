-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local companyName1
local companyName2
local spinSound = audio.loadSound( "Sounds/spinSound.WAV")
local spinSoundChannel

--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the beetleship across the screen
local function MoveLogo()

    -- the logo will move and rotate to the center of the screen
    transition.to( logo, { rotation = logo.rotation-360, time=2000, onComplete=spinImage})
    transition.to( logo, {x=512, y=384, time=2000})
end

local function MoveText()

    -- the text will move and rotate to the center of the screen
    transition.to( companyName1, { rotation = companyName1.rotation-360, time=2000, onComplete=spinImage})
    transition.to( companyName1, {x=710, y=490, time=2000})
    transition.to( companyName2, { rotation = companyName2.rotation-360, time=2000, onComplete=spinImage})
    transition.to( companyName2, {x=710, y=580, time=2000})
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background colour
    display.setDefault("background", 86/255, 249/255, 113/255)

    -- display the logo
    logo = display.newImageRect("Images/CompanyLogo.png", 500, 500)
    logo.x = 0
    logo.y = display.contentHeight/2

    -- display the company name
    companyName1 = display.newText( " Jumping ", 1000, 500, nil, 70 )
    companyName2 = display.newText( " Animations ", 1000, 600, nil, 70 )

    -- set the colour of the text
    companyName1:setTextColor(44/255, 55/255, 167/255)
    companyName2:setTextColor(44/255, 55/255, 167/255)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )
    sceneGroup:insert( companyName1 )
    sceneGroup:insert( companyName2 )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
        -- Call the moveBeetleship function as soon as we enter the frame.
        --Runtime:addEventListener("enterFrame", MoveLogo)
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        spinSoundChannel = audio.play(spinSound)

        MoveLogo()
        MoveText()

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the jungle sounds channel for this screen
        audio.stop(spinSound)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
