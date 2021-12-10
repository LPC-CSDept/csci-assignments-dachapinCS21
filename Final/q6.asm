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
        sw      $v0, 10         # Set $v0 to 10
        sw      $a0, 11         # Set $a0 to 11

        mfc0    $k0, $13        # Read Cause Register to $k0
        srl     $a0, $k0, 2     # Bit 0 and 1 of Cause Register are blank
        andi    $a0, $a0, 0x1F  # Only leave 5 bits that represeent Exception Code
        bnez    $a0, done       # If exception code is skip to done

        lui     $v0, 0xFFFF     # $v0 = Memory location of the start of the MMIO section(Receiver Control) 
        lw      $a0, 4($v0)     # Read data from Receiver Data to $a0
        li      $v0, 4          # System Code to print string
        syscall

done:
        lw      $v0, 10         # Restore $v0
        lw      $a0, 11         # Restore $a0
        mtc0    $zero, $13      # Clear Cause Register
        mfc0    $k0, $12        # Set Status Register
        ori     $k0, 0x11       # Reenable interrupts
        mtc0    $k0, $12        # Copy to Status Register
        eret                    # Return to Exception Program Counter


