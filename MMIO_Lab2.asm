#
# MMIO_Lab2.asm
# Daniel Chapin
# 12/03/21
# Read two digits input by the user and convert ascii characters to a decimal value
#

	.text
	.globl	main
main:
	li	$t9, 2			# $t9 = 2 digits count
	lui	$t0, 0xFFFF
	
rd_wait:
	lw	$t1, 0($t0)		# load input control register
	andi	$t1, $t1, 0x0001	# clear all bits besides least significant bit
	beqz	$t1, rd_wait		# if not ready(0) restart loop, if ready(1) continue
	lw	$s0, 4($t0)		# read from input device
	
	sub	$s0, $s0, 48		# $s0 = $v0 - 48 (ASCII code conversion to decimal)
	sub	$t9, $t9, 1		# decrement digit count
	beqz	$t9, print		# move to print if last digit input
	
	mul	$s1, $s0, 10		# Multiply decimal value of first digit by 10
	b	rd_wait			# Return to the start of the loop
	
	
	
print:
	add	$a0, $s1, $s0		# Add both digit values together
	li	$v0, 1			# System call code to print integer
	syscall
	
	li	$v0, 10			# exit
	syscall