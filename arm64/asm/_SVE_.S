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
.globl _sve_fmla_vv_f16f16f16
_sve_fmla_vv_f16f16f16:
#else
.globl sve_fmla_vv_f16f16f16
sve_fmla_vv_f16f16f16:
#endif
    preserve_caller_vec
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
    restore_caller_vec
    ret

#ifdef __APPLE__
.globl _sve_fmla_vs_f32f32f32
_sve_fmla_vs_f32f32f32:
#else
.globl sve_fmla_vs_f32f32f32
sve_fmla_vs_f32f32f32:
#endif
    preserve_caller_vec
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
    restore_caller_vec
    ret
    

#ifdef __APPLE__
.globl _sve_fmla_vs_f64f64f64
_sve_fmla_vs_f64f64f64:
#else
.globl sve_fmla_vs_f64f64f64
sve_fmla_vs_f64f64f64:
#endif
    preserve_caller_vec
    restore_caller_vec
    ret
