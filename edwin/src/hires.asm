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
cextern MapCopyPasteCellsWidth

gint HighResAddedWidth, 0
gint HighResAddedHeight, 0
gint HighResAlignX, 0
gint HighResAlignY, 0

sint HighResWidthInTiles, 20
sbyte TitleScreenLoaded, 0
sbyte MapCopyPasteCellArray, 0, 126*126*5 ; Original size = 20*16*5 (640x400)

@REPLACE 0x00460929, 0x0046092F, InitHighRes
    pushad
    cmp dword[ScreenWidth], 1366
    jnz .Not1366x768
    cmp dword[ScreenHeight], 768
    jnz .Not1366x768
    mov dword[ScreenWidth], 1280
    mov dword[ScreenHeight], 720
    
.Not1366x768:
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
    
    sar eax, 1
    mov dword[HighResAlignX], eax
    
    mov eax, dword[ScreenHeight]
    sub eax, 400
    mov dword[HighResAddedHeight], eax
    
    sar eax, 1
    mov dword[HighResAlignY], eax
    
    popad
    mov ecx, dword[ScreenHeight]
    jmp 0x0046092F
@ENDREPLACE

@CLEAR 0x00461193, 0x90, 0x00461198 ; Ignore [Options]Resolution= in edwin.ini
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

@REPLACE 0x0044AAFA, 0x0044AB61, MapCopy
    mov eax, dword[ebp-8]
    mov edx, dword[ebp-0x14]
    imul edx
    imul eax, eax, 5
    mov edx, eax
    imul eax, dword[ebp-0x30], 5
    add edx, eax
    
    mov eax, dword[ebp-0x34]
    mov ax, word[eax+9]
    mov word[edx+MapCopyPasteCellArray], ax
    
    mov eax, dword[ebp-0x34]
    mov al, byte[eax+0x0B]
    mov byte[edx+MapCopyPasteCellArray+2], al
    
    mov eax, dword[ebp-0x34]
    mov al, byte[eax+0x0C]
    mov byte[edx+MapCopyPasteCellArray+3], al
    
    mov eax, dword[ebp-0x34]
    mov al, byte[eax+0x0D]
    mov byte[edx+MapCopyPasteCellArray+4], al
    
    jmp 0x0044AAC7
@ENDREPLACE

@REPLACE 0x0044AD4F, 0x0044ADB1, MapPaste
    push ebx

    mov eax, dword[MapCopyPasteCellsWidth]
    mov edx, dword[ebp-8]
    imul edx
    imul eax, eax, 5
    mov edx, eax
    mov edx, eax
    imul eax, dword[ebp-0x34], 5
    add eax, edx
    mov ebx, eax
    
    mov dx, word[ebx+MapCopyPasteCellArray]
    mov eax, dword[ebp-0x48]
    mov word[eax+9], dx

    mov dl, byte[ebx+MapCopyPasteCellArray+2]
    mov eax, dword[ebp-0x48]
    mov byte[eax+0x0B], dl
    
    mov dl, byte[ebx+MapCopyPasteCellArray+3]
    mov eax, dword[ebp-0x48]
    mov byte[eax+0x0C], dl
    
    mov dl, byte[ebx+MapCopyPasteCellArray+4]
    mov eax, dword[ebp-0x48]
    mov byte[eax+0x0D], dl
    
    pop ebx
    jmp 0x0044ADB1
@ENDREPLACE

