#####################################################################
#
# CSCB58 Fall 2020 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Name, Student Number
# Junheng Wang, 1006390031
# Bitmap Display Configuration:
# - Unit width in pixels: 16					     
# - Unit height in pixels: 16
# - Display width in pixels: 512
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4/5 (choose the one the applies)
# Milestone 5
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
#  I completed parts: a,b,c,d,f,g, with fireball
# Realistic physics: Less / more blocks Speed up / slow down jump rate
# More platform types: Moving blocks “Fragile" blocks (broken when jumped upon) Other types, distinguished by different colours 
#Boosting / power-ups: Rocket suit Springs 
#Fancier graphics: Make it nicer than the demo 
#Two Doodles Separate keyboard inputs to control different entities 
#Opponents / lethal creatures, 
#added fireball that can hit the opponent
#and make it disappear
#
# ... (add more if necessary)
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). 
#
#https://www.youtube.com/watch?v=hEUhQSrUyhU
# Any additional information that the TA needs to know:
#
# - (write here, if any)
#
#####################################################################

#todo:
#make s be restart for the game, X
#update score to screen
#random colors
#make a gamespeed, changing it X

#more platforms

#ascii values, deci, hex
#j 106, 0x6A
#k 107, 0x6B
#s 115, 0x73
#space is 0x20
#rfdg
# 0x72, 0x66, 0x64, 0x67
#one doodler is controlled by wasd keys, and can be a lethal object.

# make graphics nicer, more than 1 pixel, even platforms, 

.data
#blockArray:   .space 400 
blockArray:  .word   0:12
numBlocks: .word 12
lostMessage: .asciiz "YOU LOST | S TO RESTART | SCORE: "
winMessage: .asciiz "YOU WIN | S TO RESTART | SCORE: "
personPosition: .word 0
score: 		.word 0
displayAddress:	.word	0x10008000
screenWidth: 	.word 32
screenHeight: 	.word 32

sleepTime:	.word 1000
rocketX: .word 23
rocketY: .word 23
rocketColor: .word 0xFFD700  
bugX: .word 10
bugY: .word 10
bugColor: .word 0x3A5F0B #green

movingX: .word 10
movingY: .word 15

#checks whether the bomb is pressed
bombSet: .word 0

bombX: .word 0
bombY: .word 0
bombLocation: .word 0
#allows character to shoot
# boolean, 0 or 1, 0 means draw doodler down, 1 means up
jumpOrDrop: .word 0

fragileX: .word 25
fragileY: .word 23
#fragileColor: .word 0xf547c3
#fragileColor: .word 0x00ffff
fragileColor: .word 0x46473E #0xFFD700
springX: .word 17
springY: .word 25
springColor: .word 0xF0E68C

doodleX: .word 20
doodleY: .word 25
#doodle2Color: .word 0x0bff01
doodle2X: .word 3
doodle2Y: .word 4
personPosition2: .word 0

blockWidth: .word 10


#Colors
personColor: 	 .word	0xEABD9D	 # 
backgroundColor: .word	0xadd8e6	 # 
hairColor: .word 0x594444

hairColor2: .word 0xB89778
blockColor:    .word	0x9b7653	 # 	
#springColor: 	.word	0xcc6611	 # orange

.text

initializeArray:
    li  $s0, 0      #Load immediate value 0 into i
    lw $t4, numBlocks        #upper limit
    la $s1,blockArray       #address of start of A


    #Begin for loop:
    #for(i=0; i<5; i++){ A[i] = B[i] - 1; }
FOR_LOOP:  
#generate random x position between 1 and 6, multiply by 5
#generate random y position between 0 and 6, multiply by 5
#make y position multiply y position by 5
    bge     $s0, $t4, END_FOR 
     li $v0, 42
  li $a0, 4
  li $a1, 20
  syscall
  mul $a0, $a0, 50
    sw $a0,($s1)              
    addi $s1, $s1,4           
    addi    $s0, $s0, 1       
    j FOR_LOOP                
END_FOR:                     

	#lw $t0, displayAddress	# $t0 stores the base address for display
	lw $t1, blockColor
	lw $t3, personColor

	#sw $t3, 128($t0) # paint the first unit on the second row blue. Why +128?

lw $t4, doodleX
lw $t5, doodleY
lw $s4, score
lw $s2, numBlocks


mainLoop:		

