-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Callie McWaters
-- Date: 11/29/2018
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-- hiding the status bar
display.setStatusBar(display.HiddenStatusBar)

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local creditsButton
local instructionsbutton
local appName

-----------------------------------------------------------------------------------------
-- SOUND VARIABLES
-----------------------------------------------------------------------------------------
local bkgMusic = audio.loadSound( "Sounds/bkgMusicMainMenu.mp3")
local bkgMusicChannel
local clickSound = audio.loadSound( "Sounds/clickSound.mp3")
local clickSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "zoomOutIn", time = 500})
    clickSoundChannel = audio.play(clickSound)
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "fade", time = 1000})
    clickSoundChannel = audio.play(clickSound)
end    


-- Creating Transition Function to Credits Page
local function InstructionsTransition()
    composer.gotoScene( "instructions_screen", {effect = "zoomOutIn", time = 500})
    clickSoundChannel = audio.play(clickSound)
end

local function LevelSelectTransition()
    composer.gotoScene( "level_select", {effect = "zoomOutIn", time = 500})
    clickSoundChannel = audio.play(clickSound)
end


-- INSERT LOCAL FUNCTION DEFINITION THAT GOES TO INSTRU-CTIONS SCREEN 

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/MainMenu.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight


    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -- create the company name text
    appName = display.newText( " Pizza Party! ", 530, 300, nil, 100 )

    appName:setTextColor(0/255, 128/255, 255/255)

    sceneGroup:insert(appName)
    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*1/8,

            width = 200,
            height = 100,
            -- Insert the images here
            defaultFile = "Images/PlayButtonUnpressed.png",
            overFile = "Images/PlayButtonPressed.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition         
        } )
    -----------------------------------------------------------------------------------------
    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*6.7/8,
            y = display.contentHeight*1/8,
            width = 200,
            height = 100,
            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressed.png",
            overFile = "Images/CreditsButtonPressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    
    -- creating instructions button
    instructionsbutton = widget.newButton(
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1.3/8,
            y = display.contentHeight*1/8,
            
            width = 200,
            height = 100,
            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressed.png",
            overFile = "Images/InstructionsButtonPressed.png",

            -- When the button is released, call the Credits transition function
            onRelease = InstructionsTransition
        } ) 

        -- creating instructions button
    levelSelectButton = widget.newButton(
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*1.3/8,
            y = display.contentHeight*7/8,
            
            width = 200,
            height = 100,
            -- Insert the images here
            defaultFile = "Images/LevelSelectButtonUnpressedCallie.png",
            overFile = "Images/LevelSelectButtonPressedCallie.png",

            -- When the button is released, call the Credits transition function
            onRelease = LevelSelectTransition
        } ) 
    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsbutton)
    sceneGroup:insert( levelSelectButton)

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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
        -- play bkg music
        bkgMusicChannel = audio.play(bkgMusic)
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
        audio.pause(bkgMusic)
     -----------------------------------------------------------------------------------------

   elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        -- stoping the bkg music

    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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