@REPLACE 0x0044B038, 0x0044B09A, MapPasteClip
    push ebx

    mov eax, dword[MapCopyPasteCellsWidth]
    mov edx, dword[ebp-8]
    imul edx
    imul eax, eax, 5
    mov edx, eax
    mov edx, eax
    imul eax, dword[ebp-0x34], 5
    add eax, edx
    mov ebx, eax
    
    mov dx, word[ebx+MapCopyPasteCellArray]
    mov eax, dword[ebp-0x48]
    mov word[eax+9], dx

    mov dl, byte[ebx+MapCopyPasteCellArray+2]
    mov eax, dword[ebp-0x48]
    mov byte[eax+0x0B], dl
    
    mov dl, byte[ebx+MapCopyPasteCellArray+3]
    mov eax, dword[ebp-0x48]
    mov byte[eax+0x0C], dl
    
    mov dl, byte[ebx+MapCopyPasteCellArray+4]
    mov eax, dword[ebp-0x48]
    mov byte[eax+0x0D], dl
    
    pop ebx
    jmp 0x0044B09A
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
    mov eax, dword[HighResAddedWidth]
    add eax, 494
    jmp 0x004579A4
@ENDHACK

@HACK 0x00457510, AdjustMiniMap
    mov eax, dword[HighResAddedWidth]
    add eax, 640
    jmp 0x00457515
@ENDHACK

@HACK 0x0045DEAB, AdjustCellWidth
    mov eax, dword[HighResWidthInTiles]
    mov ebx, 8
    jmp 0x0045DEB0
@ENDHACK

@REPLACE 0x00430F57, 0x00430F61, AdjustCurrentMapY
    mov eax, dword[HighResAlignY]
    add eax, 252
    mov dword[ebp-0x0DC], eax
    jmp 0x00430F61
@ENDREPLACE

@REPLACE 0x00430F79, 0x00430F83, AdjustCurrentMapX
    mov eax, dword[HighResAlignX]
    add eax, 320
    mov dword[ebp-0x0E0], eax
    jmp 0x00430F83
@ENDREPLACE

@REPLACE 0x00430EB6, 0x00430EC0, AdjustCurrentMapY2
    mov eax, dword[HighResAlignY]
    add eax, 252
    mov dword[ebp-0x0D0], eax
    jmp 0x00430EC0
@ENDREPLACE

@REPLACE 0x00430ED8, 0x00430EE2, AdjustCurrentMapX2
    mov eax, dword[HighResAlignX]
    add eax, 320
    mov dword[ebp-0x0D4], eax
    jmp 0x00430EE2
@ENDREPLACE

@HACK 0x00422246, AdjustCreditsTabText
    mov eax, dword[HighResAddedWidth]
    add eax, 640
    jmp 0x0042224B
@ENDHACK

@REPLACE 0x004614BD, 0x004614C4, AdjustCreditsTabBackground
    mov ebx, dword[HighResAddedWidth]
    add ebx, 320
    jmp 0x004614C4
@ENDREPLACE

@HACK 0x00461B36, AdjustMapSizeTabBackground
    xor ecx, ecx
    mov ebx, dword[ebp-0x38]
    cmp ebx, 480
    jnz 0x00461B3B
    add ebx, dword[HighResAddedWidth]
    jmp 0x00461B3B
@ENDHACK

@HACK 0x00461B55, AdjustMapSizeTabText
    push 0
    mov eax, dword[ebp-0x30]
    cmp eax, 560
    jnz 0x00461B5A
    add eax, dword[HighResAddedWidth]
    jmp 0x00461B5A
@ENDHACK

@REPLACE 0x0045B5CF, 0x0045B5D6, AdjustScrolling1
    mov eax, dword[HighResAddedWidth]
    add eax, 540
    jmp 0x0045B5D6
@ENDREPLACE

@REPLACE 0x0045B5DE, 0x0045B5E5, AdjustScrolling2
    mov eax, dword[HighResAddedWidth]
    add eax, 540
    jmp 0x0045B5E5
@ENDREPLACE

@REPLACE 0x0045B5F2, 0x0045B5F9, AdjustScrolling3
    mov edx, dword[HighResAddedWidth]
    add edx, 640
    jmp 0x0045B5F9
@ENDREPLACE

@REPLACE 0x0045B616, 0x0045B61D, AdjustScrolling4
    mov eax, dword[HighResAddedWidth]
    add eax, 540
    jmp 0x0045B61D
@ENDREPLACE