drawDoodler:
#inputs: t5, s1, t4, 
	#jal checkCollision
	lw $t7 , hairColor
	lw $t3, personColor
	lw $s1, screenWidth
	lw $t4, doodleX
	lw $t5, doodleY
	#makes the doodler go down
  	addi $t5, $t5, 1
  	#subi $t5, $t5, 1
	sw $t5, doodleY
	
	mul $t6,$s1,$t5
	add $t6, $t6,$t4
	mul $t6, $t6, 4
	add $t6,$t6, $gp
	#check the thing 
	#load the original color into a register before updating the color
#ifLabel:
#stores the position of the doodler to the actual memory
	#position of the foot
	sw $t6, personPosition
	#update the constant of the person
	
	sw  $zero,($t6)
	#make position move one up
	subi $t6, $t6, 128
	#position move left
	#subi $s0, $t6, 4
	#draw the positions , left arm
	#sw  $t3,($s0)
	#draw right arm
	addi $s0, $t6, 4	
	sw  $t3,($s0)
	#draw central hair
	li $t7, 0xC80000
	sw $t7, ($t6)

	subi $s0, $t6, 128
	#make chest 
	li $t7, 0xFFEB00
	sw $t7, ($s0)
	
	subi $s0, $t6, 124
	#make shoulder
	li $t7, 0x317499
	sw $t7, ($s0)
	
	subi $s0, $t6, 132
	#make shoulder
	li $t7, 0x317499
	sw $t7, ($s0)
	
	subi $s0, $t6, 256
	
	#make head
	li $t7, 0xE0AC69
	sw $t7, ($s0)
	subi $s0, $t6, 388	
	
	#make upper hand
	#li $t7, 0xE0AC69
	sw $t3, ($s0)	
	subi $s0, $t6, 260	
	#make upper elbow
	li $t7, 0x317499
	sw $t7, ($s0)
	#subi $
	#subtract y position each time
	jal checkDoodle
	jal loadTop
	


	
	
	
drawDoodler2:
	#lw $a3, doodle2Color
	lw $s1, screenWidth
	lw $t4, doodle2X
	lw $t5, doodle2Y
	lw $t7, hairColor2
	lw $t0, personPosition
	mul $t6,$s1,$t5
	add $t6, $t6,$t4
	mul $t6, $t6, 4
	add $t6,$t6, $gp

	sw $t6, personPosition2
	addi $t4, $t0, 128
	
	beq $t6, $t0, Ifp2
   	bne $t4,$t6, Elsep2
   	Ifp2:   
   	j Exit
    	Elsep2:	   
	#update the constant of the person
	sw  $t3,($t6)
subi $t6, $t6, 128
sw $t7, ($t6)
	subi $s0, $t6, 4
	sw  $t3,($s0)
	addi $s0, $t6, 4	
	sw  $t3,($s0)
	
	#draw the chest
	subi $s0, $t6, 128	
	li $t3, 0xA9C53D
	sw  $t3,($s0)
	
	#draw the shoulder
	subi $s0, $t6, 132	
	li $t3, 0xA9C53D
	sw  $t3,($s0)
	
	subi $s0, $t6, 124	
	li $t3, 0xA9C53D
	sw  $t3,($s0)	
	
	#draw the head
	subi $s0, $t6, 256	
	li $t3, 0xDA187B
	sw  $t3,($s0)		
drawBlocks:

PRINT:                        
    li $s0, 0                
    la $s1, blockArray                 
LOOP:
    bge $s0, $s2, drawLowerPlatform         
    lw $a0, ($s1)              	
 	lw $t2, blockWidth
 	mul $a0,$a0, 4
 	add $a0, $a0, $gp
 	jal drawBlock
    addi $s1, $s1, 4          
    addi $s0, $s0, 1          
    b LOOP
    

drawLowerPlatform:	
 	lw $t2, blockWidth
 	li $a0, 1011
 	mul $a0,$a0, 4
 	add $a0, $a0, $gp
 	sw $t1, ($a0)
 	jal drawBlock

