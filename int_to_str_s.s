.global int_to_str_s
.global str_to_int_s


int_to_str_s:
    # Prologue: Setup stack frame
    addi    sp,sp,-96        # Adjust stack pointer to allocate space for variables
    sd      s0,88(sp)        # Save previous frame pointer
    addi    s0,sp,96         # Set up current frame pointer

    # Function body
    mv      a5,a0            # Move input integer to a5
    sd      a1,-96(s0)       # Save pointer to output string
    mv      a4,a2            # Move base of string representation to a4
    sw      a5,-84(s0)       # Save input integer
    mv      a5,a4            # Move base address to a5
    sw      a5,-88(s0)       # Save base address of string representation
    sw      zero,-24(s0)     # Initialize loop index to 0
    sw      zero,-28(s0)     # Initialize digit counter to 0


# Branch to handle conversion for different bases
.L26:
    lw      a5,-88(s0)       # Load base address of string representation
    lw      a4,-84(s0)       # Load input integer
    divuw   a5,a4,a5         # Divide input integer by base
    sw      a5,-32(s0)       # Store quotient
    lw      a5,-88(s0)       # Load base address of string representation
    lw      a4,-84(s0)       # Load input integer
    remuw   a5,a4,a5         # Compute remainder
    sw      a5,-36(s0)       # Store remainder
    lw      a5,-36(s0)       # Load remainder
    sext.w  a4,a5            # Sign extend remainder
    li      a5,9             # Load threshold for base 10 conversion
    bgtu    a4,a5,.L24       # Branch if remainder > 9
    lw      a5,-36(s0)       # Reload remainder
    andi    a5,a5,0xff       # Mask out any bits beyond byte size
    addiw   a5,a5,48         # Convert to ASCII character
    andi    a4,a5,0xff       # Mask out any bits beyond byte size
    lw      a5,-28(s0)       # Load digit counter
    addi    a5,a5,-16        # Decrement digit counter
    add     a5,a5,s0         # Calculate address to store digit
    sb      a4,-56(a5)       # Store ASCII character
    j       .L25             # Jump to end of conversion

.L24:
    lw      a5,-36(s0)       # Reload remainder
    sext.w  a4,a5            # Sign extend remainder
    li      a5,9             # Load threshold for base 10 conversion
    bleu    a4,a5,.L25       # Branch if remainder <= 9
    lw      a5,-36(s0)       # Reload remainder
    sext.w  a4,a5            # Sign extend remainder
    li      a5,15            # Load threshold for base 16 conversion
    bgtu    a4,a5,.L25       # Branch if remainder > 15
    lw      a5,-36(s0)       # Reload remainder
    andi    a5,a5,0xff       # Mask out any bits beyond byte size
    addiw   a5,a5,87         # Convert to ASCII character (A-F)
    andi    a4,a5,0xff       # Mask out any bits beyond byte size
    lw      a5,-28(s0)       # Load digit counter
    addi    a5,a5,-16        # Decrement digit counter
    add     a5,a5,s0         # Calculate address to store digit
    sb      a4,-56(a5)       # Store ASCII character

.L25:
    lw      a5,-28(s0)       # Load digit counter
    addiw   a5,a5,1           # Increment digit counter
    sw      a5,-28(s0)       # Store updated digit counter
    lw      a5,-32(s0)       # Load quotient
    sw      a5,-84(s0)       # Store updated input integer

    # Check if input integer is zero
.L23:
    lw      a5,-84(s0)       # Load input integer
    sext.w  a5,a5            # Sign extend input integer
    bne     a5,zero,.L26     # Branch if input integer is not zero

.L22:
    lw      a5,-88(s0)       # Load base address of string representation
    sext.w  a4,a5            # Sign extend base address
    li      a5,2             # Load base 2
    bne     a4,a5,.L27      # Branch if base is not 2


    # Special handling for base 2
    lw      a5,-24(s0)       # Load loop index
    ld      a4,-96(s0)       # Load pointer to output string
    add     a5,a4,a5         # Calculate address to store digit
    li      a4,48            # ASCII value for '0'
    sb      a4,0(a5)         # Store '0' character
    lw      a5,-24(s0)       # Load loop index
    addi    a5,a5,1          # Increment loop index
    ld      a4,-96(s0)       # Load pointer to output string
    add     a5,a4,a5         # Calculate address to store digit
    li      a4,49            # ASCII value for '1'
    sb      a4,0(a5)         # Store '1' character
    lw      a5,-24(s0)       # Load loop index
    addiw   a5,a5,2          # Increment loop index by 2
    sw      a5,-24(s0)       # Store updated loop index
    j       .L28             # Jump to end of function

.L27:
    lw      a5,-88(s0)       # Load base address of string representation
    sext.w  a4,a5            # Sign extend base address
    li      a5,16            # Load base 16
    bne     a4,a5,.L28      # Branch if base is not 16


    # Special handling for base 16
    lw      a5,-24(s0)       # Load loop index
    ld      a4,-96(s0)       # Load pointer to output string
    add     a5,a4,a5         # Calculate address to store digit
    li      a4,48            # ASCII value for '0'
    sb      a4,0(a5)         # Store '0' character
    lw      a5,-24(s0)       # Load loop index
    addi    a5,a5,1          # Increment loop index
    ld      a4,-96(s0)       # Load pointer to output string
    add     a5,a4,a5         # Calculate address to store digit
    li      a4,120           # ASCII value for 'x'
    sb      a4,0(a5)         # Store 'x' character
    lw      a5,-24(s0)       # Load loop index
    addiw   a5,a5,2          # Increment loop index by 2
    sw      a5,-24(s0)       # Store updated loop index

.L28:
    lw      a5,-28(s0)       # Load digit counter
    sw      a5,-20(s0)       # Store digit counter
	j 		.L29
# Loop to fill remaining digits with zero
.L30:
    lw      a5,-20(s0)       # Load digit counter
    addiw   a5,a5,-1         # Decrement digit counter
    sext.w  a4,a5            # Sign extend digit counter
    lw      a5,-24(s0)       # Load loop index
    ld      a3,-96(s0)       # Load pointer to output string
    add     a5,a3,a5         # Calculate address to store zero
    addi    a4,a4,-16        # Calculate address offset for string buffer
    add     a4,a4,s0         # Add string buffer base address
    lbu     a4,-56(a4)       # Load digit from string buffer
    sb      a4,0(a5)         # Store digit (or zero) to output string
    lw      a5,-20(s0)       # Load digit counter
    addiw   a5,a5,-1         # Decrement digit counter
    sw      a5,-20(s0)       # Store updated digit counter
    lw      a5,-24(s0)       # Load loop index
    addiw   a5,a5,1          # Increment loop index
    sw      a5,-24(s0)       # Store updated loop index

.L29:
    lw      a5,-20(s0)       # Load digit counter
    sext.w  a5,a5            # Sign extend digit counter
    bgt     a5,zero,.L30     # Loop if there are remaining digits to fill with zero
    lw      a5,-24(s0)       # Load loop index
    ld      a4,-96(s0)       # Load pointer to output string
    add     a5,a4,a5         # Calculate address to store null terminator
    sb      zero,0(a5)       # Store null terminator
    nop                       # No operation
    ld      s0,88(sp)        # Restore previous frame pointer
    addi    sp,sp,96         # Deallocate stack space
    jr      ra                # Return to calling function
