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
sceneName = "end_screen"

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
local pizzaMan
local scrollSpeed = 2
local pizza
local house
--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- Description:This function adds the scroll speed to the x-value of the pizzaMan
local function MovePizzaMan(event) 
    -- add the scroll speed to the x-value of the pizzaMan
    pizzaMan.x = pizzaMan.x + scrollSpeed    
end

local function MovePizza()
        -- add the scroll speed to the x-value of the pizzaMan
    pizza.x = pizza.x + scrollSpeed    
end


-- The function that will go to the main menu 
local function gotoYouWin()
    composer.gotoScene( "you_win" )
end

local function MoveHouse()
    house.x = house.x + scrollSpeed
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 100/255, 54/255, 200/255)

    -- Insert the AndrewLogo image
    pizzaMan = display.newImageRect("Images/PizzaMan.png", 400, 400)


    --set the initial x and y position of the pizzaMan
    pizzaMan.x = 0
    pizzaMan.y = display.contentHeight/3


   

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( pizzaMan )

    -- Insert the AndrewLogo image
    pizza = display.newImageRect("Images/Pizza.png", 100, 100)


    --set the initial x and y position of the pizza
    pizza.x = display.contentWidth/3
    pizza.y = display.contentHeight/3

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( pizza )

end 

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
        Runtime:addEventListener("enterFrame", MovePizzaMan) 
        Runtime:addEventListener("enterFrame", MovePizza) 

           

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoYouWin)          
        
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
