%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

sstring InternalMapNameBuffer, "", 512

@PATCH 0x00474778 ;no assert
    retn
@ENDPATCH

@SJMP 0x0044B16A, 0x0044B195 ;right click unselect crash

@REPLACE 0x0041963D, 0x00419644, AftermathTileCrash ; Ignore the HILL01 tile, should be fixed later by adding support for the tile
    cmp word[eax+9], 400 ; HILL01
    jnz .out
    mov word[eax+9], 0x0FFFF
    jmp 0x00419657

.out:
    cmp word[eax+9], 0x0FFFF
    je 0x00419657
    jmp 0x00419644
@ENDREPLACE

@REPLACE 0x00442E61, 0x00442E67, InternalNameTooLongCrash
    mov byte[InternalMapNameBuffer], "x"
    mov byte[InternalMapNameBuffer+1], 0
    mov edx, InternalMapNameBuffer
    jmp 0x00442E67
@ENDREPLACE

@REPLACE 0x00442E90, 0x00442E96, InternalNameTooLongCrash1
    mov byte[InternalMapNameBuffer+39], 0
    mov edx, InternalMapNameBuffer
    jmp 0x00442E96
@ENDREPLACE
