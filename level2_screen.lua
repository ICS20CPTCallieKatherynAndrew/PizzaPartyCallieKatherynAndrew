-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Andrew
-- Description: This is the level 2 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)

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
scoreNumber = 0

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

local PopUpTimer


-----------------------------------------------------------------------------------------
-- SOUND VARIABLES
-----------------------------------------------------------------------------------------
local bkgMusicLevel2 = audio.loadSound( "Sounds/bkgMusicLevel2.mp3")
local bkgMusicLevel2Channel 

local whackSound = audio.loadSound( "Sounds/whack.mp3")
local whackSoundChannel

local clickSound = audio.loadSound( "Sounds/clickSound.mp3")
local clickSoundChannel

local YouLoseusic = audio.loadSound( "Sounds/YouLose.mp3")
local YouLoseChannel 
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


-- transitioning to level 3
local function GoToLevel3()
    if (scoreNumber == 4) then
        composer.gotoScene( "level3_screen")

    end
end

local function YouLose()
    if (numLives == 0) then
        composer.gotoScene( "you_lose" )

        --play you Cheer sound
        youloseSoundChannel = audio.play(youloseSound)

        --stop cartoon014 music
        audio.stop(bkgMusicLevel2Channel)
    end
end

local function MainMenuTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
    clickSoundChannel = audio.play(clickSound)
end


-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeLevel2()
    -- call a function that updates the hearts
    PopUpDelay( )

    scoreObject.text = ( "Score = ".. scoreNumber)
    UpdateLives()
    GoToLevel3()
    YouLose()
end


--Creating a function that makes the Pizza appears in random (x,y) positions on the screen  
function PopUp()
    --Choosing random Position on the screen between 0 and the size of the screen
    Pizza.x = math.random( 0, display.contentWidth)
    Pizza.y = math.random( 0, display.contentHeight)

    --make the Pizza visible
    Pizza.isVisible = true

    --make the Pizza disapear after 1000 miliseconds
    PopUpTimer = timer.performWithDelay( 1000, Hide)
end

function GameStart( )
    PopUpDelay()
end

--This function calls the PopUp function after 1 seconds
function PopUpDelay( )
    PopUpTimer = timer.performWithDelay( 1000, PopUp)
end

--This function makes the Pizza invisible and then calls the PopUpDelay function
function Hide( )
    --Changing visibility
    Pizza.isVisible = false
    PopUpDelay()
end

--this function starts the game

--this function increments the score only if the Pizza is clicked.It then displays the new score.
function Whacked( event )
     -- If touch phase just started
    if (event.phase == "began") then
        clickSoundChannel = audio.play(clickSound)
        
        timer.cancel(PopUpTimer)     
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

        -- Creating Back Button
    mainMenuButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*7/8,
        y = display.contentHeight*2/16,
        width = 180,
        height = 130,

        -- Setting Visual Properties
        defaultFile = "Images/MainMenuButtonUnpressedCallie.png",
        overFile = "Images/MainMenuButtonPressedCallie.png",

        -- Setting Functional Properties
        onRelease = MainMenuTransition

    } )

    sceneGroup:insert( mainMenuButton )

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
        bkgMusicLevel2Channel = audio.play(bkgMusicLevel2, {channel = 2, loops = -1})
        GameStart()
        numLives = 2
        scoreNumber = 0

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
        Pizza:removeEventListener( "touch", Whacked)   
        audio.stop (bkgMusicLevel2Channel)
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