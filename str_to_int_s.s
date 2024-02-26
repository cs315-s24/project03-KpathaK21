.global str_to_int_s

# Function: convert_char_to_digit
# Converts a character representing a digit to its integer value
convert_char_to_digit:
       addi    sp, sp, -32
        sd      s0, 24(sp)
        addi    s0, sp, 32
        mv      a5, a0
        mv      a4, a1
        sb      a5, -17(s0)
        mv      a5, a4
        sw      a5, -24(s0)
        lw      a5, -24(s0)
        li      a4, 16
        beq     a5, a4, .L2
        lw      a5, -24(s0)
        li      a4, 16
        bgt     a5, a4, .L3
        lw      a5, -24(s0)
        li      a4, 2
        beq     a5, a4, .L4
        lw      a5, -24(s0)
        li      a4, 10
        beq     a5, a4, .L5
        j       .L3
.L4:
        lbu     a5, -17(s0)
        andi    a4, a5, 0xff
        li      a5, 48
        beq     a4, a5, .L6
        lbu     a5, -17(s0)
        andi    a4, a5, 0xff
        li      a5, 49
        bne     a4, a5, .L13
.L6:
        lbu     a5, -17(s0)
        addiw   a5, a5, -48
        j       .L1
.L5:
        lbu     a5, -17(s0)
        andi    a4, a5, 0xff
        li      a5, 47
        bleu    a4, a5, .L14
        lbu     a5, -17(s0)
        andi    a4, a5, 0xff
        li      a5, 57
        bgtu    a4, a5, .L14
        lbu     a5, -17(s0)
        addiw   a5, a5, -48
        j       .L1

.L2:
        lbu     a5, -17(s0)
        andi    a4, a5, 0xff
        li      a5, 47
        bleu    a4, a5, .L10
        lbu     a5, -17(s0)
        andi    a4, a5, 0xff
        li      a5, 57
        bgtu    a4, a5, .L10
        lbu     a5, -17(s0)
        addiw   a5, a5, -48
        j       .L1
.L10:
        lbu     a5, -17(s0)
        andi    a4, a5, 0xff
        li      a5, 96
        bleu    a4, a5, .L11
        lbu     a5, -17(s0)
        andi    a4, a5, 0xff
        li      a5, 102
        bgtu    a4, a5, .L11
        lbu     a5, -17(s0)
        addiw   a5, a5, -87
        j       .L1

.L11:
        lbu     a5, -17(s0)
        andi    a4, a5, 0xff
        li      a5, 64
        bleu    a4, a5, .L15
        lbu     a5, -17(s0)
        andi    a4, a5, 0xff
        li      a5, 70
        bgtu    a4, a5, .L15
        lbu     a5, -17(s0)
        addiw   a5, a5, -55
        j       .L1
.L13:
        nop
        j       .L3
.L14:
        nop
        j       .L3
.L15:
        nop
.L3:
.L1:
        mv      a0, a5
        ld      s0, 24(sp)
        addi    sp, sp, 32
        jr      ra

str_to_int_s:
        addi    sp, sp, -48
        sd      ra, 40(sp)
        sd      s0, 32(sp)
        addi    s0, sp, 48
        sd      a0, -40(s0)
        mv      a5, a1
        sw      a5, -44(s0)
        sw      zero, -20(s0)
        li      a5, 1
        sw      a5, -24(s0)
        ld      a0, -40(s0)
        call    strlen
        mv      a5, a0
        addiw   a5, a5, -1
        sw      a5, -28(s0)
        j       .L17

.L18:
        lw      a5, -28(s0)
        ld      a4, -40(s0)
        add     a5, a4, a5
        lbu     a5, 0(a5)
        lw      a4, -44(s0)
        mv      a1, a4
        mv      a0, a5
        call    char_to_digit
        mv      a5, a0
        sw      a5, -32(s0)
        lw      a5, -32(s0)
        mv      a4, a5
        lw      a5, -24(s0)
        mulw    a5, a4, a5
        lw      a4, -20(s0)
        addw    a5, a4, a5
        sw      a5, -20(s0)
        lw      a5, -24(s0)
        mv      a4, a5
        lw      a5, -44(s0)
        mulw    a5, a4, a5
        sw      a5, -24(s0)
        lw      a5, -28(s0)
        addiw   a5, a5, -1
        sw      a5, -28(s0)

.L17:
        lw      a5, -28(s0)
        bge     a5, zero, .L18
        lw      a5, -20(s0)
        mv      a0, a5
        ld      ra, 40(sp)
        ld      s0, 32(sp)
        addi    sp, sp, 48
        jr      ra
