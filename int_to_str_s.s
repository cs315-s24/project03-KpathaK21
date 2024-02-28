.global int_to_str_s
.global str_to_int_s


int_to_str_s:
  addi    sp, sp, -96     # Allocate space on the stack for local variables
    sd      s0, 88(sp)      # Save the value of s0 register on the stack
    addi    s0, sp, 96      # Set s0 to point to the start of the stack frame
    mv      a5, a0          # Move argument a0 to a5
    sd      a1, -96(s0)     # Store argument a1 on the stack at offset -96 from s0
    mv      a4, a2          # Move argument a2 to a4
    sw      a5, -84(s0)     # Store a5 on the stack at offset -84 from s0
    mv      a5, a4          # Move a4 to a5
    sw      a5, -88(s0)     # Store a5 on the stack at offset -88 from s0
    sw      zero, -24(s0)   # Store zero on the stack at offset -24 from s0
    sw      zero, -28(s0)   # Store zero on the stack at offset -28 from s0
    lw      a5, -84(s0)     # Load value from stack at offset -84 into a5
   sext.w  a5, a5          # Sign-extend word in a5
    bne     a5, zero, .L23  # Branch if a5 is not equal to zero to label .L23
    lw      a5, -28(s0)     # Load value from stack at offset -28 into a5
    addiw   a4, a5, 1       # Add immediate word in a5 to 1 and store result in a4
    sw      a4, -28(s0)     # Store a4 on the stack at offset -28 from s0
    addi    a5, a5, -16     # Add immediate -16 to a5
    add     a5, a5, s0      # Add s0 to a5 and store result in a5
    li      a4, 48          # Load immediate value 48 into a4
    sb      a4, -56(a5)     # Store byte a4 at memory address -56(a5)
    j       .L22            # Unconditional jump to label .L22


# Branch to handle conversion for different bases
.L26:
    lw      a5, -88(s0)     # Load value from stack at offset -88 into a5
    lw      a4, -84(s0)     # Load value from stack at offset -84 into a4
    divu    a5, a4, a5      # Unsigned division a4 by a5, result in a5
    sw      a5, -32(s0)     # Store a5 on the stack at offset -32 from s0
    lw      a5, -88(s0)     # Load value from stack at offset -88 into a5
    lw      a4, -84(s0)     # Load value from stack at offset -84 into a4
    remu    a5, a4, a5      # Unsigned remainder of a4 by a5, result in a5
    sw      a5, -36(s0)     # Store a5 on the stack at offset -36 from s0
    lw      a5, -36(s0)     # Load value from stack at offset -36 into a5
    sext.w  a4, a5          # Sign-extend word in a5
    li      a5, 9           # Load immediate value 9 into a5
    bgtu    a4, a5, .L24    # Branch if a4 is greater than a5 to .L24
    lw      a5, -36(s0)     # Load value from stack at offset -36 into a5
    andi    a5, a5, 0xff    # Zero-extend the least significant byte of a5
    addiw   a5, a5, 48      # Add immediate word 48 to a5 and store result in a5
    andi    a4, a5, 0xff    # Zero-extend the least significant byte of a5
    lw      a5, -28(s0)     # Load value from stack at offset -28 into a5
    addi    a5, a5, -16     # Add immediate -16 to a5
    add     a5, a5, s0      # Add s0 to a5 and store result in a5
    sb      a4, -56(a5)     # Store byte a4 at memory address -56(a5)
    j       .L25            # Unconditional jump to .L25
    
.L24:
    lw      a5, -36(s0)     # Load value from stack at offset -36 into a5
    sext.w  a4, a5          # Sign-extend word in a5
    li      a5, 9           # Load immediate value 9 into a5
    bleu    a4, a5, .L25    # Branch if a4 is less than or equal to a5 to .L25
    lw      a5, -36(s0)     # Load value from stack at offset -36 into a5
    sext.w  a4, a5          # Sign-extend word in a5
    li      a5, 15          # Load immediate value 15 into a5
    bgtu    a4, a5, .L25    # Branch if a4 is greater than a5 to .L25
    lw      a5, -36(s0)     # Load value from stack at offset -36 into a5
    andi    a5, a5, 0xff    # Zero-extend the least significant byte of a5
   addiw   a5, a5, 87      # Add immediate word 87 to a5 and store result in a5
    andi    a4, a5, 0xff    # Zero-extend the least significant byte of a5
    lw      a5, -28(s0)     # Load value from stack at offset -28 into a5
    addi    a5, a5, -16     # Add immediate -16 to a5
    add     a5, a5, s0      # Add s0 to a5 and store result in a5
    sb      a4, -56(a5)     # Store byte a4 at memory address -56(a5)
.L25:
   lw      a5, -28(s0)     # Load value from stack at offset -28 into a5
    addiw   a5, a5, 1       # Add immediate word 1 to a5 and store result in a5
    sw      a5, -28(s0)     # Store a5 on the stack at offset -28 from s0
    lw      a5, -32(s0)     # Load value from stack at offset -32 into a5
    sw      a5, -84(s0)     # Store a5 on the stack at offset -84 from s0
