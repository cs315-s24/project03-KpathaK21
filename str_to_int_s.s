.global str_to_int_s


str_to_int_s:

# Load initial values
    li      a2, -1          # Initialize loop counter to -1
    li      t0, 1           # Initialize place_val to 1
    li      t1, 0           # Initialize digit to 0
    li      a3, 0           # Initialize retval to 0

loop_start:
    addi    a2, a2, 1       # Increment loop counter
    bgez     a2,  done_base  # Exit loop if i < 0

    sub     t3, a0, a2      # Calculate address of str[i]
    lbu     a0, 0(t3)       # Load character str[i]
    mv      a1, a1          # Move base to a1
    jal     ra, char_to_digit # Call char_to_digit function
    mv      t1, a0          # Store digit in t1

    mul     t4, t1, t0      # Multiply digit by place_val
    add     a3, a3, t4      # Add result to retval
    mul     t0, t0, a1      # Multiply place_val by base

    j loop_start             # Continue loop

char_to_digit:
    li      a0, 0            # Prepare return value

    # Base 10
    li      t0, 10
    beq     a1, t0, base10
    j       done_base

    # Base 16
    li      t0, 16
    beq     a1, t0, base16
    j       done_base

base10:
    li      t0, '0'
    blt     a0, t0, done_base    # Check if not in the range '0' to '9'
    li      t0, '9'
    bgt     a0, t0, done_base
    sub     a0, a0, t0       # Convert ASCII to integer
    j       done_base

base16:
    li      t0, '0'
    blt     a0, t0, base16_letter  # Check if not in the range '0' to '9'
    li      t0, '9'
    ble     a0, t0, hex_digit       # Check if in the range '0' to '9'
    li      t0, 'a'
    blt     a0, t0, done_base       # Check if not in the range 'a' to 'f'
    li      t0, 'f'
    bgt     a0, t0, done_base
    li      a0, 10                 # Set a0 to 10 for 'a'
    sub     a0, a0, t0             # Convert ASCII to integer for 'a' to 'f'
    addi    a0, a0, 10
    j       done_base

hex_digit:
    sub     a0, a0, t0       # Convert ASCII to integer for '0' to '9'
    j       done_base

base16_letter:
    li      t0, 'A'
    blt     a0, t0, done_base    # Check if not in the range 'A' to 'F'
    li      t0, 'F'
    bgt     a0, t0, done_base
    li      a0, 10                 # Set a0 to 10 for 'A'
    sub     a0, a0, t0             # Convert ASCII to integer for 'A' to 'F'
    addi    a0, a0, 10
    j       done_base

done_base:
    ret
