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
        li      $t0, 100            # $t0 contains multiplying factor for each place value entered
                                    # 100 for 1, 10 for 2, 1 for 3

        lui     $t9, 0xFFFF         # $t9 = Memory location of the start of the MMIO section(Receiver Control) 
rd_wait:
        lw      $t1, 0($t9)         # Load Receiver Control to $t1
        andi    $t1, $t1, 1         # Clear all bits of Receiver Control besides the LSB
        beqz    $t1, rd_wait         # If not ready(0) restart rd_wait, if ready(1) continue onto calculation
        lw      $t2, 4($t9)         # Read data in Receiver Data to $t2

        sub     $t2, $t2, 48        # Subtract $t2 by 48 to convert from ASCII to int
        mul     $t2, $t2, $t0       # Multiply $t2 by the place value factor in $t0
        div     $t0, $t0, 10        # Divide $t0 to decrease place value factor to the next place
        bne     $t3, 1, rd_wait     # If not on the last place poll for the next digit

        


