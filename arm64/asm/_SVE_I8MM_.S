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
.globl _sve_mmla_s32s8s8
_sve_mmla_s32s8s8:
#else
.globl sve_mmla_s32s8s8
sve_mmla_s32s8s8:
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

.sve.mmla.s32s8s8.L1:
    smmla z8.s, z0.b, z1.b
    smmla z9.s, z0.b, z1.b
    smmla z10.s, z0.b, z1.b
    smmla z11.s, z0.b, z1.b
    smmla z12.s, z0.b, z1.b
    smmla z13.s, z0.b, z1.b
    smmla z14.s, z0.b, z1.b
    smmla z15.s, z0.b, z1.b
    smmla z16.s, z0.b, z1.b
    smmla z17.s, z0.b, z1.b
    smmla z18.s, z0.b, z1.b
    smmla z19.s, z0.b, z1.b
    subs x0, x0, #1
    smmla z20.s, z0.b, z1.b
    smmla z21.s, z0.b, z1.b
    smmla z22.s, z0.b, z1.b
    smmla z23.s, z0.b, z1.b
    smmla z24.s, z0.b, z1.b
    smmla z25.s, z0.b, z1.b
    smmla z26.s, z0.b, z1.b
    smmla z27.s, z0.b, z1.b
    smmla z28.s, z0.b, z1.b
    smmla z29.s, z0.b, z1.b
    smmla z30.s, z0.b, z1.b
    smmla z31.s, z0.b, z1.b
    bne .sve.mmla.s32s8s8.L1
    restore_caller_vec
    ret

#ifdef __APPLE__
.globl _sve_mmla_u32u8u8
_sve_mmla_u32u8u8:
#else
.globl sve_mmla_u32u8u8
sve_mmla_u32u8u8:
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

.sve.mmla.u32u8u8.L1:
    ummla z8.s, z0.b, z1.b
    ummla z9.s, z0.b, z1.b
    ummla z10.s, z0.b, z1.b
    ummla z11.s, z0.b, z1.b
    ummla z12.s, z0.b, z1.b
    ummla z13.s, z0.b, z1.b
    ummla z14.s, z0.b, z1.b
    ummla z15.s, z0.b, z1.b
    ummla z16.s, z0.b, z1.b
    ummla z17.s, z0.b, z1.b
    ummla z18.s, z0.b, z1.b
    ummla z19.s, z0.b, z1.b
    subs x0, x0, #1
    ummla z20.s, z0.b, z1.b
    ummla z21.s, z0.b, z1.b
    ummla z22.s, z0.b, z1.b
    ummla z23.s, z0.b, z1.b
    ummla z24.s, z0.b, z1.b
    ummla z25.s, z0.b, z1.b
    ummla z26.s, z0.b, z1.b
    ummla z27.s, z0.b, z1.b
    ummla z28.s, z0.b, z1.b
    ummla z29.s, z0.b, z1.b
    ummla z30.s, z0.b, z1.b
    ummla z31.s, z0.b, z1.b
    bne .sve.mmla.u32u8u8.L1
    restore_caller_vec
    ret

#ifdef __APPLE__
.globl _sve_mmla_s32u8s8
_sve_mmla_s32u8s8:
#else
.globl sve_mmla_s32u8s8
sve_mmla_s32u8s8:
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

.sve.mmla.s32u8s8.L1:
    usmmla z8.s, z0.b, z1.b
    usmmla z9.s, z0.b, z1.b
    usmmla z10.s, z0.b, z1.b
    usmmla z11.s, z0.b, z1.b
    usmmla z12.s, z0.b, z1.b
    usmmla z13.s, z0.b, z1.b
    usmmla z14.s, z0.b, z1.b
    usmmla z15.s, z0.b, z1.b
    usmmla z16.s, z0.b, z1.b
    usmmla z17.s, z0.b, z1.b
    usmmla z18.s, z0.b, z1.b
    usmmla z19.s, z0.b, z1.b
    subs x0, x0, #1
    usmmla z20.s, z0.b, z1.b
    usmmla z21.s, z0.b, z1.b
    usmmla z22.s, z0.b, z1.b
    usmmla z23.s, z0.b, z1.b
    usmmla z24.s, z0.b, z1.b
    usmmla z25.s, z0.b, z1.b
    usmmla z26.s, z0.b, z1.b
    usmmla z27.s, z0.b, z1.b
    usmmla z28.s, z0.b, z1.b
    usmmla z29.s, z0.b, z1.b
    usmmla z30.s, z0.b, z1.b
    usmmla z31.s, z0.b, z1.b
    bne .sve.mmla.s32u8s8.L1
    restore_caller_vec
    ret


#ifdef __APPLE__
.globl _sve_dp_vs_s32s8u8
_sve_dp_vs_s32s8u8:
#else
.globl sve_dp_vs_s32s8u8
sve_dp_vs_s32s8u8:
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

