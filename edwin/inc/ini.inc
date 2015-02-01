cextern INIClass__Get_Int
cextern INIClass__Get_String
cextern INIClass__Get_Bool
cextern INIClass__Put_Int
cextern INIClass__Put_String
cextern INIClass__Put_Bool

; args: <INIClass>, <section>, <key>, <default>
%macro INI_Get_Bool 4
    MOV ECX, DWORD %4
    MOV EBX, DWORD %3
    MOV EDX, DWORD %2
    MOV EAX, %1
    CALL INIClass__Get_Bool
%endmacro

; args: <INIClass>, <section>, <key>, <default>
%macro INI_Get_Int 4
    MOV ECX, DWORD %4
    MOV EBX, DWORD %3
    MOV EDX, DWORD %2
    MOV EAX, %1
    CALL INIClass__Get_Int
%endmacro

; args: <INICLASS> <section>, <key>, <default>, <dst>, <dst_len>
%macro INI_Get_String 6
    PUSH %6             ; dst len
    PUSH %5             ; dst
    MOV ECX, DWORD %4   ; default
    MOV EBX, DWORD %3   ; key
    MOV EDX, DWORD %2   ; section
    MOV EAX, %1
    CALL INIClass__Get_String
%endmacro

; args: <INIClass>, <Section>, <Key>, <String Value>
%macro INI_Put_String 4
	mov     ebx, %3
	mov     edx, %2
	mov     ecx, %4
	mov		eax, %1
	call    call INIClass__Put_String
%endmacro

; args: <INIClass>, <Section>, <Key>, <Int Value>
%macro INI_Put_Int 4
	push    0
	mov     ebx, %3 
	mov     edx, %2
	mov     eax, %1
	mov     ecx, %4
	call    INIClass__Put_Int
%endmacro

; args: <INIClass>, <Section>, <Key>, <Bool Value>
%macro INI_Put_Bool 4
	mov     ebx, %3 
	mov     edx, %2
	mov     eax, %1
	mov		ecx, %4
	call	INIClass__Put_Bool
%endmacro

; args: <INIClass>, <Section>, <Key>, <Bool Value>
%macro INI_Put_Bool_Ptr 4
    xor ecx, ecx
    mov     cl, byte[%4]
	mov     ebx, %3 
	mov     edx, %2
	mov     eax, %1
	call	INIClass__Put_Bool
%endmacro
