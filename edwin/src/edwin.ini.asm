%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"
%include "INIClass.inc"

cextern SlowerScrollRate
cextern ScrollRate
cextern ScreenWidth
cextern ScreenHeight
cextern EditorLanguage
cextern MainMixPath
cextern RedalertMixPath
cextern VideoBackBuffer
cextern HardwareFills
cextern SingleProcAffinity
cextern FileClass__FileClass
cextern INIClass__Save
cextern _imp__CreateFileA
cextern _imp__CloseHandle

gstring SettingsIniPath, "edwin.ini"
gbyte INIClass__SettingsIni, 0, 64
gbyte FileClass__SettingsIni, 0, 128

sstring OptionsSection, "Options"
sstring ScrollRateKey, "ScrollRate"
sstring SlowerScrollRateKey, "SlowerScrollRate"
sstring WidthKey, "EditorWidth"
sstring HeightKey, "EditorHeight"
sstring LanguageKey, "EditorLanguage"
sstring MainMixKey, "MainMix"
sstring RedalertMixKey, "RedalertMix"
sstring VideoBackBufferKey, "VideoBackBuffer"
sstring HardwareFillsKey, "HardwareFills"
sstring SingleProcAffinityKey, "SingleProcAffinity"

@REPLACE 0x00461130, 0x004611A2, LoadSettingsIni
    INI_Get_Int INIClass__SettingsIni, OptionsSection, ScrollRateKey, 3
    mov dword[ScrollRate], eax
    
    INI_Get_Bool INIClass__SettingsIni, OptionsSection, SlowerScrollRateKey, byte[SlowerScrollRate]
    mov byte[SlowerScrollRate], al
    
    INI_Get_Int INIClass__SettingsIni, OptionsSection, WidthKey, 640
    mov dword[ScreenWidth], eax
    
    INI_Get_Int INIClass__SettingsIni, OptionsSection, HeightKey, 400
    mov dword[ScreenHeight], eax
    
    INI_Get_Int INIClass__SettingsIni, OptionsSection, LanguageKey, 0
    mov byte[EditorLanguage], al

    INI_Get_String INIClass__SettingsIni, OptionsSection, MainMixKey, MainMixPath, MainMixPath, 256
    INI_Get_String INIClass__SettingsIni, OptionsSection, RedalertMixKey, RedalertMixPath, RedalertMixPath, 256
    
    INI_Get_Bool INIClass__SettingsIni, OptionsSection, VideoBackBufferKey, 1
    mov byte[VideoBackBuffer], al
    
    INI_Get_Bool INIClass__SettingsIni, OptionsSection, HardwareFillsKey, 0
    mov byte[HardwareFills], al
    
    INI_Get_Bool INIClass__SettingsIni, OptionsSection, SingleProcAffinityKey, byte[SingleProcAffinity]
    mov byte[SingleProcAffinity], al
    
    jmp 0x004611A2
@ENDREPLACE

gfunction SaveSettingsIni
    INI_Put_Int INIClass__SettingsIni, OptionsSection, ScrollRateKey, dword[ScrollRate]
    INI_Put_Bool INIClass__SettingsIni, OptionsSection, SlowerScrollRateKey, byte[SlowerScrollRate]
    INI_Put_Int INIClass__SettingsIni, OptionsSection, WidthKey, dword[ScreenWidth]
    INI_Put_Int INIClass__SettingsIni, OptionsSection, HeightKey, dword[ScreenHeight]
    xor eax, eax
    mov al, byte[EditorLanguage]
    INI_Put_Int INIClass__SettingsIni, OptionsSection, LanguageKey, eax
    INI_Put_String INIClass__SettingsIni, OptionsSection, MainMixKey, MainMixPath
    INI_Put_String INIClass__SettingsIni, OptionsSection, RedalertMixKey, RedalertMixPath
    INI_Put_Bool INIClass__SettingsIni, OptionsSection, VideoBackBufferKey, byte[VideoBackBuffer]
    INI_Put_Bool INIClass__SettingsIni, OptionsSection, HardwareFillsKey, byte[HardwareFills]
    INI_Put_Bool INIClass__SettingsIni, OptionsSection, SingleProcAffinityKey, byte[SingleProcAffinity]

    mov edx, SettingsIniPath
    mov eax, FileClass__SettingsIni
    call FileClass__FileClass
    
    mov edx, FileClass__SettingsIni
    mov eax, INIClass__SettingsIni
    call INIClass__Save
    retn
    
@CLEAR 0x00409987, 0x90, 0x0040999F ; Do not write digest

@REPLACE 0x004317B1, 0x004317BB, EditorExit
    pushad
    call SaveSettingsIni
    popad

    mov dword[0x4E1474], 0
    jmp 0x004317BB
@ENDREPLACE

@REPLACE 0x004342E0, 0x004342E5, ChangeScrollRateDialogOkClick
    mov dword[ScrollRate], eax
    
    pushad
    call SaveSettingsIni
    popad
    jmp 0x004342E5
@ENDREPLACE

@REPLACE 0x00461116, 0x0046111E, MakeSettingsIniGlobal1
    mov eax, INIClass__SettingsIni
    call 0x0043E588
    jmp 0x0046111E
@ENDREPLACE

@REPLACE 0x00461128, 0x00461130, MakeSettingsIniGlobal2
    mov eax, INIClass__SettingsIni
    call 0x0047AAAA
    jmp 0x00461130
@ENDREPLACE

@REPLACE 0x004607D2, 0x004607D7, SetupSettingsIni
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
@ENDREPLACE
