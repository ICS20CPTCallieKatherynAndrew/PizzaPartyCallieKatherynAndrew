-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Andrew Jr
-- Date: 2018-11-22
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------


-- hide the status dar  
display.setStatusBar(display.HiddenStatusBar)

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-- Create Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--SOUNDS 
-----------------------------------------------------------------------------------------

local goinghigherSound = audio.loadSound("Sounds/goinghigher.mp3")--Setting a variable to an mp3 file
local goinghigherSoundChannel 

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local AndrewLogo
local scrollSpeed = 5
local pizza
--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- Description:This function adds the scroll speed to the x-value of the ship
local function MoveAndrewLogo(event) 
    -- add the scroll speed to the x-value of the ship
    AndrewLogo.x = AndrewLogo.x + scrollSpeed  
    AndrewLogo.alpha = AndrewLogo.alpha - 0.003
  
    -- change the transparency of the ship every time it moves so that it fades out   
end

local function Movepizza(event) 
    -- add the scroll speed to the x-value of the ship
    pizza.x = pizza.x + scrollSpeed  
    pizza.alpha = pizza.alpha - 0.003
  
    -- change the transparency of the ship every time it moves so that it fades out
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

    -- set the background to be black
    display.setDefault("background", 70/255, 54/255, 90/255)

    -- Insert the AndrewLogo image
    AndrewLogo = display.newImageRect("Images/AndrewLogo.png", 800, 800)

    -- character image with width and height 
    pizza = display.newImageRect("Images/Pizza.png", 320, 320)

    --set the initial x and y position of AndrewLogo
    pizza.x = 500
    pizza.y = 600

    --set the initial x and y position of pizza
    AndrewLogo.x = 0
    AndrewLogo.y = display.contentHeight/3

    --set the initial x and y position of AndrewLogo
    AndrewLogo.x = 0
    AndrewLogo.y = 400
   

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( AndrewLogo )

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( pizza )


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
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        goinghigherSoundChannel = audio.play(goinghigherSound)

        -- MoveShip will be called over and over again
        Runtime:addEventListener("enterFrame", MoveAndrewLogo) 
        Runtime:addEventListener("enterFrame", Movepizza) 
           

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
    ----------------------------------------------------------------------------
    --called immediately 
    elseif( phase == "did" )then

        audio.stop(goinghigherSoundChannel)
    end

    -----------------------------------------------------------------------------------------
end

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
