.global get_bitseq_s
.global get_bitseq_signed_s


get_bitseq_signed_s:

# Allocate space on the stack for local variables
addi    sp, sp, -48        # Adjust stack pointer to allocate 48 bytes for local variables
sd      ra, 40(sp)         # Save return address in the stack frame
sd      s0, 32(sp)         # Save previous stack pointer in the stack frame
addi    s0, sp, 48         # Set up base pointer for accessing local variables

# Copy function arguments to local variables
mv      a5, a0             # Copy argument 0 to a5 (argument 1 for get_bitseq_c)
mv      a3, a1             # Copy argument 1 to a3 (argument 2 for get_bitseq_c)
mv      a4, a2             # Copy argument 2 to a4 (argument 3 for get_bitseq_c)
sw      a5, -36(s0)        # Store a5 (argument 1) in local variable space
mv      a5, a3             # Copy a3 (argument 2) to a5
sw      a5, -40(s0)        # Store a5 (argument 2) in local variable space
mv      a5, a4             # Copy a4 (argument 3) to a5
sw      a5, -44(s0)        # Store a5 (argument 3) in local variable space

# Calculate values for manipulation
lw      a5, -44(s0)        # Load argument 3 into a5
mv      a4, a5             # Move argument 3 to a4
lw      a5, -40(s0)        # Load argument 2 into a5
subw    a5, a4, a5         # Subtract argument 2 from argument 3 and store result in a5
addi    a5, a5, 1          # Add immediate value 1 to a5
sw      a5, -20(s0)        # Store result in local variable space


# Perform bitwise operations
li      a5, 32             # Load immediate value 32 into a5
lw      a4, -20(s0)        # Load result of previous calculation into a4
subw    a5, a5, a4         # Subtract a4 from 32 and store result in a5
sw      a5, -24(s0)        # Store result in local variable space
lw      a5, -36(s0)        # Load argument 1 into a5
lw      a3, -44(s0)        # Load argument 3 into a3
lw      a4, -40(s0)        # Load argument 2 into a4
mv      a2, a3             # Move argument 3 to a2
mv      a1, a4             # Move argument 2 to a1
mv      a0, a5             # Move argument 1 to a0
call    get_bitseq_c       # Call function get_bitseq_c with arguments a0, a1, and a2

mv      a5, a0             # Move return value to a5
sw      a5, -28(s0)        # Store return value in local variable space
lw      a5, -24(s0)        # Load a value from local variable space into a5
lw      a4, -28(s0)        # Load return value from local variable space into a4
sllw    a5, a4, a5         # Shift left logical word in a4 by a5 and store result in a5
sw      a5, -28(s0)        # Store result in local variable space
lw      a5, -28(s0)        # Load a value from local variable space into a5
lw      a4, -24(s0)        # Load a value from local variable space into a4
sraw    a5, a5, a4         # Shift right arithmetic word in a5 by a4 and store result in a5
sw      a5, -32(s0)        # Store result in local variable space
lw      a5, -32(s0)        # Load a value from local variable space into a5
mv      a0, a5             # Move a5 (result) to a0


# Restore stack and return
ld      ra, 40(sp)         # Restore return address from stack frame to ra
ld      s0, 32(sp)         # Restore previous stack pointer from stack frame to s0
addi    sp, sp, 48         # Restore stack pointer
jr      ra                  # Jump to return address
