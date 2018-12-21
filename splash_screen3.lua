
-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen3"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local text
scrollspeed = 3
----------------------------------------------------------------------------------------
--SOUNDS 
-----------------------------------------------------------------------------------------
local soundEffectSound = audio.loadSound("Sounds/splash_screen3.mp3")
local soundEffectSoundChannel
--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the logo across the screen
local function MoveLogo()
    -- scroll speed
    logo.x = logo.x + scrollspeed
    --change the transparency
    logo.alpha = logo.alpha + 0.01
end

local function MoveText()
    --scroll speed
    text.x = text.x - scrollspeed
    --change the transparency
    text.alpha = text.alpha - 0.001
end

local function RotatePizzaMan(event)
    --rotate pizza man
    logo.rotation = logo.rotation + 3
end

local function ScaleText(event)
    --scale the text
    text:scale(1.002, 1.002)
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
    display.setDefault("background",  0/255, 160/255, 0/255)

    -- display the logo
    logo = display.newImageRect("Images/CompanyLogoKatheryn.png", 500, 500)
    logo.x = 0
    logo.y = display.contentHeight/2
    logo.alpha = 1

    -- display the company name
    text = display.newText( " Jumping Animations ", 400, 400, nil, 70 )
    text.x = 1048
    text.y = display.contentHeight/3
        text.alpha = 1
    -- set the colour of the text
    text:setTextColor(216/255, 19/255, 19/255)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )
    sceneGroup:insert( text )
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
        soundEffectSoundChannel = audio.play( soundEffectSound)
        
        Runtime:addEventListener("enterFrame", MoveLogo)
        Runtime:addEventListener("enterFrame", MoveText)
        Runtime:addEventListener("enterFrame", RotatePizzaMan)
        Runtime:addEventListener("enterFrame", ScaleText)

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