.sve.dp.vs.s32s8u8.L1:
    usdot z8.s, z0.b, z1.b[0]
    usdot z9.s, z0.b, z1.b[0]
    usdot z10.s, z0.b, z1.b[0]
    usdot z11.s, z0.b, z1.b[0]
    usdot z12.s, z0.b, z1.b[0]
    usdot z13.s, z0.b, z1.b[0]
    usdot z14.s, z0.b, z1.b[0]
    usdot z15.s, z0.b, z1.b[0]
    usdot z16.s, z0.b, z1.b[0]
    usdot z17.s, z0.b, z1.b[0]
    usdot z18.s, z0.b, z1.b[0]
    usdot z19.s, z0.b, z1.b[0]
    subs x0, x0, #1
    usdot z20.s, z0.b, z1.b[0]
    usdot z21.s, z0.b, z1.b[0]
    usdot z22.s, z0.b, z1.b[0]
    usdot z23.s, z0.b, z1.b[0]
    usdot z24.s, z0.b, z1.b[0]
    usdot z25.s, z0.b, z1.b[0]
    usdot z26.s, z0.b, z1.b[0]
    usdot z27.s, z0.b, z1.b[0]
    usdot z28.s, z0.b, z1.b[0]
    usdot z29.s, z0.b, z1.b[0]
    usdot z30.s, z0.b, z1.b[0]
    usdot z31.s, z0.b, z1.b[0]
    bne .sve.dp.vs.s32s8u8.L1
    restore_caller_vec
    ret
    
#ifdef __APPLE__
.globl _sve_dp_vs_s32u8s8
_sve_dp_vs_s32u8s8:
#else
.globl sve_dp_vs_s32u8s8
sve_dp_vs_s32u8s8:
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

.sve.dp.vs.s32u8s8.L1:
    usdot z8.s, z0.b, z1.b[0]
    usdot z9.s, z0.b, z1.b[0]
    usdot z10.s, z0.b, z1.b[0]
    usdot z11.s, z0.b, z1.b[0]
    usdot z12.s, z0.b, z1.b[0]
    usdot z13.s, z0.b, z1.b[0]
    usdot z14.s, z0.b, z1.b[0]
    usdot z15.s, z0.b, z1.b[0]
    usdot z16.s, z0.b, z1.b[0]
    usdot z17.s, z0.b, z1.b[0]
    usdot z18.s, z0.b, z1.b[0]
    usdot z19.s, z0.b, z1.b[0]
    subs x0, x0, #1
    usdot z20.s, z0.b, z1.b[0]
    usdot z21.s, z0.b, z1.b[0]
    usdot z22.s, z0.b, z1.b[0]
    usdot z23.s, z0.b, z1.b[0]
    usdot z24.s, z0.b, z1.b[0]
    usdot z25.s, z0.b, z1.b[0]
    usdot z26.s, z0.b, z1.b[0]
    usdot z27.s, z0.b, z1.b[0]
    usdot z28.s, z0.b, z1.b[0]
    usdot z29.s, z0.b, z1.b[0]
    usdot z30.s, z0.b, z1.b[0]
    usdot z31.s, z0.b, z1.b[0]
    bne .sve.dp.vs.s32u8s8.L1
    restore_caller_vec
    ret

#ifdef __APPLE__
.globl _sve_dp_vv_s32u8s8
_sve_dp_vv_s32u8s8:
#else
.globl sve_dp_vv_s32u8s8
sve_dp_vv_s32u8s8:
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

.sve.dp.vv.s32u8s8.L1:
    usdot z8.s, z0.b, z1.b
    usdot z9.s, z0.b, z1.b
    usdot z10.s, z0.b, z1.b
    usdot z11.s, z0.b, z1.b
    usdot z12.s, z0.b, z1.b
    usdot z13.s, z0.b, z1.b
    usdot z14.s, z0.b, z1.b
    usdot z15.s, z0.b, z1.b
    usdot z16.s, z0.b, z1.b
    usdot z17.s, z0.b, z1.b
    usdot z18.s, z0.b, z1.b
    usdot z19.s, z0.b, z1.b
    subs x0, x0, #1
    usdot z20.s, z0.b, z1.b
    usdot z21.s, z0.b, z1.b
    usdot z22.s, z0.b, z1.b
    usdot z23.s, z0.b, z1.b
    usdot z24.s, z0.b, z1.b
    usdot z25.s, z0.b, z1.b
    usdot z26.s, z0.b, z1.b
    usdot z27.s, z0.b, z1.b
    usdot z28.s, z0.b, z1.b
    usdot z29.s, z0.b, z1.b
    usdot z30.s, z0.b, z1.b
    usdot z31.s, z0.b, z1.b
    bne .sve.dp.vv.s32u8s8.L1
    restore_caller_vec
    ret