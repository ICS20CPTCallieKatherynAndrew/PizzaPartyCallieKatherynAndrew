-----------------------------------------------------------------------------------------
--
-- level1_screen.lua
-- Created by: Allison
-- Date: May 16, 2017
-- Description: This is the level 1 screen of the game. the charater can be dragged to move
--If character goes off a certain araea they go back to the start. When a user interactes
--with piant a trivia question will come up. they will have a limided time to click on the answer
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level1_question"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------


--the text that displays the question
local questionText 

--the alternate numbers randomly generated
local correctAnswer
local alternateAnswer1
local alternateAnswer2  
local alternateAnswer3  

-- Variables containing the user answer and the actual answer
local userAnswer

-- boolean variables telling me which answer box was touched
local answerboxAlreadyTouched = false
local alternateAnswerBox1AlreadyTouched = false
local alternateAnswerBox2AlreadyTouched = false
local alternateAnswerBox3AlreadyTouched = false

--create textboxes holding answer and alternate answers 
local answerbox
local alternateAnswerBox1
local alternateAnswerBox2
local alternateAnswerBox3

local cover
local bkg

-- create variables that will hold the previous x- and y-positions so that 
-- each answer will return back to its previous position after it is moved
local answerboxPreviousY
local alternateAnswerBox1PreviousY
local alternateAnswerBox2PreviousY
local alternateAnswerBox3PreviousY

local answerboxPreviousX
local alternateAnswerBox1PreviousX
local alternateAnswerBox2PreviousX
local alternateAnswerBox3PreviousX

-- the black box where the user will drag the answer
local userAnswerBoxPlaceholder

local amountCorrect = 0

local randomOperator

local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
local function DisplayQuestion()
    local randomNumber1
    local randomNumber2

    --set random numbers
    randomOperator = math.random(1,2)
    randomNumber1 = math.random(1, 30)
    randomNumber2 = math.random(1, 30)

    if ( randomOperator == 1) then

        --  calculate answer
        correctAnswer = randomNumber1 + randomNumber2

        --change question text in relation to answer
        questionText.text = randomNumber1 .. " + " .. randomNumber2 .. " = " 

        -- put the correct answer into the answerbox
        answerbox.text = correctAnswer

        -- make it possible to click on the answers again
        answerboxAlreadyTouched = false
        alternateAnswerBox1AlreadyTouched = false
        alternateAnswerBox2AlreadyTouched = false
        alternateAnswerBox3AlreadyTouched = false

    elseif  ( randomOperator == 2 ) then

        if ( randomNumber1 > randomNumber2 ) then

            -- calculating the correct answer
            correctAnswer = randomNumber1 - randomNumber2
        
            questionText.text = randomNumber1  .. " - " .. randomNumber2.. " = "

            -- put the correct answer into the answerbox
            answerbox.text = correctAnswer 

            -- make it possible to click on the answers again
            answerboxAlreadyTouched = false
            alternateAnswerBox1AlreadyTouched = false
            alternateAnswerBox2AlreadyTouched = false
            alternateAnswerBox3AlreadyTouched = false

        else

            -- calculating the correct answer
            correctAnswer = randomNumber2 - randomNumber1
        
            -- create question in text object
            questionText.text = randomNumber2  .. " - " .. randomNumber1 .. " = "
            
            -- put the correct answer into the answerbox
            answerbox.text = correctAnswer 
            -- make it possible to click on the answers again
            answerboxAlreadyTouched = false
            alternateAnswerBox1AlreadyTouched = false
            alternateAnswerBox2AlreadyTouched = false
            alternateAnswerBox3AlreadyTouched = false
        end



    end
end

local function DetermineAlternateAnswers()    

        
    -- generate incorrect answer and set it in the textbox
    alternateAnswer1 = correctAnswer + math.random(3, 9)
    alternateAnswerBox1.text = alternateAnswer1

    -- generate incorrect answer and set it in the textbox
    alternateAnswer2 = correctAnswer - math.random(1, 5)
    alternateAnswerBox2.text = alternateAnswer2

    -- generate incorrect answer and set it in the textbox
    alternateAnswer3 = correctAnswer + math.random(9, 15)
    alternateAnswerBox3.text = alternateAnswer3
-------------------------------------------------------------------------------------------
-- RESET ALL X POSITIONS OF ANSWER BOXES (because the x-position is changed when it is
-- placed into the black box)
-----------------------------------------------------------------------------------------
    
    
    
