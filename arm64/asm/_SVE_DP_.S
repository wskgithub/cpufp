.align 4

.macro preserve_caller_vec
    cntb x16
    lsl x17, x16, #3
    sub sp, sp, x17

    str z8, [sp, #0, MUL VL]
    str z9, [sp, #1, MUL VL]
    str z10, [sp, #2, MUL VL]
    str z11, [sp, #3, MUL VL]
    str z12, [sp, #4, MUL VL]
    str z13, [sp, #5, MUL VL]
    str z14, [sp, #6, MUL VL]
    str z15, [sp, #7, MUL VL]
.endm

.macro restore_caller_vec
    ldr z8, [sp, #0, MUL VL]
    ldr z9, [sp, #1, MUL VL]
    ldr z10, [sp, #2, MUL VL]
    ldr z11, [sp, #3, MUL VL]
    ldr z12, [sp, #4, MUL VL]
    ldr z13, [sp, #5, MUL VL]
    ldr z14, [sp, #6, MUL VL]
    ldr z15, [sp, #7, MUL VL]
    add sp, sp, x17
.endm

#ifdef __APPLE__
.globl _sve_dp_vv_s32s8s8
_sve_dp_vv_s32s8s8:
#else
.globl sve_dp_vv_s32s8s8
sve_dp_vv_s32s8s8:
#endif
    preserve_caller_vec
    dup z0.b, #0
    dup z1.b, #0
    dup z8.b, #0
    dup z9.b, #0
    dup z10.b, #0
    dup z11.b, #0
    dup z12.b, #0
    dup z13.b, #0
    dup z14.b, #0
    dup z15.b, #0
    dup z16.b, #0
    dup z17.b, #0
    dup z18.b, #0
    dup z19.b, #0
    dup z20.b, #0
    dup z21.b, #0
    dup z22.b, #0
    dup z23.b, #0
    dup z24.b, #0
    dup z25.b, #0
    dup z26.b, #0
    dup z27.b, #0
    dup z28.b, #0
    dup z29.b, #0
    dup z30.b, #0
    dup z31.b, #0

    ptrue p0.s
.sve.dp.vv.s32s8s8.L1:
    sdot z8.s, z0.b, z1.b
    sdot z9.s, z0.b, z1.b
    sdot z10.s, z0.b, z1.b
    sdot z11.s, z0.b, z1.b
    sdot z12.s, z0.b, z1.b
    sdot z13.s, z0.b, z1.b
    sdot z14.s, z0.b, z1.b
    sdot z15.s, z0.b, z1.b
    sdot z16.s, z0.b, z1.b
    sdot z17.s, z0.b, z1.b
    sdot z18.s, z0.b, z1.b
    sdot z19.s, z0.b, z1.b
    subs x0, x0, #1
    sdot z20.s, z0.b, z1.b
    sdot z21.s, z0.b, z1.b
    sdot z22.s, z0.b, z1.b
    sdot z23.s, z0.b, z1.b
    sdot z24.s, z0.b, z1.b
    sdot z25.s, z0.b, z1.b
    sdot z26.s, z0.b, z1.b
    sdot z27.s, z0.b, z1.b
    sdot z28.s, z0.b, z1.b
    sdot z29.s, z0.b, z1.b
    sdot z30.s, z0.b, z1.b
    sdot z31.s, z0.b, z1.b
    bne .sve.dp.vv.s32s8s8.L1
    restore_caller_vec
    ret


#ifdef __APPLE__
.globl _sve_dp_vs_s32s8s8
_sve_dp_vs_s32s8s8:
#else
.globl sve_dp_vs_s32s8s8
sve_dp_vs_s32s8s8:
#endif
    preserve_caller_vec
    dup z0.b, #0
    dup z1.b, #0
    dup z8.b, #0
    dup z9.b, #0
    dup z10.b, #0
    dup z11.b, #0
    dup z12.b, #0
    dup z13.b, #0
    dup z14.b, #0
    dup z15.b, #0
    dup z16.b, #0
    dup z17.b, #0
    dup z18.b, #0
    dup z19.b, #0
    dup z20.b, #0
    dup z21.b, #0
    dup z22.b, #0
    dup z23.b, #0
    dup z24.b, #0
    dup z25.b, #0
    dup z26.b, #0
    dup z27.b, #0
    dup z28.b, #0
    dup z29.b, #0
    dup z30.b, #0
    dup z31.b, #0

    ptrue p0.s
.sve.dp.vs.s32s8s8.L1:
    sdot z8.s, z0.b, z1.b[0]
    sdot z9.s, z0.b, z1.b[0]
    sdot z10.s, z0.b, z1.b[0]
    sdot z11.s, z0.b, z1.b[0]
    sdot z12.s, z0.b, z1.b[0]
    sdot z13.s, z0.b, z1.b[0]
    sdot z14.s, z0.b, z1.b[0]
    sdot z15.s, z0.b, z1.b[0]
    sdot z16.s, z0.b, z1.b[0]
    sdot z17.s, z0.b, z1.b[0]
    sdot z18.s, z0.b, z1.b[0]
    sdot z19.s, z0.b, z1.b[0]
    subs x0, x0, #1
    sdot z20.s, z0.b, z1.b[0]
    sdot z21.s, z0.b, z1.b[0]
    sdot z22.s, z0.b, z1.b[0]
    sdot z23.s, z0.b, z1.b[0]
    sdot z24.s, z0.b, z1.b[0]
    sdot z25.s, z0.b, z1.b[0]
    sdot z26.s, z0.b, z1.b[0]
    sdot z27.s, z0.b, z1.b[0]
    sdot z28.s, z0.b, z1.b[0]
    sdot z29.s, z0.b, z1.b[0]
    sdot z30.s, z0.b, z1.b[0]
    sdot z31.s, z0.b, z1.b[0]
    bne .sve.dp.vs.s32s8s8.L1
    restore_caller_vec
    ret
    

#ifdef __APPLE__
.globl _sve_dp_vv_u32u8u8
_sve_dp_vv_u32u8u8:
#else
.globl sve_dp_vv_u32u8u8
sve_dp_vv_u32u8u8:
#endif
    preserve_caller_vec
    dup z0.b, #0
    dup z1.b, #0
    dup z8.b, #0
    dup z9.b, #0
    dup z10.b, #0
    dup z11.b, #0
    dup z12.b, #0
    dup z13.b, #0
    dup z14.b, #0
    dup z15.b, #0
    dup z16.b, #0
    dup z17.b, #0
    dup z18.b, #0
    dup z19.b, #0
    dup z20.b, #0
    dup z21.b, #0
    dup z22.b, #0
    dup z23.b, #0
    dup z24.b, #0
    dup z25.b, #0
    dup z26.b, #0
    dup z27.b, #0
    dup z28.b, #0
    dup z29.b, #0
    dup z30.b, #0
    dup z31.b, #0

    ptrue p0.s
.sve.dp.vv.u32u8u8.L1:
    udot z8.s, z0.b, z1.b
    udot z9.s, z0.b, z1.b
    udot z10.s, z0.b, z1.b
    udot z11.s, z0.b, z1.b
    udot z12.s, z0.b, z1.b
    udot z13.s, z0.b, z1.b
    udot z14.s, z0.b, z1.b
    udot z15.s, z0.b, z1.b
    udot z16.s, z0.b, z1.b
    udot z17.s, z0.b, z1.b
    udot z18.s, z0.b, z1.b
    udot z19.s, z0.b, z1.b
    subs x0, x0, #1
    udot z20.s, z0.b, z1.b
    udot z21.s, z0.b, z1.b
    udot z22.s, z0.b, z1.b
    udot z23.s, z0.b, z1.b
    udot z24.s, z0.b, z1.b
    udot z25.s, z0.b, z1.b
    udot z26.s, z0.b, z1.b
    udot z27.s, z0.b, z1.b
    udot z28.s, z0.b, z1.b
    udot z29.s, z0.b, z1.b
    udot z30.s, z0.b, z1.b
    udot z31.s, z0.b, z1.b
    bne .sve.dp.vv.u32u8u8.L1
    restore_caller_vec
    ret


#ifdef __APPLE__
.globl _sve_dp_vs_u32u8u8
_sve_dp_vs_u32u8u8:
#else
.globl sve_dp_vs_u32u8u8
sve_dp_vs_u32u8u8:
#endif
    preserve_caller_vec
    dup z0.b, #0
    dup z1.b, #0
    dup z8.b, #0
    dup z9.b, #0
    dup z10.b, #0
    dup z11.b, #0
    dup z12.b, #0
    dup z13.b, #0
    dup z14.b, #0
    dup z15.b, #0
    dup z16.b, #0
    dup z17.b, #0
    dup z18.b, #0
    dup z19.b, #0
    dup z20.b, #0
    dup z21.b, #0
    dup z22.b, #0
    dup z23.b, #0
    dup z24.b, #0
    dup z25.b, #0
    dup z26.b, #0
    dup z27.b, #0
    dup z28.b, #0
    dup z29.b, #0
    dup z30.b, #0
    dup z31.b, #0

    ptrue p0.s
.sve.dp.vs.u32u8u8.L1:
    udot z8.s, z0.b, z1.b[0]
    udot z9.s, z0.b, z1.b[0]
    udot z10.s, z0.b, z1.b[0]
    udot z11.s, z0.b, z1.b[0]
    udot z12.s, z0.b, z1.b[0]
    udot z13.s, z0.b, z1.b[0]
    udot z14.s, z0.b, z1.b[0]
    udot z15.s, z0.b, z1.b[0]
    udot z16.s, z0.b, z1.b[0]
    udot z17.s, z0.b, z1.b[0]
    udot z18.s, z0.b, z1.b[0]
    udot z19.s, z0.b, z1.b[0]
    subs x0, x0, #1
    udot z20.s, z0.b, z1.b[0]
    udot z21.s, z0.b, z1.b[0]
    udot z22.s, z0.b, z1.b[0]
    udot z23.s, z0.b, z1.b[0]
    udot z24.s, z0.b, z1.b[0]
    udot z25.s, z0.b, z1.b[0]
    udot z26.s, z0.b, z1.b[0]
    udot z27.s, z0.b, z1.b[0]
    udot z28.s, z0.b, z1.b[0]
    udot z29.s, z0.b, z1.b[0]
    udot z30.s, z0.b, z1.b[0]
    udot z31.s, z0.b, z1.b[0]
    bne .sve.dp.vs.u32u8u8.L1
    restore_caller_vec
    ret