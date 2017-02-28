.data
FPNum:  .word 0x0, 0xff800000, 0x7f800000 	# Float-point numbers 0, -Infinity and Infinity

string1:  .asciiz "Input a Float-Point #:(0.0 indicates the end)\n" 
string2:  .asciiz "\nMAX:" 
string3:  .asciiz "\nMIN:"
string4:  .asciiz "\nSUM:"

.text
main:	
		la $t0, FPNum			# load address of FPNUM to $t0
		lwc1 $f10, ($t0) 		# load FP 0x0 to $f10
		lwc1 $f4, ($t0)			# load FP 0x0 to $f4 (SUM)
		lwc1 $f5, 4($t0)		# load FP 0xff800000 to $f5 (MAX)
		lwc1 $f6, 8($t0)		# load FP 0x7f800000 to $f6 (MIN)
				
		addi $s1, $zero, 0		# counter at $s1 is 0
		
		# Input a number 
	InputLoop:
		addi $v0, $zero, 4      	# code for printing strings (4)
      		la $a0, string1 		# load address of string printed to $a0
      		syscall         		# call operating system 
		addi $v0, $zero, 6      	# code for reading FP numbers (6)
   		syscall
		
		# Task #1
		add.s $f1, $f0, $f10		# move input fp number to $f1
		c.eq.s $f1, $f2			# compare if $f1 == $f2 (0)
		bc1t ExitLoop			# if $f1 == $f2, ExitLoop\
		# End Task #1
		
		# Task #2
		c.lt.s $f1, $f6			# compare if $f1 < $f6 (MIN)
		bc1t ChangeMin
		
		c.lt.s $f5, $f1			# compare if $f5 (MAX) < $f1
		bc1t ChangeMax
		
	ChangeMax:
		add.s $f5, $f10, $f1		# $f5 (MAX) == $f1
		add.s $f4, $f4, $f1		# $f4 (SUM) += $f1
		addi $s1, $s1, 1		# counter += 1
		j InputLoop

	ChangeMin:
 		add.s $f6, $f10, $f1		# $f6 (MIN) == $f1
 		add.s $f4, $f4, $f1		# $f4 (SUM) += $f1
	 	addi $s1, $s1, 1
   		j InputLoop
   		# End Task #2

		# Print out the values of MAX, MIN, and SUM			
	ExitLoop:
		addi $v0, $zero, 4
      		la $a0, string2
      		syscall
		addi $v0, $zero, 2      	# code for printing FP numbers (2)
		add.s $f12, $f5, $f10
   		syscall
   		
 		addi $v0, $zero, 4
      		la $a0, string3
      		syscall
		addi $v0, $zero, 2
		add.s $f12, $f6, $f10
   		syscall
 
   		addi $v0, $zero, 4
      		la $a0, string4
      		syscall
		addi $v0, $zero, 2
		add.s $f12, $f4, $f10
   		syscall
  			  		
		addi $v0, $zero, 10
		syscall
