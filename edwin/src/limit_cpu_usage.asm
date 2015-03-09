%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern MainLoop
cextern _imp__Sleep

gbyte LimitCpuUsage, 1

hack 0x0041F3AC 
    cmp byte[LimitCpuUsage], 1
    jnz .out
    push 8
    call [_imp__Sleep]
    
.out:
    call MainLoop
    jmp 0x0041F3B1
    