@REPLACE 0x0045B627, 0x0045B62E, AdjustScrolling5
    mov edx, dword[HighResAlignX]
    add edx, 320
    jmp 0x0045B62E
@ENDREPLACE

@REPLACE 0x0045B672, 0x0045B679, AdjustScrolling6
    mov eax, dword[HighResAddedHeight]
    add eax, 300
    jmp 0x0045B679
@ENDREPLACE

@REPLACE 0x0045B672, 0x0045B679, AdjustScrolling7
    mov eax, dword[HighResAddedHeight]
    add eax, 300
    jmp 0x0045B679
@ENDREPLACE

@REPLACE 0x0045B681, 0x0045B688, AdjustScrolling8
    mov eax, dword[HighResAddedHeight]
    add eax, 300
    jmp 0x0045B688
@ENDREPLACE

@REPLACE 0x0045B695, 0x0045B69C, AdjustScrolling9
    mov edx, dword[HighResAddedHeight]
    add edx, 400
    jmp 0x0045B69C
@ENDREPLACE

@REPLACE 0x0045B6B0, 0x0045B6B7, AdjustScrolling10
    mov edx, dword[HighResAlignY]
    add edx, 200
    jmp 0x0045B6B7
@ENDREPLACE

@REPLACE 0x0045B6BA, 0x0045B6C1, AdjustScrolling11
    mov esi, dword[HighResAlignX]
    add esi, 320
    jmp 0x0045B6C1
@ENDREPLACE

@REPLACE 0x00432A99, 0x00432AA1, AdjustMapModifyDialogButtonsY
    mov eax, dword[EAX+0x4AFBC4]
    shl eax, cl
    add eax, dword[HighResAlignY]
    jmp 0x00432AA1
@ENDREPLACE

@REPLACE 0x00432AA9, 0x00432AB1, AdjustMapModifyDialogButtonsX
    mov eax, dword[EAX+0x4AFBC0]
    shl eax, cl
    add eax, dword[HighResAlignX]
    jmp 0x00432AB1
@ENDREPLACE

@REPLACE 0x00432ECE, 0x00432ED5, AdjustMapModifyDialogBackgroundY
    mov ebx, 100
    add ebx, dword[HighResAlignY]
    jmp 0x00432ED5
@ENDREPLACE

@REPLACE 0x00432ED8, 0x00432EDF, AdjustMapModifyDialogBackgroundX
    mov edx, 144
    add edx, dword[HighResAlignX]
    jmp 0x00432EDF
@ENDREPLACE

@REPLACE 0x00432EFF, 0x00432F06, AdjustMapModifyDialogCaptionX
    mov esi, 352
    add esi, dword[HighResAddedWidth]
    jmp 0x00432F06
@ENDREPLACE

@REPLACE 0x00432F09, 0x00432F10, AdjustMapModifyDialogCaptionY
    mov ebx, 100
    add ebx, dword[HighResAlignY]
    jmp 0x00432F10
@ENDREPLACE

@REPLACE 0x00432F67, 0x00432F6E, AdjustMapModifyDialogMapBackgroundY
    mov edx, 144
    add edx, dword[HighResAlignY]
    jmp 0x00432F6E
@ENDREPLACE

@REPLACE 0x00432F71, 0x00432F78, AdjustMapModifyDialogMapBackgroundX
    mov esi, 272
    add esi, dword[HighResAlignX]
    jmp 0x00432F78
@ENDREPLACE

@REPLACE 0x00432FAA, 0x00432FB1, AdjustMapModifyDialogMapShpY
    mov eax, 192
    add eax, dword[HighResAlignY]
    jmp 0x00432FB1
@ENDREPLACE

@REPLACE 0x00432FB4, 0x00432FBB, AdjustMapModifyDialogMapShpX
    mov ebx, 320
    add ebx, dword[HighResAlignX]
    jmp 0x00432FBB
@ENDREPLACE

@PATCH 0x00441DDE ;AdjustMapLoadSaveDeleteDialog
    mov eax, 640
