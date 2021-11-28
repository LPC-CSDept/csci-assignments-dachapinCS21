#
# Quiz5_pt3.asm
# Daniel Chapin CS21
# 11/25/21
# Quiz 5 part 3
# Calculate square root of user input value(n) using Newton's method
#

	.data
nprmpt:	.asciiz	"Enter a value for n: "		# n prompt
omsg:	.asciiz	"The square root of n is " 	# output message

	.text
	.globl	main
main:
	la	$a0, nprmpt	# Load nprmpt as argument 	
	li	$v0, 4		# System Service code to print string
	syscall			# Print nprmpt
	
	li	$v0, 6		# System Service code to read float
	syscall			# Read float, $f0 = n
	
	li.s	$f1, 1.0	# Starting x value, $f1 = 1.0
	li.s	$f2, 2.0	# 2.0 for alogrithm
	li.s	$f10, 1.0e-5	# Accuracy limit
	
loop:
	div.s	$f3, $f0, $f1	# $f3 = n/x
	add.s	$f3, $f3, $f1	# $f3 = x + n/x
	div.s	$f4, $f3, $f2	# $f4 = (x + n/x)/2
	
	sub.s 	$f1, $f4, $f1	# $f1 = x' - x
	abs.s	$f1, $f1	# $f1 = x' - x|
	
	c.lt.s	$f1, $f10	# Flag if |x' - x| is less than accuracy limit
	bc1t	finish		# finish if flagged
	nop
	
	mov.s	$f1, $f4	# $f1 = x' for next iteration
	j 	loop		# Restart loop
	nop	

finish:
	mov.s	$f12, $f4	# Copy $f4 to $f12 for output
	
	la	$a0, omsg	# Load omsg as argument 
	li	$v0, 4		# System Service code to print string
	syscall			# Print omsg
	
	li	$v0, 2		# System Service code to print float
	syscall			# Print expression value
	
	li	$v0, 10		# System Service code to exit
	syscall			# Exit
	