.L23:
    lw      a5, -84(s0)     # Load value from stack at offset -84 into a5
    sext.w  a5, a5          # Sign-extend word in a5
    bne     a5, zero, .L26  # Branch if a5 is not equal to zero to .L26

    
.L22:
    lw      a5, -88(s0)     # Load value from stack at offset -88 into a5
    sext.w  a4, a5          # Sign-extend word in a5
    li      a5, 2           # Load immediate value 2 into a5
    bne     a4, a5, .L27    # Branch if a4 is not equal to a5 to .L27
    lw      a5, -24(s0)     # Load value from stack at offset -24 into a5
    ld      a4, -96(s0)     # Load value from stack at offset -96 into a4
    add     a5, a4, a5      # Add a4 and a5, store result in a5
    li      a4, 48          # Load immediate value 48 into a4
    sb      a4, 0(a5)       # Store byte a4 at memory address 0(a5)
    lw      a5, -24(s0)     # Load value from stack at offset -24 into a5
    addi    a5, a5, 1       # Add immediate value 1 to a5
   ld      a4, -96(s0)     # Load value from stack at offset -96 into a4
    add     a5, a4, a5      # Add a4 and a5, store result in a5
    li      a4, 98          # Load immediate value 98 into a4
    sb      a4, 0(a5)       # Store byte a4 at memory address 0(a5)
    lw      a5, -24(s0)     # Load value from stack at offset -24 into a5
    addiw   a5, a5, 2       # Add immediate word 2 to a5 and store result in a5
    sw      a5, -24(s0)     # Store a5 on the stack at offset -24 from s0
    j       .L28            # Unconditional jump to .L28
.L27:
    lw      a5, -88(s0)     # Load value from stack at offset -88 into a5
    sext.w  a4, a5          # Sign-extend word in a5
    li      a5, 16          # Load immediate value 16 into a5
    bne     a4, a5, .L28    # Branch if a4 is not equal to a5 to .L28
    lw      a5, -24(s0)     # Load value from stack at offset -24 into a5
    ld      a4, -96(s0)     # Load value from stack at offset -96 into a4
    add     a5, a4, a5      # Add a4 and a5, store result in a5
    li      a4, 48          # Load immediate value 48 into a4
    sb      a4, 0(a5)       # Store byte a4 at memory address 0(a5)
    lw      a5, -24(s0)     # Load value from stack at offset -24 into a5
   addi    a5, a5, 1       # Add immediate value 1 to a5
    ld      a4, -96(s0)     # Load value from stack at offset -96 into a4
    add     a5, a4, a5      # Add a4 and a5, store result in a5
    li      a4, 120         # Load immediate value 120 into a4
    sb      a4, 0(a5)       # Store byte a4 at memory address 0(a5)
    lw      a5, -24(s0)     # Load value from stack at offset -24 into a5
    addiw   a5, a5, 2       # Add immediate word 2 to a5 and store result in a5
    sw      a5, -24(s0)     # Store a5 on the stack at offset -24 from s0
    
.L28:
    lw      a5,-28(s0)       # Load digit counter
    sw      a5,-20(s0)       # Store digit counter
	j 		.L29
.L30:
    lw      a5, -20(s0)     # Load value from stack at offset -20 into a5
    addiw   a5, a5, -1      # Add immediate word -1 to a5 and store result in a5
    sext.w  a4, a5          # Sign-extend word in a5
    lw      a5, -24(s0)     # Load value from stack at offset -24 into a5
    ld      a3, -96(s0)     # Load value from stack at offset -96 into a3
    add     a5, a3, a5      # Add a3 and a5, store result in a5
    addi    a4, a4, -16     # Add immediate -16 to a4
    add     a4, a4, s0      # Add s0 to a4 and store result in a4
    lbu     a4, -56(a4)     # Load byte from memory address -56(a4) into a4
    sb      a4, 0(a5)       # Store byte a4 at memory address 0(a5)
    lw      a5, -20(s0)     # Load value from stack at offset -20 into a5
    addiw   a5, a5, -1      # Add immediate word -1 to a5 and store result in a5
    sw      a5, -20(s0)     # Store a5 on the stack at offset -20 from s0
    lw      a5, -24(s0)     # Load value from stack at offset -24 into a5
    addiw   a5, a5, 1       # Add immediate word 1 to a5 and store result in a5
    sw      a5, -24(s0)     # Store a5 on the stack at offset -24 from s0
.L29:
    lw      a5, -20(s0)     # Load value from stack at offset -20 into a5
    sext.w  a5, a5          # Sign-extend word in a5
    bgt     a5, zero, .L30  # Branch if a5 is greater than zero to .L30
    lw      a5, -24(s0)     # Load value from stack at offset -24 into a5
    ld      a4, -96(s0)     # Load value from stack at offset -96 into a4
    add     a5, a4, a5      # Add a4 and a5, store result in a5
    sb      zero, 0(a5)     # Store zero byte at memory address 0(a5)
    ld      s0, 88(sp)      # Load value from stack at offset 88 into s0
    addi    sp, sp, 96      # Deallocate space on the stack for local variables
    jr      ra              # Jump back to the return address