@ENDPATCH

@REPLACE 0x00441E28, 0x00441E2D, AdjustMapLoadSaveDeleteDialogX
    sar eax, 1
    add eax, dword[HighResAlignX]
    mov dword[ebp-0x28], eax
    jmp 0x00441E2D
@ENDREPLACE

@REPLACE 0x00441E46, 0x00441E4C, AdjustMapLoadSaveDeleteDialogY
    add eax, dword[HighResAlignY]
    mov dword[ebp-0x0AC], eax
    jmp 0x00441E4C
@ENDREPLACE

@REPLACE 0x004339E8, 0x004339F0, AdjustChangeScrollRateDialogButtonsY
    mov eax, dword[eax+0x4AFCA8]
    shl eax, cl
    add eax, dword[HighResAlignY]
    jmp 0x004339F0
@ENDREPLACE

@REPLACE 0x004339F8, 0x00433A00, AdjustChangeScrollRateDialogButtonsX
    mov eax, dword[eax+0x4AFCA4]
    shl eax, cl
    add eax, dword[HighResAlignX]
    jmp 0x00433A00
@ENDREPLACE

@REPLACE 0x00433B0E, 0x00433B15, AdjustChangeScrollRateDialogScrollbarY
    mov eax, 160
    add eax, dword[HighResAlignY]
    jmp 0x00433B15
@ENDREPLACE

@REPLACE 0x00433B18, 0x00433B1F, AdjustChangeScrollRateDialogScrollbarX
    mov ebx, 164
    add ebx, dword[HighResAlignX]
    jmp 0x00433B1F
@ENDREPLACE

@REPLACE 0x00433DCF, 0x00433DD6, AdjustChangeScrollRateDialogBackgroundY
    mov ebx, 100
    add ebx, dword[HighResAlignY]
    jmp 0x00433DD6
@ENDREPLACE

@REPLACE 0x00433DD9, 0x00433DE0, AdjustChangeScrollRateDialogBackgroundX
    mov edx, 144
    add edx, dword[HighResAlignX]
    jmp 0x00433DE0
@ENDREPLACE

@REPLACE 0x00433E0A, 0x00433E11, AdjustChangeScrollRateDialogCaptionY
    mov ebx, 100
    add ebx, dword[HighResAlignY]
    jmp 0x00433E11
@ENDREPLACE

@REPLACE 0x00433E14, 0x00433E1B, AdjustChangeScrollRateDialogCaptionX
    mov edx, 144
    add edx, dword[HighResAlignX]
    jmp 0x00433E1B
@ENDREPLACE

@REPLACE 0x00433E6D, 0x00433E74, AdjustChangeScrollRateDialogScrollRateTextY
    mov eax, 146
    add eax, dword[HighResAlignY]
    jmp 0x00433E74
@ENDREPLACE

@REPLACE 0x00433E78, 0x00433E7F, AdjustChangeScrollRateDialogScrollRateTextX
    mov eax, 164
    add eax, dword[HighResAlignX]
    jmp 0x00433E7F
@ENDREPLACE

@REPLACE 0x00433E9A, 0x00433EA1, AdjustChangeScrollRateDialogSlowerTextY
    mov eax, 174
    add eax, dword[HighResAlignY]
    jmp 0x00433EA1
@ENDREPLACE

@REPLACE 0x00433EA5, 0x00433EAC, AdjustChangeScrollRateDialogSlowerTextX
    mov eax, 164
    add eax, dword[HighResAlignX]
    jmp 0x00433EAC
@ENDREPLACE

@REPLACE 0x00433ED9, 0x00433EE0, AdjustChangeScrollRateDialogFasterTextY
    mov eax, 172
    add eax, dword[HighResAlignY]
    jmp 0x00433EE0
@ENDREPLACE

@REPLACE 0x00433EE4, 0x00433EEB, AdjustChangeScrollRateDialogFasterTextX
    mov eax, 476
    add eax, dword[HighResAlignX]
    jmp 0x00433EEB