end


local function PositionAnswers()
    local randomPosition

    -------------------------------------------------------------------------------------------
    --ROMDOMLY SELECT ANSWER BOX POSITIONS
    -----------------------------------------------------------------------------------------
    randomPosition = math.random(1,4)

    -- random position 1
    if (randomPosition == 1) then
        -- set the new y-positions of each of the answers
        answerbox.y = display.contentHeight * 0.4
        answerbox.x = display.contentWidth * 0.6
    
        --alternateAnswerBox3
        alternateAnswerBox3.y = display.contentHeight * 0.4
        alternateAnswerBox3.x = display.contentWidth * 0.4

        --alternateAnswerBox2
        alternateAnswerBox2.y = display.contentHeight * 0.6
        alternateAnswerBox2.x = display.contentWidth * 0.6
        --alternateAnswerBox1
        alternateAnswerBox1.y = display.contentHeight * 0.6
        alternateAnswerBox1.x = display.contentWidth * 0.4
        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        alternateAnswerBox1PreviousY = alternateAnswerBox1.y
        alternateAnswerBox2PreviousY = alternateAnswerBox2.y
        alternateAnswerBox3PreviousY = alternateAnswerBox3.y
        answerboxPreviousY = answerbox.y 

    -- random position 2
    elseif (randomPosition == 2) then

        answerbox.y = display.contentHeight * 0.6
        answerbox.x = display.contentWidth * 0.4
    
        --alternateAnswerBox3
        alternateAnswerBox3.y = display.contentHeight * 0.4
        alternateAnswerBox3.x = display.contentWidth * 0.4

        --alternateAnswerBox2
        alternateAnswerBox2.y = display.contentHeight * 0.6
        alternateAnswerBox2.x = display.contentWidth * 0.6
        --alternateAnswerBox1
        alternateAnswerBox1.y = display.contentHeight * 0.4
        alternateAnswerBox1.x = display.contentWidth * 0.6

        --remembering their positions to return the answer in case it's wrong
        alternateAnswerBox1PreviousY = alternateAnswerBox1.y
        alternateAnswerBox2PreviousY = alternateAnswerBox2.y
        alternateAnswerBox3PreviousY = alternateAnswerBox3.y
        answerboxPreviousY = answerbox.y 

    -- random position 3
     elseif (randomPosition == 3) then
        answerbox.y = display.contentHeight * 0.4
        answerbox.x = display.contentWidth * 0.6
    
        --alternateAnswerBox3
        alternateAnswerBox3.y = display.contentHeight * 0.6
        alternateAnswerBox3.x = display.contentWidth * 0.6

        --alternateAnswerBox2
        alternateAnswerBox2.y = display.contentHeight * 0.4
        alternateAnswerBox2.x = display.contentWidth * 0.4
        --alternateAnswerBox1
        alternateAnswerBox1.y = display.contentHeight * 0.6
        alternateAnswerBox1.x = display.contentWidth * 0.4

        --remembering their positions to return the answer in case it's wrong
        alternateAnswerBox1PreviousY = alternateAnswerBox1.y
        alternateAnswerBox2PreviousY = alternateAnswerBox2.y
        alternateAnswerBox3PreviousY = alternateAnswerBox3.y
        answerboxPreviousY = answerbox.y 

     elseif (randomPosition == 4) then
        answerbox.y = display.contentHeight * 0.6
        answerbox.x = display.contentWidth * 0.4
    
        --alternateAnswerBox3
        alternateAnswerBox3.y = display.contentHeight * 0.6
        alternateAnswerBox3.x = display.contentWidth * 0.6

        --alternateAnswerBox2
        alternateAnswerBox2.y = display.contentHeight * 0.4
        alternateAnswerBox2.x = display.contentWidth * 0.4
        --alternateAnswerBox1
        alternateAnswerBox1.y = display.contentHeight * 0.4
        alternateAnswerBox1.x = display.contentWidth * 0.6

        --remembering their positions to return the answer in case it's wrong
        alternateAnswerBox1PreviousY = alternateAnswerBox1.y
        alternateAnswerBox2PreviousY = alternateAnswerBox2.y
        alternateAnswerBox3PreviousY = alternateAnswerBox3.y
        answerboxPreviousY = answerbox.y 
    end
end

