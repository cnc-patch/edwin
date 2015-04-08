%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern MainLoop
cextern _imp__Sleep

gbyte LimitCpuUsage, 1

hack 0x0041F3AC ;main editor loop
    cmp byte[LimitCpuUsage], 1
    jnz .out
    push 8
    call [_imp__Sleep]
    
.out:
    call MainLoop
    jmp 0x0041F3B1

    
hack 0x00430D24, 0x00430D2E ;options dialog
    cmp byte[LimitCpuUsage], 1
    jnz .out
    push 8
    call [_imp__Sleep]
    
.out:
    cmp dword[ebp-0x10], 0
    je 0x0043186C
    jmp 0x00430D2E

    
hack 0x0044FCA6, 0x0044FCAD ;MessageBox
    cmp byte[LimitCpuUsage], 1
    jnz .out
    push 8
    call [_imp__Sleep]
    
.out:
    cmp dword[ebp-0x41C], 0
    jmp 0x0044FCAD

    
hack 0x004489B2, 0x004489BC ;tile browser dialog
    cmp byte[LimitCpuUsage], 1
    jnz .out
    push 8
    call [_imp__Sleep]
    
.out:
    cmp dword[ebp-0x2C], 0
    je 0x004492CA
    jmp 0x004489BC
    
    
hack 0x00442320, 0x0044232A ;Map Load/Save/Delete dialog
    cmp byte[LimitCpuUsage], 1
    jnz .out
    push 8
    call [_imp__Sleep]
    
.out:
    cmp dword[ebp-0x10], 0
    je 0x00442C69
    jmp 0x0044232A


hack 0x004320A6, 0x004320B0 ;new map dialog
    cmp byte[LimitCpuUsage], 1
    jnz .out
    push 8
    call [_imp__Sleep]
    
.out:
    cmp dword[ebp-8], 0
    je 0x00432944
    jmp 0x004320B0

    
hack 0x00432E4B, 0x00432E55 ;modify map info dialog
    cmp byte[LimitCpuUsage], 1
    jnz .out
    push 8
    call [_imp__Sleep]
    
.out:
    cmp dword[ebp-8], 0
    je 0x004336F0
    jmp 0x00432E55

    
hack 0x00433D4C, 0x00433D56 ;change scroll rate dialog
    cmp byte[LimitCpuUsage], 1
    jnz .out
    push 8
    call [_imp__Sleep]
    
.out:
    cmp dword[ebp-0x0C], 0
    je 0x004342A8
    jmp 0x00433D56

    
hack 0x0044E081, 0x0044E087 ;right click context menu
    cmp byte[LimitCpuUsage], 1
    jnz .out
    push 8
    call [_imp__Sleep]
    
.out:
    cmp dword[ebp-0x18], -1
    jne 0x0044E0CC
    jmp 0x0044E087
