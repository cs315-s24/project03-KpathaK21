.global get_bitseq_signed_s
.global get_bitseq_s

get_bitseq_signed_s:

    # Save registers on the stack
    addi    sp, sp, -16
    sd      ra, 8(sp)
    sd      s0, 0(sp)

    # Calculate len (end - start + 1)
    sub    t0, a2, a1     # Subtract start from end
    addi    t0, t0, 1       # Add 1 to get the length

    # Calculate shift amount (32 - len)
    li      t1, 32
    sub     t2, t1, t0      # Calculate shift amount

    # Call get_bitseq_c
    mv      a0, a0           # num
    mv      a1, a1           # start
    mv      a2, a2           # end
    jal     ra, get_bitseq_s # Call get_bitseq_s
    mv      t3, a0           # Store the result in t3


    # Check if the number is negative
    blt     a0, zero, is_negative

    # Number is positive, directly shift
    sll     t3, t3, t2      # Shift left by shift amount
    sra     a0, t3, t2      # Arithmetic right shift by shift amount
    j       end_conversion

is_negative:
    # Number is negative, perform sign extension
    li      t4, -1           # t4 = Sign extension mask (all bits set to 1)
    sll     t4, t4, t0      # t4 = t4 << length
    or      t3, t3, t4      # Perform sign extension by OR-ing with the extended mask
    sll     t3, t3, t2      # Shift left by shift amount
    mv      a0, t3          # Move the sign-extended value to a0

end_conversion:
    # Restore registers from the stack
    ld      ra, 8(sp)
    ld      s0, 0(sp)
    addi    sp, sp, 16

    # Return val_signed
    ret