@ENDREPLACE

@REPLACE 0x00431DF4, 0x00431DFC, AdjustNewMapDialogButtonsY
    mov eax, dword[EAX+0x4AFAE0]
    shl eax, cl
    add eax, dword[HighResAlignY]
    jmp 0x00431DFC
@ENDREPLACE

@REPLACE 0x00431E04, 0x00431E0C, AdjustNewMapDialogButtonsX
    mov eax, dword[EAX+0x4AFADC]
    shl eax, cl
    add eax, dword[HighResAlignX]
    jmp 0x00431E0C
@ENDREPLACE

@REPLACE 0x00432129, 0x00432130, AdjustNewMapDialogBackgroundY
    mov ebx, 100
    add ebx, dword[HighResAlignY]
    jmp 0x00432130
@ENDREPLACE

@REPLACE 0x00432133, 0x0043213A, AdjustNewMapDialogBackgroundX
    mov edx, 144
    add edx, dword[HighResAlignX]
    jmp 0x0043213A
@ENDREPLACE

@REPLACE 0x0043215A, 0x00432161, AdjustNewMapDialogCaptionX
    mov esi, 352
    add esi, dword[HighResAddedWidth]
    jmp 0x00432161
@ENDREPLACE

@REPLACE 0x00432164, 0x0043216B, AdjustNewMapDialogCaptionY
    mov ebx, 100
    add ebx, dword[HighResAlignY]
    jmp 0x0043216B
@ENDREPLACE

@REPLACE 0x004321A4, 0x004321AB, AdjustNewMapDialogMapBackgroundY
    mov edx, 144
    add edx, dword[HighResAlignY]
    jmp 0x004321AB
@ENDREPLACE

@REPLACE 0x004321AE, 0x004321B5, AdjustNewMapDialogMapBackgroundX
    mov esi, 272
    add esi, dword[HighResAlignX]
    jmp 0x004321B5
@ENDREPLACE

@REPLACE 0x004321E7, 0x004321EE, AdjustNewMapDialogMapShpY
    mov edx, 192
    add edx, dword[HighResAlignY]
    jmp 0x004321EE
@ENDREPLACE

@REPLACE 0x004321F1, 0x004321F8, AdjustNewMapDialogMapShpX
    mov ebx, 320
    add ebx, dword[HighResAlignX]
    jmp 0x004321F8
@ENDREPLACE


@REPLACE 0x00448274, 0x0044827B, AdjustTileBrowserDialogButtonXY1
    mov edx, 378
    add edx, dword[HighResAlignY]
    push edx
    mov edx, 4
    add edx, dword[HighResAlignX]
    push edx
    jmp 0x0044827B
@ENDREPLACE

@REPLACE 0x004482B9, 0x004482C0, AdjustTileBrowserDialogButtonXY2
    mov edx, 378
    add edx, dword[HighResAlignY]
    push edx
    mov edx, 84
    add edx, dword[HighResAlignX]
    push edx
    jmp 0x004482C0
@ENDREPLACE

@REPLACE 0x004482FE, 0x00448308, AdjustTileBrowserDialogButtonXY3
    mov edx, 378
    add edx, dword[HighResAlignY]
    push edx
    mov edx, 164
    add edx, dword[HighResAlignX]
    push edx
    jmp 0x00448308
@ENDREPLACE

@REPLACE 0x00448346, 0x00448350, AdjustTileBrowserDialogButtonXY4
    mov edx, 378
    add edx, dword[HighResAlignY]
    push edx
    mov edx, 244
    add edx, dword[HighResAlignX]
    push edx
    jmp 0x00448350
@ENDREPLACE

@REPLACE 0x0044838E, 0x00448398, AdjustTileBrowserDialogButtonXY5
    mov edx, 378
    add edx, dword[HighResAlignY]
    push edx
    mov edx, 324
    add edx, dword[HighResAlignX]
    push edx
    jmp 0x00448398
