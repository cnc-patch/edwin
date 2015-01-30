%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

cextern MapInfoStruct
cextern LoadBlankMap
cextern LoadMapFile
cextern strcpy
cextern strlen

sstring MapPath, "", 512

@HACK 0x0043C592, LoadMapOnStartup
    cmp byte[MapPath], 0
    jz .out
    mov edx, MapPath
    mov eax, MapInfoStruct
    call LoadMapFile
    jmp 0x0043C5A6
    
.out:
    mov ebx, 126 ;blank map width
    mov edx, 126 ;blank map height
    mov eax, MapInfoStruct
    call LoadBlankMap
    jmp 0x0043C5A6
@ENDHACK

@REPLACE 0x00496A7F, 0x00496A87, CopyCommandLine
    and edx, 0x000000FF
    jnz 0x00496A46

    pushad
    mov edx, eax
    cmp byte[edx], 0x22
    jnz .DoNotTrim
    inc edx
    
.DoNotTrim:
    mov eax, MapPath
    call strcpy
    
    mov eax, MapPath
    call strlen
    cmp eax, 0
    jz .out
    add eax, MapPath
    dec eax
    cmp byte[eax], 0x22
    jnz .out
    mov byte[eax], 0
    
.out:
    popad
    jmp 0x00496A87
@ENDREPLACE
