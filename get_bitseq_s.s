.global get_bitseq_s

get_bitseq_s:
    # Save registers on the stack
    addi    sp, sp, -16
    sd      ra, 8(sp)
    sd      s0, 0(sp)

 # Calculate len (end - start + 1)
        sub     t0, a2, a1     # Subtract start from end
        addi    t0, t0, 1      # Add 1 to get the length
    
        # Shift num right by start
        srl     a1, a0, a1
    
        # Load immediate value 32
        li      t1, 32
    
        # Compare len with 32
        blt     t0, t1, len_not_32
    
        # Set mask to 0xFFFFFFFF
        li      a0, 0xFFFFFFFF
        j       end_mask

len_not_32:
    # Generate mask ((1 << len) - 1)
    li      t2, 0           # Initialize mask to 0
    li      t3, 0           # Initialize counter to 0

shift_loop:
        # Shift 1 bit to the left by the counter value and bitwise OR with the mask
        li      t4, 1           # Load immediate value 1
        sll     t4, t4, t3      # Shift 1 left by the counter value
        or      t2, t2, t4      # Bitwise OR with shifted mask
        addi    t3, t3, 1       # Increment counter
        blt     t3, t0, shift_loop # Repeat until counter reaches len
    
        mv      a0, t2          # Move mask to a0
end_mask:
    # Bitwise AND between val and mask
    and     a0, a1, a0

    # Restore registers from the stack
    ld      ra, 8(sp)
    ld      s0, 0(sp)
    addi    sp, sp, 16

    # Return val
    ret
