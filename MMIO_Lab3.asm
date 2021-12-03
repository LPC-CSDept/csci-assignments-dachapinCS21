#
# MMIO_Lab3.asm
# Daniel Chapin
# 12/03/21
# Ouput int value to console using MMIO
#

	.text
	.globl	main
main:
	li	$t0, 42		# Value to be output
	or	$t1, $t0, $zero		# Set $t2 = $t0

dig_count:
	add	$t2, $t2, 1		# increment digit count($t1)
	div	$t1, $t1, 10		# $t2 /= 10
	bnez	$t1, dig_count		# reiterate dig_count if $t2 does not equal 0
	
hndl_dig:
	or	$t1, $t0, $zero		# Reset $t1 to $t0
	or	$t3, $t2, $zero		# Reset $t3 to $t2
get_dig:
	sub	$t3, $t3, 1		# decrement digit count
	beqz	$t3, convert		# branch to convert if least significant digit
	div	$t1, $t1, 10		# divide by ten
	bgt	$t3, 1, get_dig		# reiterate over get_dig if digit needed is not the least significant digit
	
convert:
	rem	$v0, $t1, 10		# $v0 = $t1 % 10
	add	$v0, $v0, 48		# $v0 += 48(Convert digit to ascii)
	
	lui	$t9, 0xFFFF
wr_wait:
	lw	$t4, 8($t9)		# load output control register
	andi	$t4, $t4, 0x0001	# clear all bits besides least significant bit
	beqz	$t4, wr_wait		# if not ready(0) restart loop, if ready(1) continue
	sw	$v0, 12($t9)		# write to output
	
	sub	$t2, $t2, 1		# decrement digit count 
	bnez	$t2, hndl_dig		# if not the last digit branch to hndl_dig to handle the next digit
	
	li	$v0, 10			# exit
	syscall