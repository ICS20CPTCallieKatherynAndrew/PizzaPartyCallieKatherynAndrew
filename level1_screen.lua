-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Callie McWaters
-- Date: Nov. 22nd, 2014
-- Description: This is the level 1 screen of the game.
-----------------------------------------------------------------------------------------

-- hiding the status bar

display.setStatusBar(display.HiddenStatusBar)
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
sceneName = "level1_screen"

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

local platform1
local platform2
local platform3
local platform4

local character

local live1
local live2


local rArrow 
local uArrow
local lArrow

local motionx = 0
local SPEED = 7
local speed = -7
local LINEAR_VELOCITY = -100
local GRAVITY = 10
local leftW 
local rightW
local topW
local floor

local pizza1

local topping1
local topping2
local topping3
local theTopping

local questionsAnswered = 0

-----------------------------------------------------------------------------------------
-- SOUND VARIABLES
-----------------------------------------------------------------------------------------
local bkgMusic = audio.loadSound( "Sounds/bkgMusicLevel1.mp3")
local bkgMusicChannel
local MoMusic = audio.loadSound( "Sounds/Mo.mp3")
local MoMusicChannel
local YouLoseMusic = audio.loadSound( "Sounds/YouLose.mp3")
local YouLoseMusicChannel
local clickSound = audio.loadSound( "Sounds/clickSound.wav")
local clickSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------------------------- 
 
local function BackTransition( )
    composer.gotoScene( "main_menu", {effect = "zoomOutInFadeRotate", time = 500})
    clickSoundChannel = audio.play(clickSound)
end

-- When right arrow is touched, move character right
local function right (touch)
    motionx = SPEED
    character.xScale = 1
end

local function left (touch)
    motionx = speed
    character.xScale = -1
end

-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    if (character ~= nil) then
        character:setLinearVelocity( 0, LINEAR_VELOCITY )
    end
end

-- Move character horizontally
local function movePlayer (event)
    character.x = character.x + motionx
end
 
-- Stop character movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
    end
end


local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
    lArrow:addEventListener("touch", left)
end

local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)
end

local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop )
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("touch", stop )
end


local function ReplaceCharacter()
    character = display.newImageRect("Images/PizzaMan.png", 100, 150)
    character.x = display.contentWidth * 0.1 / 8
    character.y = display.contentHeight  * 3 / 3
    character.width = 125
    character.height = 125
    character.myName = "PizzaMan"

    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

local function MakeLivesVisible()
    live1.isVisible = true
    live2.isVisible = true
end

local function MakeToppingsVisible()
    topping1.isVisible = true
    topping2.isVisible = true
    topping3.isVisible = true
end

local function YouLoseTransition()
    composer.gotoScene( "you_lose" )

    --play you Cheer sound
    YouLoseSoundChannel = audio.play(YouLoseSound)

    --stop cartoon014 music
    audio.stop(clickSoundChannel)
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

