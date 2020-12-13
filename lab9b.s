.data 
# TODO: What are the following 5 lines doing?
promptA: .asciiz "Enter an int A: "
resultOdd: .asciiz "THIS IS ODD"
resultTooMany: .asciiz "TOO MANY TIMES"
newline: .asciiz "\n"
n: .word 5

.globl main
.text

main: 

LOOPINIT: # Many loops have an initialization section.
#li $t0, 0

	li $v0, 4		      
	la $a0, promptA
	syscall    
	
	li $v0, 5
	syscall 
	move $t0, $v0
	
	andi $t1, $t0, 1
WHILE: # The loop checks the condition, then evaluates the body.
	addi $t2, $t2, 0  # Prepare to evaluate x - 4 <= 0.
	beq $t1,$t2, DONE # branch to else if even

	li $v0, 4		      
	la $a0, promptA
	syscall
	
	li $v0, 5
	syscall 
	move $t0, $v0
	
	andi $t1, $t0, 1        
j WHILE
DONE:
   	
	li $v0, 4
	la $a0, newline
	syscall 

	li $v0, 10
	syscall


