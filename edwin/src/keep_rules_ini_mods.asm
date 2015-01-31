%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

gbyte INIClass__LoadedMap, 0, 64

sbyte IsLoadedMap, 0

@REPLACE 0x0045AC58, 0x0045AC5E, ReadMap1
    cmp byte[IsLoadedMap], 1
    jnz .out
    pushad 
    xor edx, edx
    mov eax, INIClass__LoadedMap
    call 0x0043E318 ;Erase the previous loaded map
    popad

.out:
    mov byte[IsLoadedMap], 1
    mov eax, INIClass__LoadedMap
    jmp 0x0045AC5E
@ENDREPLACE

@REPLACE 0x0045AC7D, 0x0045AC83, ReadMap2
    mov eax, INIClass__LoadedMap
    jmp 0x0045AC83
@ENDREPLACE

@REPLACE 0x0045ACA7, 0x0045ACAD, ReadMap3
    mov eax, INIClass__LoadedMap
    jmp 0x0045ACAD
@ENDREPLACE

@REPLACE 0x0045ACDF, 0x0045ACE5, ReadMap4
    mov eax, INIClass__LoadedMap
    jmp 0x0045ACE5
@ENDREPLACE

@REPLACE 0x0045AD04, 0x0045AD0A, ReadMap5
    mov eax, INIClass__LoadedMap
    jmp 0x0045AD0A
@ENDREPLACE

@REPLACE 0x0045AD0F, 0x0045AD15, ReadMap6
    mov eax, INIClass__LoadedMap
    jmp 0x0045AD15
@ENDREPLACE

@REPLACE 0x0045AD4F, 0x0045AD55, ReadMap7
    mov edx, INIClass__LoadedMap
    jmp 0x0045AD55
@ENDREPLACE

@REPLACE 0x0045AD79, 0x0045AD7F, ReadMap8
    mov eax, INIClass__LoadedMap
    jmp 0x0045AD7F
@ENDREPLACE

@REPLACE 0x0045AD9A, 0x0045ADA0, ReadMap9
    mov eax, INIClass__LoadedMap
    jmp 0x0045ADA0
@ENDREPLACE

@REPLACE 0x0045ADAA, 0x0045ADB0, ReadMap10
    mov eax, INIClass__LoadedMap
    jmp 0x0045ADB0
@ENDREPLACE

@CLEAR 0x0045ADE3, 0x90, 0x0045ADE8 ;ReadMap - Do not erase

@REPLACE 0x0045AE6E, 0x0045AE7F, SaveMap1
    cmp byte[IsLoadedMap], 1
    jnz .out
    mov dword[ebp-0x0A0], INIClass__LoadedMap
    jmp 0x0045AE7F
    
.out:
    lea eax, [ebp-0x9C]
    call 0x0043E34C
    mov dword[ebp-0x0A0], eax
    jmp 0x0045AE7F
@ENDREPLACE

@REPLACE 0x0045AEC3, 0x0045AEC9, SaveMap2
    cmp byte[IsLoadedMap], 1
    jnz .out
    mov eax, INIClass__LoadedMap
    jmp 0x0045AEC9
    
.out:
    lea eax, [ebp-0x9C]
    jmp 0x0045AEC9
@ENDREPLACE

@REPLACE 0x0045AEE4, 0x0045AEEA, SaveMap3
    cmp byte[IsLoadedMap], 1
    jnz .out
    mov eax, INIClass__LoadedMap
    jmp 0x0045AEEA
    
.out:
    lea eax, [ebp-0x9C]
    jmp 0x0045AEEA
@ENDREPLACE

@REPLACE 0x0045AEFF, 0x0045AF05, SaveMap4
    cmp byte[IsLoadedMap], 1
    jnz .out
    mov eax, INIClass__LoadedMap
    jmp 0x0045AF05
    
.out:
    lea eax, [ebp-0x9C]
    jmp 0x0045AF05
@ENDREPLACE

@REPLACE 0x0045AF0A, 0x0045AF10, SaveMap5
    cmp byte[IsLoadedMap], 1
    jnz .out
    mov edx, INIClass__LoadedMap
    jmp 0x0045AF10
    
.out:
    lea edx, [ebp-0x9C]
    jmp 0x0045AF10
@ENDREPLACE

@REPLACE 0x0045AF1A, 0x0045AF20, SaveMap6
    cmp byte[IsLoadedMap], 1
    jnz .out
    mov eax, INIClass__LoadedMap
    jmp 0x0045AF20
    
.out:
    lea eax, [ebp-0x9C]
    jmp 0x0045AF20
@ENDREPLACE

@REPLACE 0x0045AF25, 0x0045AF2B, SaveMap7
    cmp byte[IsLoadedMap], 1
    jnz .out
    mov eax, INIClass__LoadedMap
    jmp 0x0045AF2B
    
.out:
    lea eax, [ebp-0x9C]
    jmp 0x0045AF2B
@ENDREPLACE

@REPLACE 0x0045AF8F, 0x0045AF95, SaveMap8
    cmp byte[IsLoadedMap], 1
    jnz .out
    mov eax, INIClass__LoadedMap
    jmp 0x0045AF95
    
.out:
    lea eax, [ebp-0x9C]
    jmp 0x0045AF95
@ENDREPLACE

@REPLACE 0x0045AFA7, 0x0045AFB4, SaveMap9 ;SaveMap - Do not erase
    cmp byte[IsLoadedMap], 1
    jz 0x0045AFB4
    
.out:
    xor edx, edx
    lea eax, [ebp-0x9C]
    call 0x0043E318
    jmp 0x0045AFB4
@ENDREPLACE

@HACK 0x0044690C, NewMapDialogOkClick
    cmp byte[IsLoadedMap], 1
    jnz .out
    pushad 
    xor edx, edx
    mov eax, INIClass__LoadedMap
    call 0x0043E318 ;Erase the previous loaded map
    popad
    mov byte[IsLoadedMap], 0
    
.out:
    call 0x004643FE
    jmp 0x00446911
@ENDHACK
