 .global str_to_int_s

# Function: convert_char_to_digit
# Converts a character representing a digit to its integer value
char_to_digit:
      addi    sp, sp, -32     # Allocate space on stack for local variables
        sd      s0, 24(sp)      # Save the value of s0 register onto the stack
        addi    s0, sp, 32      # Set up s0 as the base address of the local variables
        mv      a5, a0          # Move the character to be converted to a5 register
        mv      a4, a1          # Move the result address to a4 register
        sb      a5, -17(s0)     # Store the character onto the stack
        mv      a5, a4          # Move the result address to a5 register
        sw      a5, -24(s0)     # Store the result address onto the stack
        lw      a5, -24(s0)     # Load the result address from stack to a5
        li      a4, 16          # Load 16 into a4
        beq     a5, a4, .L2     # Branch to .L2 if character is '1' followed by '6' (hexadecimal)
        lw      a5, -24(s0)     # Load the result address from stack to a5
       li      a4, 16           # Load 16 into a4
        bgt     a5, a4, .L3     # Branch to .L3 if character greater than '1' followed by '6' (binary)
        lw      a5, -24(s0)     # Load the result address from stack to a5
        li      a4, 2           # Load 2 into a4
        beq     a5, a4, .L4     # Branch to .L4 if character is '2' (binary)
        lw      a5, -24(s0)     # Load the result address from stack to a5
        li      a4, 10         # Load 10 into a4
        beq     a5, a4, .L5     # Branch to .L5 if character is '1' followed by '0' (decimal)
        j       .L3             # Jump to .L3 if none of the above conditions met

.L4:
        lbu     a5, -17(s0)     # Load the character from stack to a5
        andi    a4, a5, 0xff    # Perform bitwise AND with 0xff, effectively clearing upper bits
        li      a5, 48          # Load ASCII value of '0' into a5
        beq     a4, a5, .L6     # Branch to .L6 if character is '0'
        lbu     a5, -17(s0)     # Load the character from stack to a5
        andi    a4, a5, 0xff    # Perform bitwise AND with 0xff, effectively clearing upper bits
        li      a5, 49          # Load ASCII value of '1' into a5
        bne     a4, a5, .L13    # Branch to .L13 if character is not '1'

.L6:
        lbu     a5, -17(s0)     # Load the character from stack to a5
        addiw   a5, a5, -48     # Convert ASCII digit to its integer value
        j       .L1             # Jump to .L1 (end of function)

.L5:
        lbu     a5, -17(s0)     # Load the character from stack to a5
        andi    a4, a5, 0xff    # Perform bitwise AND with 0xff, effectively clearing upper bits
        li      a5, 47          # Load ASCII value of '/' into a5
        bleu    a4, a5, .L14    # Branch to .L14 if character is less than or equal to '/'
        lbu     a5, -17(s0)     # Load the character from stack to a5
        andi    a4, a5, 0xff    # Perform bitwise AND with 0xff, effectively clearing upper bits
        li      a5, 57          # Load ASCII value of '9' into a5
        bgtu    a4, a5, .L14    # Branch to .L14 if character is greater than '9'
        lbu     a5, -17(s0)     # Load the character from stack to a5
        addiw   a5, a5, -48     # Convert ASCII digit to its integer value
        j       .L1             # Jump to .L1 (end of function)

.L2:
        lbu     a5, -17(s0)     # Load the character from stack to a5
        andi    a4, a5, 0xff    # Perform bitwise AND with 0xff, effectively clearing upper bits
        li      a5, 47          # Load ASCII value of '/' into a5
        bleu    a4, a5, .L10    # Branch to .L10 if character is less than or equal to '/'
        lbu     a5, -17(s0)     # Load the character from stack to a5
        andi    a4, a5, 0xff    # Perform bitwise AND with 0xff, effectively clearing upper bits
        li      a5, 57          # Load ASCII value of '9' into a5
        bgtu    a4, a5, .L10    # Branch to .L10 if character is greater than '9'
        lbu     a5, -17(s0)     # Load the character from stack to a5
        addiw   a5, a5, -48     # Convert ASCII digit to its integer value
        j       .L1             # Jump to .L1 (end of function)

.L10:
        lbu     a5, -17(s0)     # Load the character from stack to a5
        andi    a4, a5, 0xff    # Perform bitwise AND with 0xff, effectively clearing upper bits
        li      a5, 96          # Load ASCII value of '`' into a5
        bleu    a4, a5, .L11    # Branch to .L11 if character is less than or equal to '`'
        lbu     a5, -17(s0)     # Load the character from stack to a5
        andi    a4, a5, 0xff    # Perform bitwise AND with 0xff, effectively clearing upper bits
        li      a5, 102         # Load ASCII value of 'f' into a5
        bgtu    a4, a5, .L11    # Branch to .L11 if character is greater than 'f'
        lbu     a5, -17(s0)     # Load the character from stack to a5
        addiw   a5, a5, -87     # Convert ASCII digit (a-f) to its integer value
        j       .L1             # Jump to .L1 (end of function)

