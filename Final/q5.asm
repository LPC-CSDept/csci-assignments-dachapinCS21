#
# q5.asm
# Daniel Chapin
# 12/10/21
# CS21 Final Q5
# Read 3 digits using MM I/O. Create int with corresponding value and print value using syscall.
# If interested for MMIO_Lab2.asm I made a program that can take in any number of digits and output as int
#

        .text
        .globl  main
main:
        li      $t0, 100            # $t0 contains multiplying factor for each place value entered
                                    # 100 for 1, 10 for 2, 1 for 3

        lui     $t9, 0xFFFF         # $t9 = Memory location of the start of the MMIO section(Receiver Control) 
rd_wait:
        lw      $t1, 0($t9)         # Load Receiver Control to $t1
        andi    $t1, $t1, 1         # Clear all bits of Receiver Control besides the LSB(Ready Bit)
        beqz    $t1, rd_wait        # If not ready(0) restart rd_wait, if ready(1) continue onto calculation
        lw      $t2, 4($t9)         # Read data from Receiver Data to $t2

        sub     $t2, $t2, 48        # Subtract $t2 by 48 to convert from ASCII to int(Example: '1' = 49 - 48 = 1)
        mul     $t2, $t2, $t0       # Multiply $t2 by the place value factor in $t0(9 * 100 = 900, 5 * 10 = 50, 3 * 1 = 3)
        div     $t0, $t0, 10        # Divide $t0 to decrease place value factor to the next place(100/10 = 10, 10/10 = 1, 1/10 = 0)

        add     $t3, $t3, $t2       # Add current digits value to $t3(900 + 50 + 3)
        bnez    $t0, rd_wait        # If not on the last place(0) poll for the next digit

print:
        or      $a0, $t3, $zero     # Copy $t0 to $a0
        li      $v0, 1              # System call code to print int
        syscall

        li      $v0, 10             # System call code to exit
        syscall




