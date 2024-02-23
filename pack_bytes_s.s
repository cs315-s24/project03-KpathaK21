.global pack_bytes_s

pack_bytes_s:
    # Arguments are passed in a0, a1, a2, a3 registers
    # Return value is in a0 register

    # Load b3 into val
    mv a0, a0

    # Shift val left by 8 bits and OR with b2
    slli a0, a0, 8
    or a0, a0, a1

    # Shift val left by 8 bits and OR with b1
    slli a0, a0, 8
    or a0, a0, a2

    # Shift val left by 8 bits and OR with b0
    slli a0, a0, 8
    or a0, a0, a3

    # Return val
    ret
