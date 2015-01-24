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
cextern INIClass__Get_Int
cextern INIClass__Get_String
cextern INIClass__Get_Bool

sstring OptionsSection, "Options"
sstring ScrollRateKey, "ScrollRate"
sstring SlowerScrollRateKey, "SlowerScrollRate"
sstring WidthKey, "EditorWidth"
sstring HeightKey, "EditorHeight"

@HACK 0x00461130, LoadRedalertIni
    INI_Get_Int OptionsSection, ScrollRateKey, 5
    mov dword[ScrollRate], eax
    
    INI_Get_Bool OptionsSection, SlowerScrollRateKey, true
    mov byte[SlowerScrollRate], al
    
    INI_Get_Int OptionsSection, WidthKey, 640
    mov dword[ScreenWidth], eax
    
    INI_Get_Int OptionsSection, HeightKey, 400
    mov dword[ScreenHeight], eax
    
    mov ecx, 1
    jmp 0x00461135
@ENDHACK
