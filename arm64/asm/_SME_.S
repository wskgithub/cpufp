.align 4

.macro preserve_caller_vec
#ifdef __APPLE__
    smstart sm
#endif
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
#ifdef __APPLE__
    smstop sm
#endif
.endm

#ifdef __APPLE__
.globl _sve_fmla_vv_f32f32f32
_sve_fmla_vv_f32f32f32:
#else
.globl sve_fmla_vv_f32f32f32
sve_fmla_vv_f32f32f32:
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
.sve.fmla.vv.f32f32f32.L1:
    fmla z8.s, p0/m, z0.s, z1.s
    fmla z9.s, p0/m, z0.s, z1.s
    fmla z10.s, p0/m, z0.s, z1.s
    fmla z11.s, p0/m, z0.s, z1.s
    fmla z12.s, p0/m, z0.s, z1.s
    fmla z13.s, p0/m, z0.s, z1.s
    fmla z14.s, p0/m, z0.s, z1.s
    fmla z15.s, p0/m, z0.s, z1.s
    fmla z16.s, p0/m, z0.s, z1.s
    fmla z17.s, p0/m, z0.s, z1.s
    fmla z18.s, p0/m, z0.s, z1.s
    fmla z19.s, p0/m, z0.s, z1.s
    subs x0, x0, #1
    fmla z20.s, p0/m, z0.s, z1.s
    fmla z21.s, p0/m, z0.s, z1.s
    fmla z22.s, p0/m, z0.s, z1.s
    fmla z23.s, p0/m, z0.s, z1.s
    fmla z24.s, p0/m, z0.s, z1.s
    fmla z25.s, p0/m, z0.s, z1.s
    fmla z26.s, p0/m, z0.s, z1.s
    fmla z27.s, p0/m, z0.s, z1.s
    fmla z28.s, p0/m, z0.s, z1.s
    fmla z29.s, p0/m, z0.s, z1.s
    fmla z30.s, p0/m, z0.s, z1.s
    fmla z31.s, p0/m, z0.s, z1.s
    bne .sve.fmla.vv.f32f32f32.L1
    restore_caller_vec
    ret