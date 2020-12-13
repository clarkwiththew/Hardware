.data 
# TODO: What are the following 5 lines doing?
promptA: .asciiz "Enter an int A: "
resultOdd: .asciiz "THIS IS ODD"
resultEven: .asciiz "THIS IS EVEN"
newline: .asciiz "\n"

.globl main
.text

main: 
    # TODO: Set a breakpoint here and step through. 
    # What does this block of 3 lines do?
	li $v0, 4		      
	la $a0, promptA
	syscall    

    # TODO: Set a breakpoint here and step through. 
    # What does this block of 3 lines do?
	li $v0, 5
	syscall 
	move $t0, $v0
		
	andi $t1, $t0, 1
	
	IF: # This label isn’t required but is added for clarity.	
		addi $t2, $t2, 0 # Prepare to evaluate x - 4 <= 0.
		beq $t1,$t2, ELSE # branch to else if even
	THEN: # This label isn’t required but is added for clarity.
		li $v0, 4
		la $a0, resultOdd
		syscall	
		j DONE
	ELSE:
		li $v0, 4
		la $a0, resultEven
		syscall
	DONE: # This label marks the end of the If-Else.
	
	li $v0, 4
	la $a0, newline
	syscall 

	li $v0, 10
	syscall


