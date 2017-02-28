.data
OddArray:  .space 100
EvenArray: .space 100

string1:  .asciiz "Input a Number [99999 to end input]:\n" 
string2:  .asciiz "\nOdd #'s:" 
string3:  .asciiz "\nEven #'s:" 
string4:  .asciiz ", "

.text
main:
	addi $s2, $zero, 99999		# loop ender
	addi $s3, $zero, 0		# odd counter = 0
	addi $s4, $zero, 0		# even counter = 0
	la $s5, OddArray		# 'OddArray' in $s5
	la $s6, EvenArray		# 'EvenArray' in $s6


	InputLoop:
		addi $v0, $zero, 4      	# code for printing strings (4)
      		la $a0, string1 		# load address of string to be printed $a0    
      		syscall         		# call operating system 
		addi $v0, $zero, 5      	# code for reading integers (5)
   		syscall
   		add $s1, $v0, $zero  		# input is in $s1
   		
   		beq $s1, $s2, ExitLoop  	# if input equals loop ender
   			
 		andi $t0, $s1, 1		# ands $s1 and 1, adding it to $t0
   		beq  $t0, $zero, EvenLoop	# if $t0 equals 0, branch to EvenLoop


	OddLoop:
   		sll $t0, $s3, 2			# shifts odd counter by 2 bits, adding it to $t0
   		add $t1, $s5, $t0		# adds 'OddArray' and $t0, saves it to $t1
   		sw $s1, 0($t1)			# stores $s1 at the beginning of $t1
   		addi $s3, $s3, 1		# odd counter += 1
   		j InputLoop			# jump to InputLoop


	EvenLoop:
	   	sll $t0, $s4, 2			# shifts even counter by 2 bits, adding it to $t0
		add $t1, $s6, $t0		# adds 'EvenArray' and $t0, saves it to St1
		sw $s1, 0($t1)			# stores $s1 at the beginning of $t1
		addi $s4, $s4, 1		# even counter += 1
		j InputLoop


	ExitLoop:
		addi $v0, $zero, 4
      		la $a0, string2
      		syscall 


	OddOut:
		lw $t0, 0($s5)			# load OA[i] to $t0
		li $v0, 1			# $v0 = 1
		move $a0, $t0			# move $t0 to $a0
		syscall

		addi $v0, $zero, 4
		la $a0, string4
		syscall

		addi $s3, $s3, -1		# odd counter -= 1
		addi $s5, $s5, 4		# odd array pointer advanced
		bne $s3, $zero, OddOut		# if odd counter != 0, loop back

		addi $v0, $zero, 4
      		la $a0, string3
      		syscall


	EvenOut:
		lw $t0, 0($s6)			# load EA[i] to $t0
		li $v0, 1
		move $a0, $t0
		syscall

		addi $v0, $zero, 4
		la $a0, string4
		syscall

		addi $s4, $s4, -1		# even counter -= 1
		addi $s6, $s6, 4		# even array pointer advanced
		bne $s4, $zero, EvenOut		# if even counter != 0, loop back


	# exit	
	addi $v0, $zero, 10
	syscall
