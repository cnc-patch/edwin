%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

; This still needs a lot of work, cannot be used atm

cextern ScreenHeight
cextern ScreenWidth

gint HighResAddedWidth, 0
gint HighResAddedHeight, 0

@REPLACE 0x00460929, 0x0046092F, InitHighRes
    pushad
    
    mov eax, dword[ScreenHeight]
    sub eax, 400
    mov dword[HighResAddedHeight], eax
    
    mov eax, dword[ScreenWidth]
    sub eax, 640
    mov dword[HighResAddedWidth], eax
    
    popad
    mov ecx, dword[ScreenHeight]
    jmp 0x0046092F
@ENDREPLACE

@CLEAR 0x00461193, 0x90, 0x00461198 ; Ignore [Options]Resolution= in redalert.ini
@CLEAR 0x00460D1C, 0x90, 0x00460D26 ; Do not change the height to 400
@SJMP 0x00460D35, 0x00460D79 ; Do not use black bars with 480 height

@CLEAR 0x00460D37, 0x90, 0x00460D41
@HACK 0x00460D37, AdjustBuffer1
    push dword[ScreenHeight]
    push dword[ScreenWidth]
    jmp 0x00460D41
@ENDHACK

@CLEAR 0x00460D57, 0x90, 0x00460D61
@HACK 0x00460D57, AdjustBuffer2
    push dword[ScreenHeight]
    push dword[ScreenWidth]
    jmp 0x00460D61
@ENDHACK

@CLEAR 0x00460D79, 0x90, 0x00460D83
@HACK 0x00460D79, AdjustBuffer1x
    push dword[ScreenHeight]
    push dword[ScreenWidth]
    jmp 0x00460D83
@ENDHACK

@CLEAR 0x00460D96, 0x90, 0x00460DA0
@HACK 0x00460D96, AdjustBuffer2x
    push dword[ScreenHeight]
    push dword[ScreenWidth]
    jmp 0x00460DA0
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
