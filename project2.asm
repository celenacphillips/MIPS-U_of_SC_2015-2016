.data
baseadd:	.word 34, 5, 11, -12, 60, -2, 14, 71, 13, -27

string1:	.asciiz "Index i [0-9]:\n"
string2:	.asciiz "\nMin = "
string3:	.asciiz "\nMax = "

.text
main:
	# read input to $s1
	addi $v0, $zero, 4	# code for printing strings (4)
	la $a0, string1		# load address of string printed to $a0
	syscall			# call operating system

	addi $v0, $zero, 5	# code for reading integers (5)
	syscall
	add $s1, $v0, $zero	# index is in $s1


	la $s5, baseadd		# 'baseadd' in $s5
	lw $s7, ($s5)		# initialize $s7 to A[0]
	add $s5, $s5, 4		# start at A[1]
	add $t0, $zero, 1	# counter = 1
	add $t1, $s1, 1		# $t1 = index + 1


	loopMax:
		lw $t2, ($s5)		# A[i]
		bge $s7, $t2, loopMax1	# if $s7 is greater than $t2, loopMax1
		beq $t0, $t1, loopMin	# if counter = index + 1, loopMin
		move $s7, $t2		# set max to element

	loopMax1:
		add $t0, $t0, 1		# counter += 1
		addi $s5, $s5, 4	# array pointer advanced
		bne $t0, $t1, loopMax	# if counter != index + 1, loopMax


	la $s5, baseadd		# reset array position to 0
	lw $s6, ($s5)		# initialize $s6 to A[0]
	add $s5, $s5, 4		# reset to A[1]
	add $t0, $zero, 1	# reset counter to 1
	add $t1, $s1, 1		# reset $t1 to index +1


	loopMin:
		lw $t2, ($s5)
		bge $t2, $s6, loopMin1	# if $t2 is greater than $s6, loopMin1
		beq $t0, $t1, Exit	# if counter = index + 1, Exit
		move $s6, $t2		# set min element

	loopMin1:
		add $t0, $t0, 1
		addi $s5, $s5, 4
		bne $t0, $t1, loopMin	# if counter != index + 1, loopMin


	Exit:
		addi $v0, $zero, 4
		la $a0, string2
		syscall

		add $a0, $s6, $zero
		addi $v0, $zero, 1	# print integer
		syscall


		addi $v0, $zero, 4
		la $a0, string3
		syscall

		add $a0, $s7, $zero
		addi $v0, $zero, 1
		syscall

	# exit
	addi $v0, $zero, 10
	syscall