.L11:
        lbu     a5, -17(s0)     # Load the character from stack to a5
        andi    a4, a5, 0xff    # Perform bitwise AND with 0xff, effectively clearing upper bits
        li      a5, 64          # Load ASCII value of '@' into a5
        bleu    a4, a5, .L15    # Branch to .L15 if character is less than or equal to '@'
        lbu     a5, -17(s0)     # Load the character from stack to a5
        andi    a4, a5, 0xff    # Perform bitwise AND with 0xff, effectively clearing upper bits
        li      a5, 70          # Load ASCII value of 'F' into a5
        bgtu    a4, a5, .L15    # Branch to .L15 if character is greater than 'F'
        lbu     a5, -17(s0)     # Load the character from stack to a5
        addiw   a5, a5, -55     # Convert ASCII digit (A-F) to its integer value
        j       .L1             # Jump to .L1 (end of function)

.L13:
        nop                     # No operation
        j       .L3             # Jump to .L3 (end of function)

.L14:
        nop                     # No operation
        j       .L3             # Jump to .L3 (end of function)

.L15:
        nop                     # No operation

.L3:                            # Label .L3 (end of function)
.L1:                            # Label .L1 (end of function)
        mv      a0, a5          # Move the result to a0 register
        ld      s0, 24(sp)      # Restore the value of s0 register from stack
        addi    sp, sp, 32      # Deallocate space on stack
        jr      ra              # Return to calling function

str_to_int_s:
       addi    sp, sp, -48     # Allocate space on stack for local variables
        sd      ra, 40(sp)      # Save the value of ra register onto the stack
        sd      s0, 32(sp)      # Save the value of s0 register onto the stack
        addi    s0, sp, 48      # Set up s0 as the base address of the local variables
        sd      a0, -40(s0)     # Save the input string address onto the stack
        mv      a5, a1          # Move the result address to a5 register
        sw      a5, -44(s0)     # Store the result address onto the stack
        sw      zero, -20(s0)   # Initialize a variable to zero
        li      a5, 1           # Load 1 into a5
        sw      a5, -24(s0)     # Store 1 onto the stack (used in loop)
      ld      a0, -40(s0)     # Load the input string address from the stack to a0
        call    strlen          # Call the strlen function to get the length of the string
        mv      a5, a0          # Move the length of the string to a5
        addiw   a5, a5, -1      # Decrement the length by 1 (since indexing starts from 0)
        sw      a5, -28(s0)     # Store the length onto the stack
        j       .L17            # Jump to .L17


.L18:
        lw      a5, -28(s0)     # Load the length from the stack to a5
        ld      a4, -40(s0)     # Load the input string address from the stack to a4
        add     a5, a4, a5      # Calculate the address of the current character in the string
        lbu     a5, 0(a5)       # Load the current character from the string to a5
        lw      a4, -44(s0)     # Load the result address from the stack to a4
        mv      a1, a4          # Move the result address to a1 register
        mv      a0, a5          # Move the current character to a0 register
        call    char_to_digit   # Call the char_to_digit function to convert character to digit
        mv      a5, a0          # Move the result to a5 register
        sw      a5, -32(s0)     # Store the result onto the stack
      lw      a5, -32(s0)     # Load the result from the stack to a5
        mv      a4, a5          # Move the result to a4 register
        lw      a5, -24(s0)     # Load 1 from the stack to a5
        mulw    a5, a4, a5      # Multiply the result by 1
        lw      a4, -20(s0)     # Load the accumulated result from the stack to a4
        addw    a5, a4, a5      # Add the result to the accumulated result
        sw      a5, -20(s0)     # Store the accumulated result onto the stack
        lw      a5, -24(s0)     # Load 1 from the stack to a5
        mv      a4, a5          # Move 1 to a4 register
        lw      a5, -44(s0)     # Load the result address from the stack to a5
        mulw    a5, a4, a5      # Multiply 1 by the result address
       sw      a5, -24(s0)     # Store the result onto the stack
        lw      a5, -28(s0)     # Load the length from the stack to a5
        addiw   a5, a5, -1      # Decrement the length by 1
        sw      a5, -28(s0)     # Store the decremented length onto the stack
        

.L17:
        lw      a5, -28(s0)     # Load the length from the stack to a5
        bge     a5, zero, .L18  # If length is greater than or equal to zero, continue loop
        lw      a5, -20(s0)     # Load the accumulated result from the stack to a5
        mv      a0, a5          # Move the accumulated result to a0 register
        ld      ra, 40(sp)      # Load the value of ra register from the stack to ra
        ld      s0, 32(sp)      # Load the value of s0 register from the stack to s0
        addi    sp, sp, 48      # Deallocate space on stack
        jr      ra              # Return to calling function
