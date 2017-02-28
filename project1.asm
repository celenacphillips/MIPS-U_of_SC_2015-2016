.data
baseadd:	.word 34, 5, 11, -12, 60, -2, 14, 71, 13, -27

string1:	.asciiz "Index i [0-9]:\n"
string2:	.asciiz "Index j [0-9]:\n"
string3:	.asciiz "\nA[i] = "
string4:	.asciiz "\nA[j] = "
string5:	.asciiz "\nA[i] + A[j] = "
string6:	.asciiz "\nA[i] - A[j] = "

.text
main:
		# read input 'i' to $s1
		addi $v0, $zero, 4	# code for printing strings (4)
		la $a0, string1		# load address of string printed to $a0
		syscall			# call operating system

		addi $v0, $zero, 5	# code for reading integers (5)
		syscall
		add $s1, $v0, $zero	# 'i' in $s1


		# read input 'j' to $s2
		addi $v0, $zero, 4
		la $a0, string2
		syscall

		addi $v0, $zero, 5
		syscall
		add $s2, $v0, $zero	# 'j' in $s2


		la $s5, baseadd		# 'baseadd' in $s5
		li $t1, 0		# 'i' counter = 0


		# get integer at index 'i'
		loopI:
			beq $t1, $s1, loopI_end	# if array pointer is at index 'i,' end
			#else
			addi $t1, $t1, 1	# set 'i' counter +1
			addi $s5, $s5, 4	# set array pointer +1

			j loopI			# restart loop
		loopI_end:
			lw $s3, ($s5)		# load integer to $s3


		# print A[i]
		addi $v0, $zero, 4
		la $a0, string3
		syscall

		add $a0, $s3, $zero
		addi $v0, $zero, 1	# print integer
		syscall


		la $s5, baseadd		# resets array position to 0
		li $t2, 0		# 'j' counter = 0


		# get integer at index 'j'
		loopJ:
			beq $t2, $s2, loopJ_end	# if array pointer is at index 'j,' end
			#else
			addi $t2, $t2, 1	# set 'j' counter +1
			addi $s5, $s5, 4	# set array pointer +1

			j loopJ			# restart loop
		loopJ_end:
			lw $s4, ($s5)		# load integer to $s4


		# print A[j]
		addi $v0, $zero, 4
		la $a0, string4
		syscall

		add $a0, $s4, $zero
		addi $v0, $zero, 1
		syscall


		# compute and print A[i] + A[j]
		addi $v0, $zero, 4
		la $a0, string5
		syscall

		add $a0, $s3, $s4	# A[i] + A[j]
		addi $v0, $zero, 1
		syscall


		# compute and print A[i] - A[j]
		addi $v0, $zero, 4
		la $a0, string5
		syscall

		sub $a0, $s3, $s4	# A[i] - A[j]
		addi $v0, $zero, 1
		syscall


		# exit
		addi $v0, $zero, 10
		syscall
