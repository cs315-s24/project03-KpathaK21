.global unpack_bytes_s

unpack_bytes_s:
    # Arguments:
    # a0: val
    # a1: pointer to bytes array

    # Save registers
    addi sp, sp, -16    # Allocate space on stack for saving registers
    sd ra, 0(sp)        # Save return address (ra)
    sd s0, 8(sp)        # Save s0 (loop counter)

    # Initialize loop counter
    li s0, 0            # Load immediate value 0 into s0 (loop counter)

loop:
    # Extract least significant byte and store in bytes[i]
    andi a2, a0, 0xFF   # Extract least significant byte by bitwise AND with 0xFF
    sw a2, 0(a1)        # Store byte in bytes[i]

    # Shift right by 8 bits (1 byte)
    srai a0, a0, 8      # Shift right arithmetic by 8 bits (1 byte)

    # Increment array pointer
    addi a1, a1, 4      # Increment array pointer by 4 bytes (size of uint32_t)

    # Increment loop counter
    addi s0, s0, 1      # Increment loop counter by 1

# Load immediate value 4 into t0
    li t0, 4
    
    # Check loop condition (i < 4)
    bltu s0, t0, loop     # Branch to loop if s0 < 4

    # Restore registers and return
    ld ra, 0(sp)        # Restore return address (ra)
    ld s0, 8(sp)        # Restore s0 (loop counter)
    addi sp, sp, 16     # Deallocate space on stack for saved registers

    # Return void
    ret
