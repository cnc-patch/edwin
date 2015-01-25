%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

cextern ScreenHeight
cextern ScreenWidth
cextern SidebarButtonShoreX
cextern SidebarButtonRiverX
cextern SidebarButtonRoadX
cextern SidebarButtonRidgesX
cextern SidebarButtonTreesX
cextern SidebarButtonDebrisX
cextern SidebarButtonLeftArrowX
cextern SidebarButtonRightArrowX
cextern SidebarButtonTileBrowserX
cextern SidebarButtonFlagX
cextern SidebarButtonTileSelectionX
cextern SidebarButtonTerrainClearX
cextern SidebarButtonTerrainOreX
cextern SidebarButtonTerrainGemX
cextern SidebarButtonTerrainWaterX

gint HighResAddedWidth, 0
gint HighResAddedHeight, 0
gint HighResWidthInTiles, 20

@REPLACE 0x00460929, 0x0046092F, InitHighRes
    pushad
    
    mov eax, dword[ScreenWidth]
    sub eax, 160
    mov ebx, 24
    xor edx, edx
    div ebx
    mov dword[HighResWidthInTiles], eax
    xor edx, edx
    mov ebx, 24
    mul ebx
    add eax, 160
    sub eax, 640
    mov dword[HighResAddedWidth], eax
    
    mov eax, dword[ScreenHeight]
    sub eax, 400
    mov dword[HighResAddedHeight], eax
    
    popad
    mov ecx, dword[ScreenHeight]
    jmp 0x0046092F
@ENDREPLACE

@CLEAR 0x00461193, 0x90, 0x00461198 ; Ignore [Options]Resolution= in redalert.ini
@CLEAR 0x00460D1C, 0x90, 0x00460D26 ; Do not change the height to 400
@SJMP 0x00460D35, 0x00460D79 ; Do not use black bars with 480 height

@REPLACE 0x00460D37, 0x00460D41, AdjustBuffer1
    push dword[ScreenHeight]
    push dword[ScreenWidth]
    jmp 0x00460D41
@ENDREPLACE

@REPLACE 0x00460D57, 0x00460D61, AdjustBuffer2
    push dword[ScreenHeight]
    push dword[ScreenWidth]
    jmp 0x00460D61
@ENDREPLACE

@REPLACE 0x00460D79, 0x00460D83, AdjustBuffer1x
    push dword[ScreenHeight]
    push dword[ScreenWidth]
    jmp 0x00460D83
@ENDREPLACE

@REPLACE 0x00460D96, 0x00460DA0, AdjustBuffer2x
    push dword[ScreenHeight]
    push dword[ScreenWidth]
    jmp 0x00460DA0
@ENDREPLACE

@HACK 0x0044985B, AdjustTacticalAreaHeight
    add eax, dword[HighResAddedHeight]
    mov dword[0x4EBE70], eax
    jmp 0x00449860
@ENDHACK

@HACK 0x0044984C, AdjustTacticalAreaWidth
    add eax, dword[HighResAddedWidth]
    mov dword[0x4EBE6C], eax
    jmp 0x00449851
@ENDHACK

@HACK 0x00457972, AdjustSidebarBackground1
    mov ebx, dword[HighResAddedWidth]
    add ebx, 480
    jmp 0x00457977
@ENDHACK

@HACK 0x0045D7AD, AdjustSidebarBackground2
    mov ebx, dword[HighResAddedWidth]
    add ebx, 480
    jmp 0x0045D7B2
@ENDHACK

@HACK 0x0045D7EE, AdjustSidebarBackground3
    mov ebx, dword[HighResAddedWidth]
    add ebx, 480
    jmp 0x0045D7F3
@ENDHACK

@HACK 0x0045D912, AdjustSidebarTileSelectionBorder
    mov eax, dword[HighResAddedWidth]
    add eax, 487
    jmp 0x0045D917
@ENDHACK

@HACK 0x0045D935, AdjustSidebarTileSelectionBackground
    mov eax, dword[HighResAddedWidth]
    add eax, 487
    jmp 0x0045D93A
@ENDHACK

@HACK 0x0045D957, AdjustSidebarTileSelectionSelectedTile
    mov edx, dword[HighResAddedWidth]
    add edx, 488
    jmp 0x0045D95C
@ENDHACK

@HACK 0x00422FCF, AdjustOptionsMenuWidth1
    mov eax, dword[HighResAddedWidth]
    add eax, 640
    jmp 0x00422FD4
@ENDHACK

@HACK 0x00422FEC, AdjustOptionsMenuWidth2
    mov eax, dword[HighResAddedWidth]
    add eax, 640
    jmp 0x00422FF1
@ENDHACK

@HACK 0x00422FFD, AdjustOptionsMenuHeight1
    mov eax, dword[HighResAddedHeight]
    add eax, 400
    jmp 0x00423002
@ENDHACK

@HACK 0x0042301A, AdjustOptionsMenuHeight2
    mov eax, dword[HighResAddedHeight]
    add eax, 400
    jmp 0x0042301F
@ENDHACK

@HACK 0x0045799F, AdjustMiniMapBackground
    mov eax, dword[HighResAddedWidth]
    add eax, 494
    jmp 0x004579A4
@ENDHACK

@HACK 0x0045DEAB, AdjustCellWidth
    mov eax, dword[HighResWidthInTiles]
    mov ebx, 8
    jmp 0x0045DEB0
@ENDHACK

@HACK 0x0045D6C2, AdjustSidebarButtons
    mov ecx, dword[HighResAddedWidth]
    add dword[SidebarButtonShoreX], ecx
    add dword[SidebarButtonRiverX], ecx
    add dword[SidebarButtonRoadX], ecx
    add dword[SidebarButtonRidgesX], ecx
    add dword[SidebarButtonTreesX], ecx
    add dword[SidebarButtonDebrisX], ecx
    add dword[SidebarButtonLeftArrowX], ecx
    add dword[SidebarButtonRightArrowX], ecx
    add dword[SidebarButtonTileBrowserX], ecx
    add dword[SidebarButtonFlagX], ecx
    add dword[SidebarButtonTileSelectionX], ecx
    add dword[SidebarButtonTerrainClearX], ecx
    add dword[SidebarButtonTerrainOreX], ecx
    add dword[SidebarButtonTerrainGemX], ecx
    add dword[SidebarButtonTerrainWaterX], ecx
    
    mov esp, ebp
    pop ebp
    pop edi
    pop esi
    jmp 0x0045D6C7
@ENDHACK

