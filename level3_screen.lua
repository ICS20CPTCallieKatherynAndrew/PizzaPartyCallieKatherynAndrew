-----------------------------------------------------------------------------------------
--
-- level3_screen.lua
-- Created by: Katheryn
-- Description: This is the level 3 screen of the game.
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
sceneName = "level3_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
-----------------------------------------------------------------------------------------

numLives = 2
questionsAnswered = 0

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

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


local house1
local house2
local house3
local house4
local house5
local theHouse

local numberAnsweredText



-----------------------------------------------------------------------------------------
-- SOUND VARIABLES
-----------------------------------------------------------------------------------------
local bkgMusic = audio.loadSound( "Sounds/bkgLevel3Sound.mp3")
local bkgMusicChannel

local youWinSound = audio.loadSound( "Sounds/Mo.mp3")
local youWinSoundChannel

local YouLoseMusic = audio.loadSound( "Sounds/YouLose.mp3")
local YouLoseMusicChannel

local clickSound = audio.loadSound( "Sounds/clickSound.wav")
local clickSoundChannel

-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------------------------- 
 


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
    character = display.newImageRect("Images/PizzaCar.png", 100, 150)
    character.x = display.contentWidth * 0.1 / 8
    character.y = display.contentHeight  * 3 / 3
    character.width = 125
    character.height = 125
    character.myName = "PizzaCar"

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

local function MakeHouseVisible()
    house1.isVisible = true
    house2.isVisible = true
    house3.isVisible = true
    house4.isVisible = true
    house5.isVisible = true
end

local function YouLoseTransition()
    composer.gotoScene( "you_lose" )

    --play you Cheer sound
    YouLoseSoundChannel = audio.play(YouLoseSound)

    --stop cartoon014 music
    audio.stop(clickSoundChannel)
end

local function YouWinTransition()
    composer.gotoScene( "end_screen")
    
    --play you Cheer sound
    youWinSoundChannel = audio.play(youWinSound)

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

        if  (event.target.myName == "house1") or
            (event.target.myName == "house2") or
            (event.target.myName == "house3") or
            (event.target.myName == "house4") or
            (event.target.myName == "house5") then

            -- get the ball that the user hit
            theHouse = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false
            -- show overlay with math question
            composer.showOverlay( "level3_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
        end
    end
end

local function YouWin()
    if (questionsAnswered == 5) then
        YouWinTransition()
    end
end

local function AddCollisionListeners()

    -- if character collides with ball, onCollision will be called    
    house1.collision = onCollision
    house1:addEventListener( "collision" )

    house2.collision = onCollision
    house2:addEventListener( "collision" )

    house3.collision = onCollision
    house3:addEventListener( "collision" )

    house4.collision = onCollision
    house4:addEventListener( "collision" )

    house5.collision = onCollision
    house5:addEventListener( "collision" )
end 

local function RemoveCollisionListeners()

    house1:removeEventListener( "collision" )
    house2:removeEventListener( "collision" )
    house3:removeEventListener( "collision" )
    house4:removeEventListener( "collision")
    house5:removeEventListener( "collision")

end



local function AddPhysicsBodies()
    --add to the physics engine

    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )

    physics.addBody(house1, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(house2, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(house3, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(house4, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(house5, "static",  {density=0, friction=0, bounce=0} )

end

local function RemovePhysicsBodies()

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
        if (theHouse ~= nil) and (theHouse.isBodyActive == true) then
            physics.removeBody(theHouse)
            theHouse.isVisible = false

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
    bkg_image = display.newImageRect("Images/level3_screen.png", display.contentWidth, display.contentHeight)
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


    -- Insert the toppings
    house1 = display.newImageRect("Images/house.png", 40, 40)
    house1.x = display.contentWidth * 2 / 8
    house1.y = display.contentHeight * 3 / 4
    house1:scale(3.0 , 3.0)
    house1.myName = "house1"
    


    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( house1 )

    -- Insert the topping
    house2 = display.newImageRect("Images/house.png", 40, 40)
    house2.x = display.contentWidth* 1.9 / 8
    house2.y = display.contentHeight * 1.5 / 4
    house2:scale(3.0 , 3.0)
    house2.myName = "house2"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( house2 )

    -- Insert the topping
    house3 = display.newImageRect("Images/house.png", 40, 40)
    house3.x = display.contentWidth *3 / 5
    house3.y = display.contentHeight * 2.7 / 5
    house3:scale(3.0 , 3.0)
    house3.myName = "house3"
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( house3 )

    --insert the house
    house4 = display.newImageRect("Images/house.png", 40, 40)
    house4.x = display.contentWidth *4 / 5
    house4.y = display.contentHeight * 1.3 / 5
    house4:scale(3.0 , 3.0)
    house4.myName = "house4"
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( house4 )

    --insert the house
    house5 = display.newImageRect("Images/house.png", 40, 40)
    house5.x = 500
    house5.y = 160
    house5:scale(3.0 , 3.0)
    house5.myName = "house5"
   -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( house5 )


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

    numberAnsweredText = display.newText( "Number Answered = ".. questionsAnswered, display.contentWidth/2.1, display.contentHeight/1.1, nil, 50)
    numberAnsweredText:setTextColor(30/255, 219/255, 188/255)

    sceneGroup:insert(numberAnsweredText)


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

        timer.performWithDelay( 2000, MoveHouse1)
        timer.performWithDelay( 2000, MoveHouse2)
        timer.performWithDelay( 2000, MoveHouse3)
        timer.performWithDelay( 2000, MoveHouse4)
        timer.performWithDelay( 2000, MoveHouse5)

        bkgMusicChannel = audio.play(bkgMusic)

        numLives = 2
        questionsAnswered = 0
        
        -- make all lives visible
        MakeLivesVisible()

        MakeHouseVisible()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- create the character, add physics bodies and runtime listeners
        ReplaceCharacter()

        -- you win
        YouWin()




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