@ENDREPLACE

@REPLACE 0x004483D6, 0x004483E0, AdjustTileBrowserDialogButtonXY6
    mov edx, 378
    add edx, dword[HighResAlignY]
    push edx
    mov edx, 404
    add edx, dword[HighResAlignX]
    push edx
    jmp 0x004483E0
@ENDREPLACE

@REPLACE 0x0044841F, 0x00448429, AdjustTileBrowserDialogSelectTileXY1
    mov ecx, 29
    add ecx, dword[HighResAlignY]
    mov ebx, 8
    add ebx, dword[HighResAlignX]
    jmp 0x00448429
@ENDREPLACE

@REPLACE 0x00448452, 0x0044845C, AdjustTileBrowserDialogSelectTileXY2
    mov ecx, 29
    add ecx, dword[HighResAlignY]
    mov ebx, 168
    add ebx, dword[HighResAlignX]
    jmp 0x0044845C
@ENDREPLACE

@REPLACE 0x00448485, 0x0044848F, AdjustTileBrowserDialogSelectTileXY3
    mov ecx, 29
    add ecx, dword[HighResAlignY]
    mov ebx, 328
    add ebx, dword[HighResAlignX]
    jmp 0x0044848F
@ENDREPLACE

@REPLACE 0x004484B5, 0x004484BF, AdjustTileBrowserDialogSelectTileXY4
    mov ecx, 29
    add ecx, dword[HighResAlignY]
    mov ebx, 488
    add ebx, dword[HighResAlignX]
    jmp 0x004484BF
@ENDREPLACE

@REPLACE 0x004484E5, 0x004484EF, AdjustTileBrowserDialogSelectTileXY5
    mov ecx, 145
    add ecx, dword[HighResAlignY]
    mov ebx, 8
    add ebx, dword[HighResAlignX]
    jmp 0x004484EF
@ENDREPLACE

@REPLACE 0x00448515, 0x0044851F, AdjustTileBrowserDialogSelectTileXY6
    mov ecx, 145
    add ecx, dword[HighResAlignY]
    mov ebx, 168
    add ebx, dword[HighResAlignX]
    jmp 0x0044851F
@ENDREPLACE

@REPLACE 0x00448545, 0x0044854F, AdjustTileBrowserDialogSelectTileXY7
    mov ecx, 145
    add ecx, dword[HighResAlignY]
    mov ebx, 328
    add ebx, dword[HighResAlignX]
    jmp 0x0044854F
@ENDREPLACE

@REPLACE 0x00448575, 0x0044857F, AdjustTileBrowserDialogSelectTileXY8
    mov ecx, 145
    add ecx, dword[HighResAlignY]
    mov ebx, 488
    add ebx, dword[HighResAlignX]
    jmp 0x0044857F
@ENDREPLACE

@REPLACE 0x004485A5, 0x004485AF, AdjustTileBrowserDialogSelectTileXY9
    mov ecx, 261
    add ecx, dword[HighResAlignY]
    mov ebx, 8
    add ebx, dword[HighResAlignX]
    jmp 0x004485AF
@ENDREPLACE

@REPLACE 0x004485D5, 0x004485DF, AdjustTileBrowserDialogSelectTileXY10
    mov ecx, 261
    add ecx, dword[HighResAlignY]
    mov ebx, 168
    add ebx, dword[HighResAlignX]
    jmp 0x004485DF
@ENDREPLACE

@REPLACE 0x00448605, 0x0044860F, AdjustTileBrowserDialogSelectTileXY11
    mov ecx, 261
    add ecx, dword[HighResAlignY]
    mov ebx, 328
    add ebx, dword[HighResAlignX]
    jmp 0x0044860F
@ENDREPLACE

@REPLACE 0x00448635, 0x0044863F, AdjustTileBrowserDialogSelectTileXY12
    mov ecx, 261
    add ecx, dword[HighResAlignY]
    mov ebx, 488
    add ebx, dword[HighResAlignX]
    jmp 0x0044863F
