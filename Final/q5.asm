#
# q5.asm
# Daniel Chapin
# 12/10/21
# CS21 Final Q5
# Read 3 digits using MM I/O. Create int with corresponding value and print value using syscall.
#

    .text
    .globl  main
main:
    li  $t0, 100        # $t0 contains multiplying factor for each place value entered
                        # 100 for 1, 10 for 2, 1 for 3

    lui $t9, 0xFFFF     # $t9 = Memory location of the start of the MMIO section(Receiver Control) 
