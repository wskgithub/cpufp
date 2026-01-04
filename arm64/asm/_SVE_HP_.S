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
.globl _sve_fmla_vs_fp16fp16fp16
_sve_fmla_vs_fp16fp16fp16:
#else
.globl sve_fmla_vs_fp16fp16fp16
sve_fmla_vs_fp16fp16fp16:
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

.sve.fmla.vs.fp16fp16fp16.L1:
    fmla z8.h, z0.h, z1.h[0]
    fmla z9.h, z0.h, z1.h[0]
    fmla z10.h, z0.h, z1.h[0]
    fmla z11.h, z0.h, z1.h[0]
    fmla z12.h, z0.h, z1.h[0]
    fmla z13.h, z0.h, z1.h[0]
    fmla z14.h, z0.h, z1.h[0]
    fmla z15.h, z0.h, z1.h[0]
    fmla z16.h, z0.h, z1.h[0]
    fmla z17.h, z0.h, z1.h[0]
    fmla z18.h, z0.h, z1.h[0]
    fmla z19.h, z0.h, z1.h[0]
    subs x0, x0, #1
    fmla z20.h, z0.h, z1.h[0]
    fmla z21.h, z0.h, z1.h[0]
    fmla z22.h, z0.h, z1.h[0]
    fmla z23.h, z0.h, z1.h[0]
    fmla z24.h, z0.h, z1.h[0]
    fmla z25.h, z0.h, z1.h[0]
    fmla z26.h, z0.h, z1.h[0]
    fmla z27.h, z0.h, z1.h[0]
    fmla z28.h, z0.h, z1.h[0]
    fmla z29.h, z0.h, z1.h[0]
    fmla z30.h, z0.h, z1.h[0]
    fmla z31.h, z0.h, z1.h[0]
    bne .sve.fmla.vs.fp16fp16fp16.L1
    restore_caller_vec
    ret

#ifdef __APPLE__
.globl _sve_fmla_vv_fp16fp16fp16
_sve_fmla_vv_fp16fp16fp16:
#else
.globl sve_fmla_vv_fp16fp16fp16
sve_fmla_vv_fp16fp16fp16:
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

    ptrue p0.h
.sve.fmla.vv.fp16fp16fp16.L1:
    fmla z8.h, p0/m, z0.h, z1.h
    fmla z9.h, p0/m, z0.h, z1.h
    fmla z10.h, p0/m, z0.h, z1.h
    fmla z11.h, p0/m, z0.h, z1.h
    fmla z12.h, p0/m, z0.h, z1.h
    fmla z13.h, p0/m, z0.h, z1.h
    fmla z14.h, p0/m, z0.h, z1.h
    fmla z15.h, p0/m, z0.h, z1.h
    fmla z16.h, p0/m, z0.h, z1.h
    fmla z17.h, p0/m, z0.h, z1.h
    fmla z18.h, p0/m, z0.h, z1.h
    fmla z19.h, p0/m, z0.h, z1.h
    subs x0, x0, #1
    fmla z20.h, p0/m, z0.h, z1.h
    fmla z21.h, p0/m, z0.h, z1.h
    fmla z22.h, p0/m, z0.h, z1.h
    fmla z23.h, p0/m, z0.h, z1.h
    fmla z24.h, p0/m, z0.h, z1.h
    fmla z25.h, p0/m, z0.h, z1.h
    fmla z26.h, p0/m, z0.h, z1.h
    fmla z27.h, p0/m, z0.h, z1.h
    fmla z28.h, p0/m, z0.h, z1.h
    fmla z29.h, p0/m, z0.h, z1.h
    fmla z30.h, p0/m, z0.h, z1.h
    fmla z31.h, p0/m, z0.h, z1.h
    bne .sve.fmla.vv.fp16fp16fp16.L1
    restore_caller_vec
    ret
