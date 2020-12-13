.data 
# TODO: What are the following 5 lines doing?
promptA: .asciiz "Enter an int A: "
promptB: .asciiz "Enter an int B: "
promptC: .asciiz "Enter an int C: "
resultAdd: .asciiz "A + B + C = "
newline: .asciiz "\n"

.globl main
.text

main: 


	li $v0, 4		      
	la $a0, promptA
	syscall    
	li $v0, 5
	syscall 
	move $t0, $v0

	li $v0, 4
	la $a0, promptB
	syscall
	li $v0, 5
	syscall 
	move $t1, $v0
	
	li $v0, 4
	la $a0, promptC
	syscall
	li $v0, 5
	syscall 
	move $t2, $v0
		

	# TODO: What if I want to get A + 1 and B + 42 instead
	addi $t3, $t1, 1
	addiu $t3, $t1, -1

	
	li $v0, 4
	la $a0, resultAdd
	syscall

    # TODO: What is the difference between "li" and "move"?
	li $v0, 1
	move $a0, $t4	
	syscall 

    # TODO: Why is the next block of three lines needed? 
    # Remove them and explain what happens.


	li $v0, 4
	la $a0, newline
	syscall 

	li $v0, 10
	syscall
