%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

cextern strncpy

@PATCH 0x00442E78 ;alloc more memory
    mov eax, 320
@ENDPATCH

@REPLACE 0x00442E9E, 0x00442EAF, LongerFilenames
    mov ebx, 256
    lea edx, [ebp-0x116]
    mov eax, dword[ebp-0x14]
    add eax, 0x3E
    call strncpy
    jmp 0x00442EAF
@ENDREPLACE

;The filename is now saved at a different position, we have to adjust it
@HACK 0x00442702, LoadMap
    mov edx, dword[eax]
    add edx, 0x3E
    jmp 0x00442707
@ENDHACK

@HACK 0x00442B0D, DeleteMap
    mov eax, dword[eax]
    add eax, 0x3E
    jmp 0x00442B12
@ENDHACK

@HACK 0x00442992, SaveMap1
    mov eax, dword[eax]
    add eax, 0x3E
    jmp 0x00442997
@ENDHACK

@HACK 0x00442905, SaveMap2
    mov eax, dword[eax]
    add eax, 0x3E
    jmp 0x0044290A
@ENDHACK
