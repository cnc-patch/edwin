%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

cextern FillSelectedArea
cextern MapInfoStruct
cextern SelectedAreaTopLeftCell
cextern SelectedAreaBottomRightCell

sbyte MapCut, 0

@REPLACE 0x0044A24E, 0x0044A254, CtrlXPressed
    je .cut
    jmp 0x0044A254

.cut:
    cmp dword[SelectedAreaTopLeftCell], 0
    jz 0x0044A19A
    cmp dword[SelectedAreaBottomRightCell], 0
    jz 0x0044A19A
    mov byte[MapCut], 1
    jmp 0x0044A162
@ENDREPLACE

@REPLACE 0x0044AB71, 0x0044AB76, ClearAreaAfterCopy
    mov dword[0x004D7D25], eax
    
    cmp byte[MapCut], 1
    jnz 0x0044AB76
    
    mov byte[MapCut], 0
    xor edx, edx ; 0 = clear ground
    mov eax, MapInfoStruct
    call FillSelectedArea
    jmp 0x0044AB76
@ENDREPLACE
