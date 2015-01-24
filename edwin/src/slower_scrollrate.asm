%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

cextern ScrollRate

gbyte SlowerScrollRate, 1

@REPLACE 0x0045B81B, 0x0045B821, SlowerScrolling
    mov eax, dword[eax+0x4B0938]
    cmp byte[SlowerScrollRate], 0
    jz 0x0045B821
    cmp dword[ScrollRate], 0 ;Do not slow the scroll speed down on the fastest scroll setting
    jz 0x0045B821
    cmp eax, 32
    jg .divide
    mov eax, 2 ;if ScrollDistance is 32 or smaller then set it to the lowest possible, 2
    jmp 0x0045B821
	
.divide: ;divide the scroll distance by 8
    push edx
    push ecx
    xor edx, edx
    mov ecx, 8
    div ecx
    pop ecx
    pop edx
    jmp 0x0045B821
@ENDREPLACE