--making transition to next scene
local function BackToLevel1() 
    composer.hideOverlay("crossFade", 400 )
    ResumeGame()
end 

function CorrectAnswer()
    if (userAnswer == correctAnswer)then
        timer.performWithDelay(1000, BackToLevel1) 
    end       
end

local function IncorrectAnswer()
        timer.performWithDelay(1000, BackToLevel1) 

    if (userAnswer == alternateAnswer1) or
        (userAnswer == alternateAnswer2) or
        (userAnswer == alternateAnswer3) then
        timer.performWithDelay(1000, BackToLevel1) 
    end
end

local function UpdateTime()

    -- decrement the number of seconds
    secondsLeft = secondsLeft - 1

    -- display the number of seconds left in the clock object
    clockText.text = "Time: ".. secondsLeft  

    if (secondsLeft == 0 ) then
        -- reset the number of seconds left
        secondsLeft = totalSeconds
        IncorrectAnswer()
    end
end


local function TouchListenerAnswerbox(touch)
    --only work if none of the other boxes have been touched
    if (alternateAnswerBox1AlreadyTouched == false) and 
        (alternateAnswerBox2AlreadyTouched == false) and
        (alternateAnswerBox3AlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            answerboxAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            answerbox.x = touch.x
            answerbox.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            answerboxAlreadyTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < answerbox.x ) and
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > answerbox.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < answerbox.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > answerbox.y ) ) then

                -- setting the position of the number to be in the center of the box
                answerbox.x = userAnswerBoxPlaceholder.x
                answerbox.y = userAnswerBoxPlaceholder.y
                userAnswer = correctAnswer

                -- call the function to check if the user's input is correct or not
                CorrectAnswer()
                IncorrectAnswer()

                amountCorrect = amountCorrect + 1
            --else make box go back to where it was
            else
                answerbox.x = answerboxPreviousX
                answerbox.y = answerboxPreviousY
            end
        end
    end                
end 



local function TouchListenerAnswerBox1(touch)
    --only work if none of the other boxes have been touched
    if (answerboxAlreadyTouched == false) and 
        (alternateAnswerBox2AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswerBox1AlreadyTouched = true
            
        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            alternateAnswerBox1.x = touch.x
            alternateAnswerBox1.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswerBox1AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox1.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox1.y ) ) then

                alternateAnswerBox1.x = userAnswerBoxPlaceholder.x
                alternateAnswerBox1.y = userAnswerBoxPlaceholder.y

                userAnswer = alternateAnswer1

                -- call the function to check if the user's input is correct or not
                CorrectAnswer()
                IncorrectAnswer()

            --else make box go back to where it was
            else
                alternateAnswerBox1.x = alternateAnswerBox1PreviousX
                alternateAnswerBox1.y = alternateAnswerBox1PreviousY
            end
        end
    end
end 

local function TouchListenerAnswerBox2(touch)
    --only work if none of the other boxes have been touched
    if (answerboxAlreadyTouched == false) and 
        (alternateAnswerBox1AlreadyTouched == false) and
        (alternateAnswerBox3AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswerBox2AlreadyTouched = true
            
        elseif (touch.phase == "moved") then
            --dragging function
            alternateAnswerBox2.x = touch.x
            alternateAnswerBox2.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswerBox2AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox2.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox2.y ) ) then

                alternateAnswerBox2.x = userAnswerBoxPlaceholder.x
                alternateAnswerBox2.y = userAnswerBoxPlaceholder.y
                userAnswer = alternateAnswer2

                -- call the function to check if the user's input is correct or not
                CorrectAnswer()
                IncorrectAnswer()

            --else make box go back to where it was
            else
                alternateAnswerBox2.x = alternateAnswerBox2PreviousX
                alternateAnswerBox2.y = alternateAnswerBox2PreviousY
            end
        end
    end
end 

local function TouchListenerAnswerBox3(touch)
    --only work if none of the other boxes have been touched
    if (answerboxAlreadyTouched == false) and 
        (alternateAnswerBox1AlreadyTouched == false) and
        (alternateAnswerBox2AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswerBox3AlreadyTouched = true
            
        elseif (touch.phase == "moved") then
            --dragging function
            alternateAnswerBox3.x = touch.x
            alternateAnswerBox3.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswerBox3AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox3.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox3.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox3.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox3.y ) ) then

                alternateAnswerBox3.x = userAnswerBoxPlaceholder.x
                alternateAnswerBox3.y = userAnswerBoxPlaceholder.y
                userAnswer = alternateAnswer3

                -- call the function to check if the user's input is correct or not
                CorrectAnswer()
                IncorrectAnswer()

            --else make box go back to where it was
            else
                alternateAnswerBox3.x = alternateAnswerBox3PreviousX
                alternateAnswerBox3.y = alternateAnswerBox3PreviousY
            end
        end
    end
