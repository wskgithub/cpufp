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
.globl _sve_bfmmla_fp32bf16bf16
_sve_bfmmla_fp32bf16bf16:
#else
.globl sve_bfmmla_fp32bf16bf16
sve_bfmmla_fp32bf16bf16:
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
.sve.bfmmla.fp32bf16bf16.L1:
    bfmmla z8.s, z0.h, z1.h
    bfmmla z9.s, z0.h, z1.h
    bfmmla z10.s, z0.h, z1.h
    bfmmla z11.s, z0.h, z1.h
    bfmmla z12.s, z0.h, z1.h
    bfmmla z13.s, z0.h, z1.h
    bfmmla z14.s, z0.h, z1.h
    bfmmla z15.s, z0.h, z1.h
    bfmmla z16.s, z0.h, z1.h
    bfmmla z17.s, z0.h, z1.h
    bfmmla z18.s, z0.h, z1.h
    bfmmla z19.s, z0.h, z1.h
    subs x0, x0, #1
    bfmmla z20.s, z0.h, z1.h
    bfmmla z21.s, z0.h, z1.h
    bfmmla z22.s, z0.h, z1.h
    bfmmla z23.s, z0.h, z1.h
    bfmmla z24.s, z0.h, z1.h
    bfmmla z25.s, z0.h, z1.h
    bfmmla z26.s, z0.h, z1.h
    bfmmla z27.s, z0.h, z1.h
    bfmmla z28.s, z0.h, z1.h
    bfmmla z29.s, z0.h, z1.h
    bfmmla z30.s, z0.h, z1.h
    bfmmla z31.s, z0.h, z1.h
    bne .sve.bfmmla.fp32bf16bf16.L1
    restore_caller_vec
    ret

#ifdef __APPLE__
.globl _sve_dp_vs_fp32bf16bf16
_sve_dp_vs_fp32bf16bf16:
#else
.globl sve_dp_vs_fp32bf16bf16
sve_dp_vs_fp32bf16bf16:
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
.sve.dp.vs.fp32bf16bf16.L1:
    bfdot z8.s, z0.h, z1.h[0]
    bfdot z9.s, z0.h, z1.h[0]
    bfdot z10.s, z0.h, z1.h[0]
    bfdot z11.s, z0.h, z1.h[0]
    bfdot z12.s, z0.h, z1.h[0]
    bfdot z13.s, z0.h, z1.h[0]
    bfdot z14.s, z0.h, z1.h[0]
    bfdot z15.s, z0.h, z1.h[0]
    bfdot z16.s, z0.h, z1.h[0]
    bfdot z17.s, z0.h, z1.h[0]
    bfdot z18.s, z0.h, z1.h[0]
    bfdot z19.s, z0.h, z1.h[0]
    subs x0, x0, #1
    bfdot z20.s, z0.h, z1.h[0]
    bfdot z21.s, z0.h, z1.h[0]
    bfdot z22.s, z0.h, z1.h[0]
    bfdot z23.s, z0.h, z1.h[0]
    bfdot z24.s, z0.h, z1.h[0]
    bfdot z25.s, z0.h, z1.h[0]
    bfdot z26.s, z0.h, z1.h[0]
    bfdot z27.s, z0.h, z1.h[0]
    bfdot z28.s, z0.h, z1.h[0]
    bfdot z29.s, z0.h, z1.h[0]
    bfdot z30.s, z0.h, z1.h[0]
    bfdot z31.s, z0.h, z1.h[0]
    bne .sve.dp.vs.fp32bf16bf16.L1
    restore_caller_vec
    ret

#ifdef __APPLE__
.globl _sve_dp_vv_fp32bf16bf16
_sve_dp_vv_fp32bf16bf16:
#else
.globl sve_dp_vv_fp32bf16bf16
sve_dp_vv_fp32bf16bf16:
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
.sve.dp.vv.fp32bf16bf16.L1:
    bfdot z8.s, z0.h, z1.h
    bfdot z9.s, z0.h, z1.h
    bfdot z10.s, z0.h, z1.h
    bfdot z11.s, z0.h, z1.h
    bfdot z12.s, z0.h, z1.h
    bfdot z13.s, z0.h, z1.h
    bfdot z14.s, z0.h, z1.h
    bfdot z15.s, z0.h, z1.h
    bfdot z16.s, z0.h, z1.h
    bfdot z17.s, z0.h, z1.h
    bfdot z18.s, z0.h, z1.h
    bfdot z19.s, z0.h, z1.h
    subs x0, x0, #1
    bfdot z20.s, z0.h, z1.h
    bfdot z21.s, z0.h, z1.h
    bfdot z22.s, z0.h, z1.h
    bfdot z23.s, z0.h, z1.h
    bfdot z24.s, z0.h, z1.h
    bfdot z25.s, z0.h, z1.h
    bfdot z26.s, z0.h, z1.h
    bfdot z27.s, z0.h, z1.h
    bfdot z28.s, z0.h, z1.h
    bfdot z29.s, z0.h, z1.h
    bfdot z30.s, z0.h, z1.h
    bfdot z31.s, z0.h, z1.h
    bne .sve.dp.vv.fp32bf16bf16.L1
    restore_caller_vec
    ret