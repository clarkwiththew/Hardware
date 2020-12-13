.data
array1: .space 100
size: .word 4

newline: .asciiz "\n"
.text

move $s3, $zero # set counter for # of elems printed
move $s4, $zero # set offset from Array
lw $t0, array1
lw $s2, size
storeArray:
	beq $s2,$s3, main
 	li $v0, 42
 	li $a0, 1
 	li $a1, 1000
 	syscall	
 	add $t0, $t0, $s4
 	sw $a0,($t0)
	addi $s4, $s4, 4
	addi $s3, $s3 1
j storeArray

main:
#load 1 into t1 to be multiplied
li $t1,1
lw $t2, size # get size of list
move $t3, $zero # set counter for # of elems printed
move $t4, $zero # set offset from Array

loop:
bge $t3, $t2, end # stop after last elem is printed
lw $t0, array1($t4) # load new value
mul $t1, $t1, $t0 # multiply value
addi $t3, $t3, 1 # increment the loop counter
addi $t4, $t4, 4 # step to the next array elem
j loop # repeat the loop

end:
	#prints new line
	li $v0, 4
	la $a0, newline
	syscall 
   	#prints multiplied integer
	li $v0, 1
	move $a0, $t1
	syscall 
	#exits
	li $v0, 10
	syscall
