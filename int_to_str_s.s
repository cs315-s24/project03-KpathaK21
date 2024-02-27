.global int_to_str_s


int_to_str_s:
    # Set up stack frame
    addi    sp, sp, -16
    sw      ra, 0(sp)
    sw      s0, 4(sp)
    sw      s1, 8(sp)

    # Initialize variables
    mv      s0, a1          # Store pointer to output string buffer
    mv      s1, s0          # Store pointer to the beginning of the string
    li      t0, 0           # Initialize index to 0

divide_loop:
    remu    t1, a0, a2      # Calculate remainder (remainder = a0 % base)
    addi    t1, t1, '0'     # Convert remainder to ASCII character
    sb      t1, 0(s1)       # Store remainder in output string buffer
    addi    s1, s1, 1       # Move to the next character in the buffer
    addi    t0, t0, 1       # Increment index

    divu    a0, a0, a2      # Divide integer by base (quotient = a0 / base)
    bnez    a0, divide_loop # Continue until quotient is zero

    # Null-terminate the string
    li      t1, 0           # Null character
    sb      t1, 0(s1)       # Store null character at the end of the string

    # Reverse the string
    mv      a0, s0          # Pointer to the end of the string
    mv      a1, t0          # Length of the string
    jal     reverse_string  # Call reverse_string to reverse the string

    # Restore stack frame and return
    lw      ra, 0(sp)
    lw      s0, 4(sp)
    lw      s1, 8(sp)
    addi    sp, sp, 16
    ret

reverse_string:
    # Set up stack frame
    addi    sp, sp, -16
    sw      ra, 0(sp)
    sw      s0, 4(sp)

    # Initialize variables
    mv      s0, a0          # Pointer to the end of the string
    mv      t2, a1          # Length of the string
    li      t3, 0           # Initialize index to 0
    addi    s1, s0, -1      # Pointer to the beginning of the string

reverse_loop:
    li      t1, 0           # Null character
    beq     t3, t2, exit_reverse # Exit loop when index equals length
    lb      t0, 0(s0)       # Load character from end of string
    sb      t0, 0(s1)       # Store character at current position
    sb      t1, 0(s0)       # Store null character at end of string
    addi    s0, s0, -1      # Move to the previous character
    addi    s1, s1, 1       # Move to the next position
    addi    t3, t3, 1       # Increment index
    j       reverse_loop    # Continue looping

exit_reverse:
    # Restore stack frame and return
    lw      ra, 0(sp)
    lw      s0, 4(sp)
    addi    sp, sp, 16
    ret