end 

-- Function that Adds Listeners to each answer box
local function AddAnswerBoxEventListeners()
    answerbox:addEventListener("touch", TouchListenerAnswerbox)
    alternateAnswerBox1:addEventListener("touch", TouchListenerAnswerBox1)
    alternateAnswerBox2:addEventListener("touch", TouchListenerAnswerBox2)
    alternateAnswerBox3:addEventListener("touch", TouchListenerAnswerBox3)
end 

-- Function that Removes Listeners to each answer box
local function RemoveAnswerBoxEventListeners()
    answerbox:removeEventListener("touch", TouchListenerAnswerbox)
    alternateAnswerBox1:removeEventListener("touch", TouchListenerAnswerBox1)
    alternateAnswerBox2:removeEventListener("touch", TouchListenerAnswerBox2)
    alternateAnswerBox3:removeEventListener("touch", TouchListenerAnswerBox3)
end 

-- function that calls the timer
local function StartTimer()
    -- create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

----------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
----------------------------------------------------------------------------------


----------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
----------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    ----------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------
    --Inserting backgroud image and lives
    ----------------------------------------------------------------------------------
    -- the black box where the user will drag the answer
    
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.5)



    -----------------------------------------------------------------------------------------
    --making a cover rectangle to have the background fully bolcked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(96/255, 96/255, 96/255)



    userAnswerBoxPlaceholder = display.newImageRect("Images/Answerbox.png",  130, 130, 0, 0)
    userAnswerBoxPlaceholder.x = display.contentWidth * 0.6
    userAnswerBoxPlaceholder.y = display.contentHeight * 0.8

    --the text that displays the question
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 75)
    questionText:setTextColor(11/255, 255/255, 7/255)
    -- boolean variables stating whether or not the answer was touched
    answerboxAlreadyTouched = false
    alternateAnswerBox1AlreadyTouched = false
    alternateAnswerBox2AlreadyTouched = false
    alternateAnswerBox3AlreadyTouched = false

    --create answerbox alternate answers and the boxes to show them
    answerbox = display.newText("", display.contentWidth * 0.1, 0, nil, 100)
    alternateAnswerBox1 = display.newText("", display.contentWidth * 0.1, 0, nil, 100)
    alternateAnswerBox2 = display.newText("", display.contentWidth * 0.1, 0, nil, 100)
    alternateAnswerBox3 = display.newText("", display.contentWidth * 0.1, 0, nil, 100)

    -- set the x positions of each of the answer boxes
    answerboxPreviousX = display.contentWidth * 0.9
    alternateAnswerBox1PreviousX = display.contentWidth * 0.9
    alternateAnswerBox2PreviousX = display.contentWidth * 0.9
    alternateAnswerBox3PreviousX = display.contentWidth * 0.9

    -- display the timer on the screen
    clockText = display.newText ("", display.contentWidth/3, display.contentHeight*2.5/3, nil, 75)



    correctText = display.newText("Correct!", display.contentWidth/2, display.contentHeight*1.3/3, nil, 50 )
    correctText:setTextColor(100/255, 47/255, 210/255)
    correctText.isVisible = false

    ----------------------------------------------------------------------------------
    --adding objects to the scene group
    ----------------------------------------------------------------------------------
    sceneGroup:insert( bkg )
    sceneGroup:insert( cover )
    sceneGroup:insert( questionText ) 
    sceneGroup:insert( userAnswerBoxPlaceholder )
    sceneGroup:insert( answerbox )
    sceneGroup:insert( alternateAnswerBox1 )
    sceneGroup:insert( alternateAnswerBox2 )
    sceneGroup:insert( alternateAnswerBox3)
    sceneGroup:insert( clockText )



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

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        AddAnswerBoxEventListeners() 
        PositionAnswers()
        DisplayQuestion()
        DetermineAlternateAnswers()
        StartTimer()
        UpdateTime()

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
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
        --parent:resumeGame()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveAnswerBoxEventListeners()
       
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