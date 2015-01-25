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
gint HighResAlignX, 0
gint HighResAlignY, 0

sint HighResWidthInTiles, 20


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
    
    cmp eax, 0
    jz .NoDivide
    xor edx, edx
    mov ecx, 2
    div ecx
    mov dword[HighResAlignX], eax
.NoDivide:
    
    mov eax, dword[ScreenHeight]
    sub eax, 400
    mov dword[HighResAddedHeight], eax
    
    cmp eax, 0
    jz .NoDivide2
    xor edx, edx
    mov ecx, 2
    div ecx
    mov dword[HighResAlignY], eax
.NoDivide2:
    
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

@HACK 0x0044984C, AdjustTacticalAreaWidth
    mov eax, dword[HighResAddedWidth]
    add eax, 480
    mov dword[0x4EBE6C], eax
    jmp 0x00449851
@ENDHACK

@HACK 0x0044985B, AdjustTacticalAreaHeight
    mov eax, dword[HighResAddedHeight]
    add eax, 384
    mov dword[0x4EBE70], eax
    jmp 0x00449860
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
    mov eax, dword[ScreenWidth] ; FIX ME - mini map automatically aligns using buffer size width
    sub eax, 640
    add eax, 494
    
    ;mov eax, dword[HighResAddedWidth]
    ;add eax, 494
    jmp 0x004579A4
@ENDHACK

@HACK 0x0045DEAB, AdjustCellWidth
    mov eax, dword[HighResWidthInTiles]
    mov ebx, 8
    jmp 0x0045DEB0
@ENDHACK

@PATCH 0x00422246 ;override GetScreenWidth call to avoid automatic align on the right side for credits
    mov eax, 640
@ENDPATCH

@REPLACE 0x0045B5CF, 0x0045B5D6, AdjustScrolling3
    mov eax, dword[HighResAddedWidth]
    add eax, 540
    jmp 0x0045B5D6
@ENDREPLACE

@REPLACE 0x0045B5DE, 0x0045B5E5, AdjustScrolling4
    mov eax, dword[HighResAddedWidth]
    add eax, 540
    jmp 0x0045B5E5
@ENDREPLACE

@REPLACE 0x0045B5F2, 0x0045B5F9, AdjustScrolling5
    mov edx, dword[HighResAddedWidth]
    add edx, 640
    jmp 0x0045B5F9
@ENDREPLACE

@REPLACE 0x0045B616, 0x0045B61D, AdjustScrolling7
    mov eax, dword[HighResAddedWidth]
    add eax, 540
    jmp 0x0045B61D
@ENDREPLACE

@REPLACE 0x0045B627, 0x0045B62E, AdjustScrolling8
    mov edx, dword[HighResAlignX]
    add edx, 320
    jmp 0x0045B62E
@ENDREPLACE

@REPLACE 0x0045B672, 0x0045B679, AdjustScrolling9
    mov eax, dword[HighResAddedHeight]
    add eax, 300
    jmp 0x0045B679
@ENDREPLACE

@REPLACE 0x0045B672, 0x0045B679, AdjustScrolling12
    mov eax, dword[HighResAddedHeight]
    add eax, 300
    jmp 0x0045B679
@ENDREPLACE

@REPLACE 0x0045B681, 0x0045B688, AdjustScrolling13
    mov eax, dword[HighResAddedHeight]
    add eax, 300
    jmp 0x0045B688
@ENDREPLACE

@REPLACE 0x0045B695, 0x0045B69C, AdjustScrolling14
    mov edx, dword[HighResAddedHeight]
    add edx, 400
    jmp 0x0045B69C
@ENDREPLACE

@REPLACE 0x0045B6B0, 0x0045B6B7, AdjustScrolling15
    mov edx, dword[HighResAlignY]
    add edx, 200
    jmp 0x0045B6B7
@ENDREPLACE

@REPLACE 0x0045B6BA, 0x0045B6C1, AdjustScrolling16
    mov esi, dword[HighResAlignX]
    add esi, 320
    jmp 0x0045B6C1
@ENDREPLACE

@HACK 0x0045D6C2, AdjustSidebarButtons
    push eax
    mov eax, dword[HighResAddedWidth]
    mov ecx, eax
    add ecx, 484
    mov dword[SidebarButtonShoreX], ecx
    mov ecx, eax
    add ecx, 484
    mov dword[SidebarButtonRiverX], ecx
    mov ecx, eax
    add ecx, 484
    mov dword[SidebarButtonRoadX], ecx
    mov ecx, eax
    add ecx, 564
    mov dword[SidebarButtonRidgesX], ecx
    mov ecx, eax
    add ecx, 564
    mov dword[SidebarButtonTreesX], ecx
    mov ecx, eax
    add ecx, 564
    mov dword[SidebarButtonDebrisX], ecx
    mov ecx, eax
    add ecx, 482
    mov dword[SidebarButtonLeftArrowX], ecx
    mov ecx, eax
    add ecx, 522
    mov dword[SidebarButtonRightArrowX], ecx
    mov ecx, eax
    add ecx, 562
    mov dword[SidebarButtonTileBrowserX], ecx
    mov ecx, eax
    add ecx, 602
    mov dword[SidebarButtonFlagX], ecx
    mov ecx, eax
    add ecx, 488
    mov dword[SidebarButtonTileSelectionX], ecx
    mov ecx, eax
    add ecx, 486
    mov dword[SidebarButtonTerrainClearX], ecx
    mov ecx, eax
    add ecx, 524
    mov dword[SidebarButtonTerrainOreX], ecx
    mov ecx, eax
    add ecx, 562
    mov dword[SidebarButtonTerrainGemX], ecx
    mov ecx, eax
    add ecx, 600
    mov dword[SidebarButtonTerrainWaterX], ecx
    pop eax
    
    mov esp, ebp
    pop ebp
    pop edi
    pop esi
    jmp 0x0045D6C7
@ENDHACK
