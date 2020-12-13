# func1.s
.data
before: .asciiz "Before function\n"
promptA: .asciiz "Enter value for A: "
promptB: .asciiz "Enter value for B: "
resAdd: .asciiz "A + B is: "
resSub: .asciiz "A - B is: "
newline: .asciiz "\n"

.text
main:
	li $v0, 4		  # system call code for print_string
	la $a0, promptA	  # address of string A to print
	syscall			  # print the string

	li $v0, 5		# system call code for read_int
	syscall 		# Read the int
	move $t0, $v0	# Load A into $t0

	li $v0, 4		  # system call code for print_string  
	la $a0, promptB	  # address of string B to print
	syscall    		  # print the string

	li $v0, 5		# system call code for read_int
	syscall 		# Read the int
	move $t1, $v0	# Load B into $t1

	########### End of user input

	li $v0, 4 		# system call code for print_string
	la $a0, before 	# address of string to print
	syscall 		# print the string

	li $v0, 4 		# system call code for print_string
	la $a0, resAdd 	# address of string to print
	syscall 		# print the string

	# TODO: setup the arguments for function call doAdd
	
	move $a0, $t0
	move $a1, $t1		
	jal doAdd 	# Make a function call to doAdd()
	#TODO: what exactly does jal do? Lookup the reference sheet

	# TODO: print the return value of doAdd
	move $a0, $v0 	# address of string to print
	li $v0, 1 	# system call code for print_string

	syscall 	# print the string	
	
	li $v0, 4 	# system call code for print_string
	la $a0, newline # address of string to print
	syscall 	# print the string	

	li $v0, 4 	# system call code for print_string
	la $a0, resSub 	# address of string to print
	syscall 	# print the string

	# TODO: setup the arguments for function call doSub	
	move $a0, $t0
	move $a1, $t1																			
	jal doSub 	# Make a function call to doSub()
	
	# TODO: print the return value of doSub
	move $a0, $v0 
	li $v0, 1 	
	syscall 	# print 
	
	li $v0, 4 	# system call code for print_string
	la $a0, newline # address of string to print
	syscall 	# print the string	
									
	# End of main, make a syscall to "exit"
	li $v0, 10 	# system call code for exit
	syscall 	# terminate program	
	
# start of function doAdd()
doAdd:
	add $v0, $a0, $a1
	# TODO: what need to be done here?
	jr $ra
# start of function doSub()
doSub:
 	sub $v0, $a0, $a1
	# TODO: what need to be done here?
 	jr $ra