#
# MMIO_Lab2.asm
# Daniel Chapin
# 12/03/21
# Read two digits input by the user and convert ascii characters to a decimal value
#

	.text
	.globl	main
main:
	li	$t9, 2			# $t9 Set to number of digits to be read
	lui	$t0, 0xFFFF
	
rd_wait:
	lw	$t1, 0($t0)		# load input control register
	andi	$t1, $t1, 0x0001	# clear all bits besides least significant bit
	beqz	$t1, rd_wait		# if not ready(0) restart loop, if ready(1) continue
	lw	$s0, 4($t0)		# read from input device
	
	sub	$s0, $s0, 48		# $s0 -= 48 Convert from ASCII to decimal
	sub	$t9, $t9, 1		# decrement digit count
	bnez	$t9, m_start		# branch to m_start if not the last digit
	b	dg_add			# branch to dig_add if the last digit

m_start:
	or	$t8, $t9, $zero		# $t8 = $t9
pl_mu:	
	mul	$s0, $s0, 10		# Multiply decimal value of first digit by 10
	sub	$t8, $t8, 1
	bnez	$t8, pl_mu		# retiterate pl_mu unless $t8 = 0

dg_add:
	add	$s1, $s1, $s0		# Add digit value to $s1
	bnez	$t9, rd_wait		# branch to rd_wait if not the last digit
	
print:
	or	$a0, $s1, $zero		# Set $a0 to $s1
	li	$v0, 1			# System call code to print integer
	syscall
	
	li	$v0, 10			# exit
	syscall
