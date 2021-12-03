#
# MMIO_Lab4.asm
# Daniel Chapin
# 12/03/21
# Take input of user and print until the user inputs a 'q'
#

	.text
	.globl	main
main:
	li	$s0, 113		# ASCII code for 'q'
	lui	$t0, 0xFFFF
	
rd_wait:
	lw	$t1, 0($t0)		# load input control register
	andi	$t1, $t1, 0x0001	# clear all bits besides least significant bit
	beqz	$t1, rd_wait		# if not ready(0) restart loop, if ready(1) continue
	lw	$v0, 4($t0)		# read from input device
	
wr_wait:
	lw	$t1, 8($t0)		# load output control register
	andi	$t1, $t1, 0x0001	# clear all bits besides least significant bit
	beqz	$t1, wr_wait		# if not ready(0) restart loop, if ready(1) continue
	sw	$v0, 12($t0)		# write to output
	
	bne	$v0, $s0, rd_wait	# branch to rd_wait if $v0 != $s0(113)
	
	li	$v0, 10			# exit
	syscall