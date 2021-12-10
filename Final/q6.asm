#
# q6.asm
# Daniel Chapin
# 12/10/21
# CS21 Final Q6
# Take input by user and print it in the console until 'q' is typed using an interrupt handler
#

        .text
        .globl  main
main:
        mfc0    $a0, $12        # Read the Status Register
        ori     $a0, 0xFF11     # Enable all interrupts
        mtc0    $a0, $12        # Copy new pattern, with interrupts enabled back to the Status Register

        lui     $t9, 0xFFFF     # $t9 = Memory location of the start of the MMIO section(Receiver Control) 
        ori     $a0, $zero, 2   # Enable keyboard interrupt
        sw      $a0, 0($t9)     # Store new pattern to Receiver Control to enable interrupts

loop:
        j       loop            # Infinite loop until 'q' is reached


        .ktext  0x80000180      # Start of Kernel text
        sw      $v0, 10
        sw      $a0, 11

        mfc0    $k0, $13        # Read Cause Register to $k0
        srl     $a0, $k0, 2     # Bit 0 and 1 of Cause Register are blank
        andi    $a0, $a0, 0x1F  # Only leave 5 bits that represeent Exception Code
        bnez    $a0, done       # If exception code is skip to done


