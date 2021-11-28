#
# Quiz5_pt2.asm
# Daniel Chapin CS21
# 11/25/21
# Quiz 5 part 2
# Calculate expression ax² + bx + c using values input by the user
#

	.data
xprmpt:	.asciiz	"Enter a value for x: "	# x prompt
aprmpt:	.asciiz	"Enter a value for a: "	# a prompt
bprmpt:	.asciiz	"Enter a value for b: "	# b prompt
cprmpt:	.asciiz	"Enter a value for c: "	# c prompt
omsg:	.asciiz	"ax² + bx + c = "	# output message

	.text
	.globl	main
main:
	la	$a0, xprmpt	# Load xprmpt as argument 	
	li	$v0, 4		# System Service code to print string
	syscall			# Print xprmpt
	
	li	$v0, 6		# System Service code to read float
	syscall			# Read float
	
	mov.s	$f3, $f0	# Copy $f0 to $f3, $f3 = x
	
	la	$a0, aprmpt	# Load aprmpt as argument 	
	li	$v0, 4		# System Service code to print string
	syscall			# Print aprmpt
	
	li	$v0, 6		# System Service code to read float
	syscall			# Read float
	
	mov.s	$f2, $f0	# Copy $f0 to $f2,  $f2 = a
	
	la	$a0, bprmpt	# Load bprmpt as argument 	
	li	$v0, 4		# System Service code to print string
	syscall			# Print bprmpt
	
	li	$v0, 6		# System Service code to read float
	syscall			# Read float
	
	mov.s	$f1, $f0	# Copy $f0 to $f1,  $f1 = b
	
	la	$a0, cprmpt	# Load cprmpt as argument 	
	li	$v0, 4		# System Service code to print string
	syscall			# Print cprmpt
	
	li	$v0, 6		# System Service code to read float
	syscall			# Read float, $f0 = c
	
	mul.s	$f2, $f2, $f3	# $f2 = ax
	mul.s	$f2, $f2, $f3	# $f2 = ax^2
	mul.s	$f1, $f1, $f3	# $f1 = bx
	add.s	$f2, $f2, $f0	# $f2 = ax^2 + c
	add.s	$f12, $f2, $f1 	# $f12 = ax^2 + bx + c
	
	la	$a0, omsg	# Load omsg as argument 
	li	$v0, 4		# System Service code to print string
	syscall			# Print omsg
	
	li	$v0, 2		# System Service code to print float
	syscall			# Print expression value
	
	li	$v0, 10		# System Service code to exit
	syscall			# Exit