@ENDREPLACE

@REPLACE 0x0044865A, 0x00448664, AdjustTileBrowserDialogButtonXY7
    mov ecx, 378
    add ecx, dword[HighResAlignY]
    push ecx
    mov ecx, 482
    add ecx, dword[HighResAlignX]
    jmp 0x00448664
@ENDREPLACE

@REPLACE 0x0044868D, 0x00448697, AdjustTileBrowserDialogButtonXY8
    mov ecx, 378
    add ecx, dword[HighResAlignY]
    push ecx
    mov ecx, 522
    add ecx, dword[HighResAlignX]
    jmp 0x00448697
@ENDREPLACE

@REPLACE 0x004486BE, 0x004486C8, AdjustTileBrowserDialogButtonXY9
    mov ecx, 378
    add ecx, dword[HighResAlignY]
    push ecx
    mov ecx, 562
    add ecx, dword[HighResAlignX]
    jmp 0x004486C8
@ENDREPLACE

@REPLACE 0x004486EF, 0x004486F9, AdjustTileBrowserDialogButtonXY10
    mov ecx, 378
    add ecx, dword[HighResAlignY]
    push ecx
    mov ecx, 602
    add ecx, dword[HighResAlignX]
    jmp 0x004486F9
@ENDREPLACE

@REPLACE 0x00448B36, 0x00448B43, AdjustTileBrowserDialogTileBackgroundBorderShpsXY
    mov edx, dword[HighResAlignY]
    add dword[EBP-0x528], edx
    mov edx, dword[EBP-0x528]
    dec edx
    mov eax, dword[HighResAlignX]
    add dword[EBP-0x524], eax
    mov eax, dword[EBP-0x524]
    jmp 0x00448B43
@ENDREPLACE

@CLEAR 0x004489FE, 0x90, 0x00448A03 ; TileBrowser Do not clear screen

@REPLACE 0x00448AA8, 0x00448AC9, AdjustTileBrowserDialogBackground
    mov eax, 400
    add eax, dword[HighResAlignY]
    push eax
    mov esi, 640
    add esi, dword[HighResAlignX]
    mov ebx, 16
    add ebx, dword[HighResAlignY]
    mov edx, dword[HighResAlignX]
    jmp 0x00448AC9
@ENDREPLACE

@REPLACE 0x00461EA9, 0x00461EAE, AdjustTileBrowserDialogPageXofYTabBackground
    xor ecx, ecx ; Y
    mov ebx, dword[ebp-0x38]
    add ebx, dword[HighResAddedWidth]
    jmp 0x00461EAE
@ENDREPLACE

@REPLACE 0x00461EEB, 0x00461EF0, AdjustTileBrowserDialogPageXofYTabText
    push 0 ; Y
    mov eax, dword[EBP-0x38]
    add eax, dword[HighResAddedWidth]
    jmp 0x00461EF0
@ENDREPLACE

@REPLACE 0x00461F2E, 0x00461F33, AdjustTileBrowserDialogSelectTileTabBackground
    xor ecx, ecx ; Y
    mov ebx, dword[ebp-0x38]
    add ebx, dword[HighResAddedWidth]
    jmp 0x00461F33
@ENDREPLACE

@REPLACE 0x00461F70, 0x00461F75, AdjustTileBrowserDialogSelectTileTabText
    push 0
    mov eax, dword[ebp-0x38]
    add eax, dword[HighResAddedWidth]
    jmp 0x00461F75
@ENDREPLACE

@REPLACE 0x0042D46F, 0x0042D476, AdjustTitleScreen
    push dword[eax+4]
    cmp byte[TitleScreenLoaded], 1
    jz .out
    mov byte[TitleScreenLoaded], 1
    push dword[HighResAlignY]
    push dword[HighResAlignX]
    jmp 0x0042D476
   
.out:
    push 0
    push 0
    jmp 0x0042D476
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
