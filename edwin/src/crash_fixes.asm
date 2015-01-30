%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

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
