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
.globl _sve_fmla_vv_f16f16f16
_sve_fmla_vv_f16f16f16:
#else
.globl sve_fmla_vv_f16f16f16
sve_fmla_vv_f16f16f16:
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
.sve.fmla.vv.f16f16f16.L1:
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
    bne .sve.fmla.vv.f16f16f16.L1
    restore_caller_vec
    ret

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


#ifdef __APPLE__
.globl _sve_fmla_vv_f64f64f64
_sve_fmla_vv_f64f64f64:
#else
.globl sve_fmla_vv_f64f64f64
sve_fmla_vv_f64f64f64:
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

    ptrue p0.d
.sve.fmla.vv.f64f64f64.L1:
    fmla z8.d, p0/m, z0.d, z1.d
    fmla z9.d, p0/m, z0.d, z1.d
    fmla z10.d, p0/m, z0.d, z1.d
    fmla z11.d, p0/m, z0.d, z1.d
    fmla z12.d, p0/m, z0.d, z1.d
    fmla z13.d, p0/m, z0.d, z1.d
    fmla z14.d, p0/m, z0.d, z1.d
    fmla z15.d, p0/m, z0.d, z1.d
    fmla z16.d, p0/m, z0.d, z1.d
    fmla z17.d, p0/m, z0.d, z1.d
    fmla z18.d, p0/m, z0.d, z1.d
    fmla z19.d, p0/m, z0.d, z1.d
    subs x0, x0, #1
    fmla z20.d, p0/m, z0.d, z1.d
    fmla z21.d, p0/m, z0.d, z1.d
    fmla z22.d, p0/m, z0.d, z1.d
    fmla z23.d, p0/m, z0.d, z1.d
    fmla z24.d, p0/m, z0.d, z1.d
    fmla z25.d, p0/m, z0.d, z1.d
    fmla z26.d, p0/m, z0.d, z1.d
    fmla z27.d, p0/m, z0.d, z1.d
    fmla z28.d, p0/m, z0.d, z1.d
    fmla z29.d, p0/m, z0.d, z1.d
    fmla z30.d, p0/m, z0.d, z1.d
    fmla z31.d, p0/m, z0.d, z1.d
    bne .sve.fmla.vv.f64f64f64.L1
    restore_caller_vec
    ret
    
