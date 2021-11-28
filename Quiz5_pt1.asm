#
# Quiz5_pt1.asm
# Daniel Chapin CS21
# 11/25/21
# Quiz 5 part 1
# Convert user input Fahrenheit value to Celsius
#

	.data
iprmpt:	.asciiz	"Enter a Fahrenheit value to convert to Celsius: "	# input prompt
omsg:	.asciiz	"The value converted to Celsius is "			# output message

	.text
	.globl	main
main:
	la	$a0, iprmpt	# Load iprmpt as argument 
	li	$v0, 4		# System Service code to print string
	syscall			# Print iprmpt
	
	li	$v0, 5		# System Service code to read int
	syscall			# Read int
	
	mtc1	$v0, $f0	# Copy input int to $f0
	cvt.s.w	$f0, $f0	# Convert $f0 int to float
	
	li.s	$f1, 32.0	# 32.0 for conversion formula
	li.s	$f2, 5.0	# 5.0 for conversion formula
	li.s 	$f3, 9.0	# 9.0 for conversion formula
	
	sub.s	$f0, $f0, $f1	# $f0 = input - 32.0
	mul.s	$f0, $f0, $f2	# $f0 = (input - 32) x 5
	div.s	$f12, $f0, $f3	# $f12 = (input - 32) x 5 / 9
	
	la	$a0, omsg	# Load omsg as argument 
	li	$v0, 4		# System Service code to print string
	syscall			# Print omsg
	
	li	$v0, 2		# System Service code to print float
	syscall			# Print converted float value
	
	li	$v0, 10		# System Service code to exit
	syscall			# Exit