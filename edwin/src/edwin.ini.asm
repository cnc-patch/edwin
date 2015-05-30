%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

cextern _imp__CreateFileA
cextern _imp__CloseHandle
cextern SaveSettingsIni
cextern LoadSettingsIni
cextern SettingsIniPath
cextern ScrollRate

gbyte INIClass__SettingsIni, 0, 64
gbyte FileClass__SettingsIni, 0, 128

@CLEAR 0x00409987, 0x90, 0x0040999F ; Do not write digest

hack 0x00461130, 0x004611A2 ; LoadSettingsIni
    call LoadSettingsIni
    jmp 0x004611A2


hack 0x004317B1, 0x004317BB ;EditorExit
    pushad
    call SaveSettingsIni
    popad

    mov dword[0x4E1474], 0
    jmp 0x004317BB


hack 0x004342E0, 0x004342E5 ; ChangeScrollRateDialogOkClick
    mov dword[ScrollRate], eax
    
    pushad
    call SaveSettingsIni
    popad
    jmp 0x004342E5


hack 0x00461116, 0x0046111E ; MakeSettingsIniGlobal1
    mov eax, INIClass__SettingsIni
    call 0x0043E588
    jmp 0x0046111E


hack 0x00461128, 0x00461130 ; MakeSettingsIniGlobal2
    mov eax, INIClass__SettingsIni
    call 0x0047AAAA
    jmp 0x00461130


hack 0x004607D2, 0x004607D7 ; SetupSettingsIni
    pushad
    push 0
    push 0x80
    push 1
    push 0
    push 1
    push 0x80000000
    push SettingsIniPath
    call [_imp__CreateFileA] ; Create the file if it does not exist to avoid freezing
    cmp eax, -1
    jz .InvalidHandle
    push eax
    call [_imp__CloseHandle]
    
.InvalidHandle:
    popad
    mov edx, SettingsIniPath
    jmp 0x004607D7