local function onCollision( self, event )


    if ( event.phase == "began" ) then

        if  (event.target.myName == "topping1") or
            (event.target.myName == "topping2") or
            (event.target.myName == "topping3") then

            -- get the ball that the user hit
            theTopping = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false
            -- show overlay with math question
            composer.showOverlay( "level1_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1
            level2_screen()
        end
    end
end

function level2_screen()
    if (questionsAnswered == 3) then
        composer.gotoScene( "level2_screen")
    
        --play you Cheer sound
        MoSoundChannel = audio.play(MOSound)

        --stop cartoon014 music
        audio.stop(clickSoundChannel)
    end
end

local function AddCollisionListeners()

    -- if character collides with ball, onCollision will be called    
    topping1.collision = onCollision
    topping1:addEventListener( "collision" )
    topping2.collision = onCollision
    topping2:addEventListener( "collision" )
    topping3.collision = onCollision
    topping3:addEventListener( "collision" )
end 

local function RemoveCollisionListeners()

    topping1:removeEventListener( "collision" )
    topping2:removeEventListener( "collision" )
    topping3:removeEventListener( "collision" )

end




local function MovePizza()

    -- the logo will move and rotate to the center of the screen
    transition.to( pizza, { rotation = pizza.rotation-360, time=2000, onComplete=spinImage})
    transition.to( pizza, {x=900, y=50, time=2000})
end

local function MoveTopping1()
    -- the logo will move and rotate to the center of the screen
    transition.to( topping1, { rotation = topping1.rotation-360, time=2000, onComplete=spinImage})
    transition.to( topping1, {x=600, y=350, time=2000})
    topping1:scale(2,2)
end

local function MoveTopping2()
    -- the logo will move and rotate to the center of the screen
    transition.to( topping2, { rotation = topping2.rotation-360, time=2000, onComplete=spinImage})
    transition.to( topping2, {x=800, y=135, time=2000})
    topping2:scale(2,2)
end

local function MoveTopping3()
    -- the logo will move and rotate to the center of the screen
    transition.to( topping3, { rotation = topping3.rotation-360, time=2000, onComplete=spinImage})
    transition.to( topping3, {x=200, y=220, time=2000})
    topping3:scale(2,2)
end


local function AddPhysicsBodies()
    --add to the physics engine
    physics.addBody( platform1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform3, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform4, "static", { density=1.0, friction=0.3, bounce=0.2 } )

    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )

    physics.addBody(topping1, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(topping2, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(topping3, "static",  {density=0, friction=0, bounce=0} )

end

local function RemovePhysicsBodies()
    physics.removeBody(platform1)
    physics.removeBody(platform2)
    physics.removeBody(platform3)
    physics.removeBody(platform4)

    physics.removeBody(leftW)
    physics.removeBody(rightW)
    physics.removeBody(topW)
    physics.removeBody(floor)
 
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeGame()

    -- call a function that updates the hearts
    UpdateLives()

    -- make character visible again
    character.isVisible = true
    
    if (questionsAnswered > 0) then
        if (theTopping ~= nil) and (theTopping.isBodyActive == true) then
            physics.removeBody(theTopping)
            transition.to( theTopping, { rotation = theTopping.rotation-360, time=2000, onComplete=spinImage})
            transition.to( theTopping, {x=900, y=50, time=2000})
            theTopping:scale(0.5, 0.5)
        end
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
    bkg_image = display.newImageRect("Images/Level1ScreenCallie.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentWidth / 2 
    bkg_image.y = display.contentHeight / 2

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    
    
    -- Insert the platforms
    platform1 = display.newImageRect("Images/Platforms.png", 250, 50)
    platform1.x = display.contentWidth * 2 / 8
    platform1.y = display.contentHeight * 3 / 4
        
    sceneGroup:insert( platform1 )

    platform2 = display.newImageRect("Images/Platforms.png", 150, 50)
    platform2.x = display.contentWidth* 1.9 / 8
    platform2.y = display.contentHeight * 1.5 / 4
        
    sceneGroup:insert( platform2 )

    platform3 = display.newImageRect("Images/Platforms.png", 180, 50)
    platform3.x = display.contentWidth *3 / 5
    platform3.y = display.contentHeight * 2.7 / 5
        
    sceneGroup:insert( platform3 )

    platform4 = display.newImageRect("Images/Platforms.png", 180, 50)
    platform4.x = display.contentWidth *4 / 5
    platform4.y = display.contentHeight * 1.3 / 5
        
    sceneGroup:insert( platform4 )

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

    -- Insert the pizza
    pizza = display.newImageRect("Images/Pizza 1.png", 175, 100)
    pizza.x = display.contentWidth * 1.5 / 8
    pizza.y = display.contentHeight * 3.5 / 4
        
    sceneGroup:insert( pizza )

    -- Insert the toppings
    topping1 = display.newImageRect("Images/Pepperoni.png", 40, 40)
    topping1.x = 190
    topping1.y = 690
    topping1.myName = "topping1"
    


    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topping1 )

    -- Insert the topping
    topping2 = display.newImageRect("Images/Pepper.png", 40, 40)
    topping2.x = 210
    topping2.y = 650
    topping2.myName = "topping2"
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topping2 )

    -- Insert the topping
    topping3 = display.newImageRect("Images/Mushroom.png", 40, 40)
    topping3.x = 160
    topping3.y = 660
    topping3.myName = "topping3"
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topping3 )

    --Insert the right arrow
    rArrow = display.newImageRect("Images/RightArrow.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rArrow)
   
    --Insert the left arrow
    lArrow = display.newImageRect("Images/LeftArrow.png", 100, 50)
    lArrow.x = display.contentWidth *7.2 / 10
    lArrow.y = display.contentHeight * 9.5 / 10

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( lArrow)

    --Insert the left arrow
    uArrow = display.newImageRect("Images/UpArrow.png", 50, 100)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = display.contentHeight * 8.5 / 10


    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( uArrow)

    --WALLS--
    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( leftW )

    rightW = display.newLine( 0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rightW )

    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topW )

    floor = display.newImageRect("Images/Platforms.png", 1024, 100)
    floor.x = display.contentCenterX
    floor.y = display.contentHeight * 1.06
    
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( floor )


end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------
        -- start physics
        physics.start()

        -- set gravity
        physics.setGravity( 0, GRAVITY )
        
    elseif ( phase == "did" ) then

        timer.performWithDelay( 2000, MoveTopping1)
        timer.performWithDelay( 2000, MoveTopping2)
        timer.performWithDelay( 2000, MoveTopping3)
        timer.performWithDelay( 2000, MovePizza)
        bkgMusicChannel = audio.play(bkgMusic)

        numLives = 2
        questionsAnswered = 0
        
        -- make all lives visible
        MakeLivesVisible()

        MakeToppingsVisible()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- create the character, add physics bodies and runtime listeners
        ReplaceCharacter()

    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        audio.pause(bkgMusic)
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemovePhysicsBodies()
        RemoveCollisionListeners()

        physics.stop()
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()
        display.remove(character)
        
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