-----------------------------------------------------------------------------------------
-- level_select.lua
-- Created by: Callie McWaters
-- Date: 1/10/2018
-- Description: This is the level select page, displaying a back button to the main menu.
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level_select"

-- Creating Scene Object
scene = composer.newScene( sceneName ) -- This function doesn't accept a string, only a variable containing a string

-- set the background colour
display.setDefault("background", 154/255, 249/255, 199/255)

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
local backButton
local level1Text
local level2Text
local level3Text
-----------------------------------------------------------------------------------------
-- SOUND VARIABLES
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transitioning Function back to main menu
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
    clickSoundChannel = audio.play(clickSound)
end

local function Level1Transition( )
    composer.gotoScene( "level1_screen", {effect = "zoomOutInFadeRotate", time = 500})
    clickSoundChannel = audio.play(clickSound)
end

local function Level2Transition( )
    composer.gotoScene( "level2_screen", {effect = "zoomOutInFadeRotate", time = 500})
    clickSoundChannel = audio.play(clickSound)
end

local function Level3Transition( )
    composer.gotoScene( "level3_screen", {effect = "zoomOutInFadeRotate", time = 500})
    clickSoundChannel = audio.play(clickSound)
end



-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    
    level1Text = display.newText( " Level 1 ", 200, 600, nil, 75)

    level1Text:setTextColor(0/255, 128/255, 255/255)

    sceneGroup:insert(level1Text)


    level2Text = display.newText( " Level 2 ", 500, 600, nil, 75 )

    level2Text:setTextColor(0/255, 128/255, 255/255)

    sceneGroup:insert(level2Text)


    level3Text = display.newText( " Level 3 ", 850, 600, nil, 75 )

    level3Text:setTextColor(0/255, 128/255, 255/255)

    sceneGroup:insert(level3Text)
    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    -- Creating Back Button
    backButton = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*7/8,
        y = display.contentHeight*2/16,
        width = 180,
        height = 120,

        -- Setting Visual Properties
        defaultFile = "Images/BackButtonUnpressed.png",
        overFile = "Images/BackButtonPressed.png",

        -- Setting Functional Properties
        onRelease = BackTransition

    } )
        -- Creating Back Button
    level1Button = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*1.5/8,
        y = display.contentHeight*7/16,
        width = 300,
        height = 270,

        -- Setting Visual Properties
        defaultFile = "Images/Level1ScreenCallie.png",
        overFile = "Images/Level1ScreenCallie.png",

        -- Setting Functional Properties
        onRelease = Level1Transition

    } )

    -- Creating Back Button
    level2Button = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*4/8,
        y = display.contentHeight*7/16,
        width = 300,
        height = 270,

        -- Setting Visual Properties
        defaultFile = "Images/Level2ScreenCallie.png",
        overFile = "Images/Level2ScreenCallie.png",

        -- Setting Functional Properties
        onRelease = Level2Transition

    } )

    -- Creating Back Button
    level3Button = widget.newButton( 
    {
        -- Setting Position
        x = display.contentWidth*6.5/8,
        y = display.contentHeight*7/16,
        width = 300,
        height = 270,

        -- Setting Visual Properties
        defaultFile = "Images/level3_screen.png",
        overFile = "Images/level3_screen.png",

        -- Setting Functional Properties
        onRelease = Level3Transition

    } )


    -----------------------------------------------------------------------------------------

    -- Associating Buttons with this scene
    sceneGroup:insert( backButton )
    sceneGroup:insert( level1Button )
    sceneGroup:insert( level2Button )
    sceneGroup:insert( level3Button )
    
end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.


    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.

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

end --function scene:destroy( event )

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


