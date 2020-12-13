.data 
# TODO: What are the following 5 lines doing?
promptN: .asciiz "Enter an positive int N: "
promptRes: .asciiz "Result is: "

newline: .asciiz "\n"
#N: .word 5

.globl main
.text

main: 

Start: # Many loops have an initialization section.

	li $v0, 4		      
	la $a0, promptN
	syscall    
	
	li $v0, 5
	syscall 
	
	move $a0, $v0   # load n into mystery 	
	jal fact 	# Make a function call to mystery()

DONE:
   	li $v0, 4
	la $a0, newline
	syscall 
	
	li $v0, 4
	la $a0, promptRes
	syscall 

	#load result into a0
	move $a0, $v1
	li $v0, 1
	syscall 
   	
	
	li $v0, 10
	syscall

	
fact:
addi $sp, $sp, -8 # adjust stack for 2 items
sw $ra, 4($sp) # save return address
sw $a0, 0($sp) # save argument
slti $t0, $a0, 1 # test for n < 1
beq $t0, $zero, L1
addi $v1, $zero, 1 # if so, result is 1
addi $sp, $sp, 8 # pop 2 items from stack
jr $ra # and return

L1: addi $a0, $a0, -1 # else decrement n
jal fact # recursive call
lw $a0, 0($sp) # restore original n
lw $ra, 4($sp) # and return address
addi $sp, $sp, 8 # pop 2 items from stack
mul $v1, $a0, $v1 # multiply to get result
jr $ra # and return