drawRocket:
	lw $t5, doodleY
	lw $t0, personPosition
	lw $k0, rocketX
	lw $k1, rocketY
	lw $s1, screenWidth
	#lw $t9, 
	#generates random color stores to a0
	 li $v0, 42
  	li $a0, 0
  	li $a1, 0xffffff
  	syscall 
	
	mul $t2,$k1, $s1
	add $t2, $k0, $t2
	mul $t2, $t2, 4
	add $t2, $t2, $gp
		
	addi $t4, $t0, 128
	beq $t2, $t0, IfRock
   	bne $t4,$t2, ElseRock
   IfRock:   
   	subi $t5, $t5, 30
    	sw $t5, doodleY   
   	#j Exit
    ElseRock:	   
	#draws the rocket
	sw $a0, ($t2)	
	 	
drawObstacle:
	lw $k0, bugX
	lw $k1, bugY
	lw $s1, screenWidth
	lw $t9, bugColor
	lw $t0, personPosition
	addi $k0, $k0, 1
	sw $k0, bugX
	mul $t2,$k1, $s1
	add $t2, $k0, $t2
	mul $t2, $t2, 4
	add $t2, $t2, $gp
	
	addi $t4, $t0, 128
	beq $t2, $t0, IfObst
   	bne $t4,$t2, ElseObst
   IfObst:   
   	j Exit
    ElseObst:	   
    
	sw $t9, ($t2)	
	
drawMovingBlock:
	lw $t5, doodleY
	lw $k0, movingX
	lw $k1, movingY
	lw $s1, screenWidth
	lw $t9, blockColor
	lw $t0, personPosition
	subi $k0, $k0, 1
	sw $k0, movingX
	mul $t2,$k1, $s1
	add $t2, $k0, $t2
	mul $t2, $t2, 4
	add $t2, $t2, $gp
	
	addi $t4, $t0, 128
	beq $t2, $t0, IfMoving
   	bne $t4,$t2, ElseMoving
   IfMoving:   
   	subi $t5, $t5, 10
    	sw $t5, doodleY   
    ElseMoving:	    
	sw $t9, ($t2)	
	
drawFragile:
	lw $k0, fragileX
	lw $k1, fragileY
	lw $s1, screenWidth
	lw $t9, fragileColor
	lw $t5, doodleY
    	lw $t0, personPosition
	mul $t2,$k1, $s1
	add $t2, $k0, $t2
	mul $t2, $t2, 4
	add $t2, $t2, $gp
	addi $t4, $t0, 128
	beq $t2, $t0, IfFragile
   	bne $t4,$t2, ElseFragile
   	IfFragile:   #subi $t5, $t5, 15
    #sw $t5, doodleY   
    li $k1, 100
    sw $k1, fragileY
    ElseFragile:		
	sw $t9, ($t2)	
	#sw $t9, ($t2)	
	
drawSpring:
	lw $t5, doodleY
    	lw $t0, personPosition
	lw $k0, springX
	lw $k1, springY
	lw $s1, screenWidth
	lw $t9, springColor
	mul $t2,$k1, $s1
	add $t2, $k0, $t2
	mul $t2, $t2, 4
	add $t2, $t2, $gp	
	addi $t4, $t0, 128
   beq $t2, $t0, If
   bne $t4,$t2, Else
   If:   subi $t5, $t5, 16
    sw $t5, doodleY   
    Else:		
	sw $t9, ($t2)	
	
bombIsPressed:
	lw $s1, personPosition2
lw $k0, bombSet
#if the bomb is zero, so we did not press, then dont drop the
#bomb and move on
beq $k0,$zero, input

checkBombSet:	

lw $t5, bombLocation
subi $t5, $t5, 128
sw $t5, bombLocation
li $k1, 0xFF4500
sw $k1 , ($t5)

bne $t5, $s1, input
IfHit:
j Win
input:
	lw $t8, 0xffff0000 
	beq $t8, 1, keyboard_input
	j sleep
	#j input
	
keyboard_input:
	lw $t2, 0xffff0004 
	beq $t2, 0x6A, drawLeft
	beq $t2, 0x6B, drawRight
	
#rfdg
# 0x72, 0x66, 0x64, 0x67
	beq $t2, 0x72,doodle2Up
	beq $t2, 0x66,doodle2Down
	beq $t2, 0x64,doodle2Left
	beq $t2, 0x67,doodle2Right
	beq $t2, 0x20, drawBomb
	
	j sleep
	#j keyboard_input
drawBomb:
	li $s1,1
	sw $s1, bombSet
	lw $s1, doodleX
	lw $t4, doodleY
	lw $t5, personPosition
	subi $t5, $t5, 256
	sw $s1, bombX
	sw $t4, bombY
	sw $t5, bombLocation
	j sleep
	
	
