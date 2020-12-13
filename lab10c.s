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
	
	move $a1, $v0   # load n into mystery 	
	jal mystery 	# Make a function call to mystery()

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

	
mystery:
addi $sp, $sp, -8 # adjust stack for 2 items
sw $ra, 4($sp) # save return address
sw $a1, 0($sp) # save argument

bne $a1, $zero, recurse# test for n = 0
#if n is zero
#return zero

addi $sp, $sp, 8 # pop 2 items from stack
li $v1, 0 
jr $ra # and return
#recursive function
recurse: 
addi $a1, $a1, -1 # else decrement n
jal mystery # recursive call
lw $a1, 0($sp) # restore original n
lw $ra, 4($sp) # and return address
addi $sp, $sp, 8 # pop 2 items from stack
add $t1, $a1, $a1 #calculate the value of 2n-1
subi $t1, $t1, 1 #calculate the value of 2n-1
#calculate final value
add $v1,$t1,$v1
jr $ra # and return




