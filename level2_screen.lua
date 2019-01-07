-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Callie McWaters
-- Date: Nov. 22nd, 2014
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level2_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

numLives = 2

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local character
local Pizza
local live1
local live2
local scoreObject
local scoreNumber = 0

local questionsAnswered = 0

-----------------------------------------------------------------------------------------
-- SOUND VARIABLES
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------------------------- 
 
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
    clickSoundChannel = audio.play(clickSound)
end


local function MakeLivesVisible()
    live1.isVisible = true
    live2.isVisible = true
end




local function UpdateLives()

    if (numLives == 2) then
        --update hearts
        live2.isVisible = true
        live1.isVisible = true

    elseif (numLives == 1) then
        -- update hearts
        
        live1.isVisible = true 
        live2.isVisible = false

    else
        -- update hearts
        live1.isVisible = false
        live2.isVisible = false
        timer.performWithDelay(200, YouLoseTransition)
    end
end


local function YouWin()
    if (questionsAnswered == 3) then
        composer.gotoScene( "you_win")

    end
end



-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function BackToGame()

    -- call a function that updates the hearts
    UpdateLives()
end



--FUNCTIONS--
--Creating a function that makes the Pizza appears in random (x,y) positions on the screen  
function PopUp()
 --Choosing random Position on the screen between 0 and the size of the screen
 Pizza.x = math.random( 0, display.contentWidth)
 Pizza.y = math.random( 0, display.contentHeight)

 --make the Pizza visible
 Pizza.isVisible = true

 --make the Pizza disapear after 1000 miliseconds
 timer.performWithDelay( 1000, Hide)
end

--This function calls the PopUp function after 1 seconds
function PopUpDelay( )
 timer.performWithDelay( 1000, PopUp)
end

--This function makes the Pizza invisible and then calls the PopUpDelay function
function Hide( )
 --Changing visibility
  Pizza.isVisible = false
  PopUpDelay()
end

--this function starts the game
function GameStart( )
 PopUpDelay()
end

--this function increments the score only if the Pizza is clicked.It then displays the new score.
function Whacked( event )
     -- If touch phase just started
    if (event.phase == "began") then
        whackSoundChannel = audio.play(whackSound)
        scoreNumber = scoreNumber + 1
        scoreObject.isVisible = true
        Hide()
        scoreObject.text = ( "Score = "..scoreNumber)
        composer.showOverlay( "level2_question", { isModal = true, effect = "fade", time = 100})
    end
end


-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level2ScreenCallie.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentWidth / 2 
    bkg_image.y = display.contentHeight / 2

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    
   
    -- Insert the lives
    live1 = display.newImageRect("Images/PizzaSlice.png", 80, 80)
    live1.x = 50
    live1.y = 50

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( live1 )

    -- Insert the lives
    live2 = display.newImageRect("Images/PizzaSlice.png", 80, 80)
    live2.x = 130
    live2.y = 50

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( live2 )

    --create the Pizza and siplay it on the screen
    Pizza = display.newImage("Images/Pizza.png", 0 , 0 )
    --set the position of the Pizza and rescale the size of the Pizza to  one third of its original size
    Pizza.x = display.contentCenterX
    Pizza.y = display.contentCenterY
    Pizza:scale(1*2, 1*2)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( Pizza )

    --create the score text and display it on the screen
    scoreObject = display.newText( "Score = ".. scoreNumber, 160, 700, nil, 50)
    scoreObject:setTextColor(200/255, 220/255, 220/255)

    scoreObject.y = 450
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert(scoreObject)

end

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

    --Add the event listener to the moles so that if the Pizza is touched, the whacked function is called
    Pizza:addEventListener( "touch", Whacked)

    end-----------------------------------------------------------------------------------------
end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

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
GameStart( )
return scene