drawLeft:
	lw $t4, doodleX
	addi $t4, $t4, -1
	sw $t4, doodleX
	j sleep
drawRight:
	lw $t4, doodleX
	addi $t4, $t4, 1
	sw $t4, doodleX
	j sleep
doodle2Up:	
	lw $t4, doodle2Y
	addi $t4, $t4, -1
	sw $t4, doodle2Y
		j sleep
doodle2Down:
lw $t4, doodle2Y
addi $t4, $t4, 1
	sw $t4, doodle2Y
		j sleep
doodle2Left:
lw $t4, doodle2X
addi $t4, $t4, -1
	sw $t4, doodle2X
		j sleep
doodle2Right:
lw $t4, doodle2X
addi $t4, $t4, 1
	sw $t4, doodle2X
		j sleep


sleep:
	lw $a0, sleepTime
	addi $s4, $s4, 1
	sw $s4, score 
	#we want to see if we can add speed

	 bne $s4, 10, continue1
	#if the score is greater than a threshhold,
	# make the sleep time shorter
	li $t0, 500
	sw $t0, sleepTime
	#wait
	continue1:	
	bne $s4, 30, continue2
	li $t0, 250
	sw $t0, sleepTime
	continue2:
	
	li $v0, 32
	#1000 ms is 1 sec
	
 	#li $a0, 1000
	syscall

setScreen:
	lw $a0, screenWidth
	lw $a1, backgroundColor
	mul $a2, $a0, $a0 #screen area
	mul $a2, $a2, 4 #shift 4
	add $a2, $a2, $gp #add to base
	add $a0, $gp, $zero #loop counter
	
redrawScreen:
	beq $a0, $a2, drawDoodler #once loop counter reaches the area of the screen
	sw $a1, 0($a0) #paint color to the location of counter
	addiu $a0, $a0, 4 #increment counter
	#addi $t5, $t5, 1
	j redrawScreen
	
j mainLoop  	
	
loadTop:
lw $t5, doodleY
lw $t4, numBlocks
checkTop:
bge $t5, 0 , ElseNoJump
#subtract number of blocks up to 4,
# each time doodler reaches top
ble $t4, 4 , doodlerUp
subi $t4, $t4, 1
sw $t4, numBlocks
doodlerUp:
	#lw $t5, doodleY
	li $t5, 26
	#addi $t5, $t5, 5
	sw $t5, doodleY 
	j initializeArray
ElseNoJump:
jr $ra

#doodlerRedraw:
#	lw $t4, doodleX
#	lw $t5, doodleY
#	jr $ra
	
drawBlock:
#t2 holds block width, 	a0 is block location
#check if we are drawing on a person, or person's y + 1.
    lw $t0, personPosition
   # lw $t4, doodleX
	lw $t5, doodleY
    subi $t2, $t2, 1
    mul $t3, $t2, 4
    add $t3, $a0, $t3
    addi $t4, $t0, 128
   beq $t3, $t0, IfSpring
   bne $t4,$t3, ElseSpring
   IfSpring:   subi $t5, $t5, 10
    sw $t5, doodleY   
    ElseSpring:	
    sw $t1, ($t3)     # paint the  unit red. 
    bne $t2, $zero, drawBlock
    
jr $ra	

checkDoodle:
lw $t5, doodleY

checkEnd:
beq $t5, 32 , Exit
jr $ra

Exit:
	li $v0, 56 #syscall value for dialog
	la $a0, lostMessage #get message
	lw $a1, score	#get score
	syscall
	

restartInput:	
	lw $t8, 0xffff0000 
	beq $t8, 1, end_input
	#sleep 
	j restartInput
end_input:
	lw $t2, 0xffff0004 
	beq $t2, 0x73, drawRestart
	#sleep
	j end_input
drawRestart:
lw $t4, doodleX
lw $t5, doodleY
li $t4, 20
li $t5, 25
sw $t5, doodleY
sw $t4, doodleX

lw $t4, doodle2X
lw $t5, doodle2Y
li $t4, 5
li $t5, 5
sw $t5, doodle2Y
sw $t4, doodle2X
j drawDoodler

	#jr $ra
	
	li $v0, 10 # terminate the program gracefully
	syscall
	
Win:
	li $v0, 56 #syscall value for dialog
	la $a0, winMessage #get message
	lw $a1, score	#get score
	syscall	
	j restartInput
