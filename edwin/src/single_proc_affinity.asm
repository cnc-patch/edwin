%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

cextern _imp__LoadLibraryA
cextern _imp__GetProcAddress
cextern _imp__GetCurrentProcess

gbyte SingleProcAffinity, 1

sstring Kernel32Dll, "Kernel32.dll"
sstring SetProcessAffinityMaskString, "SetProcessAffinityMask"
sint SetProcessAffinityMask, 0

@REPLACE 0x0046092F, 0x00460935, SetSingleProcAffinity
    mov ebx, dword[0x004AF944]
    
    cmp byte[SingleProcAffinity], 1
    jnz 0x00460935
    
    pushad
    push Kernel32Dll
    call [_imp__LoadLibraryA]
    test eax, eax
    jz .out
    push SetProcessAffinityMaskString
    push eax
    call [_imp__GetProcAddress]
    test eax, eax
    jz .out
    mov [SetProcessAffinityMask], eax
    push 1
    call [_imp__GetCurrentProcess]
    push eax
    call [SetProcessAffinityMask]
    
.out:
    popad
    jmp 0x00460935
@ENDREPLACE
