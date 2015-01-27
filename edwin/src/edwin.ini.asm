%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

%macro INI_Get_Int 3 ; args: <section>, <key>, <default>
    MOV ECX, DWORD %3
    MOV EBX, DWORD %2
    MOV EDX, DWORD %1
    LEA EAX, [EBP-0x1C]
    CALL INIClass__Get_Int
%endmacro

%macro INI_Get_String 5 ; args: <section>, <key>, <default>, <dst>, <dst_len>
    PUSH %5
    PUSH %4
    MOV ECX, DWORD %3
    MOV EBX, DWORD %2
    MOV EDX, DWORD %1
    LEA EAX, [EBP-0x1C]
    CALL INIClass__Get_String
%endmacro

%macro INI_Get_Bool 3 ; args: <section>, <key>, <default>
    MOV ECX, DWORD %3
    MOV EBX, DWORD %2
    MOV EDX, DWORD %1
    LEA EAX, [EBP-0x1C]
    CALL INIClass__Get_Bool
%endmacro

cextern SlowerScrollRate
cextern ScrollRate
cextern ScreenWidth
cextern ScreenHeight
cextern EditorLanguage
cextern MainMixPath
cextern RedalertMixPath
cextern INIClass__Get_Int
cextern INIClass__Get_String
cextern INIClass__Get_Bool

gstring SettingsIni, "edwin.ini"

sstring OptionsSection, "Options"
sstring ScrollRateKey, "ScrollRate"
sstring SlowerScrollRateKey, "SlowerScrollRate"
sstring WidthKey, "EditorWidth"
sstring HeightKey, "EditorHeight"
sstring LanguageKey, "EditorLanguage"
sstring MainMixKey, "MainMix"
sstring RedalertMixKey, "RedalertMix"

@PATCH 0x004607D2
    mov edx, SettingsIni
@ENDPATCH

@HACK 0x00461130, LoadSettingsIni
    INI_Get_Int OptionsSection, ScrollRateKey, 5
    mov dword[ScrollRate], eax
    
    INI_Get_Bool OptionsSection, SlowerScrollRateKey, 1
    mov byte[SlowerScrollRate], al
    
    INI_Get_Int OptionsSection, WidthKey, 640
    mov dword[ScreenWidth], eax
    
    INI_Get_Int OptionsSection, HeightKey, 400
    mov dword[ScreenHeight], eax
    
    INI_Get_Int OptionsSection, LanguageKey, 0
    mov byte[EditorLanguage], al

    INI_Get_String OptionsSection, MainMixKey, MainMixPath, MainMixPath, 256
    INI_Get_String OptionsSection, RedalertMixKey, RedalertMixPath, RedalertMixPath, 256
    
    mov ecx, 1
    jmp 0x00461135
@ENDHACK
