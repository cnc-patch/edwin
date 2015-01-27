%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

;Loads any custom theater! Here is how it works:
;Lets say we create a new theater named "herpderp", you will now have to do the following things:
;1. Add the following key to a map to enable it: [Map]Theater=herpderp
;2. Create a mix file named "herpderp.mix"
;3. Create your custom tiles and give them as extension the name ".her" (the first 3 chars of the theater name)
;4. Put your custom tiles into "herpderp.mix" and move "herpderp.mix" into "raed1.mix"

cextern strcpy
cextern strncpy
cextern stricmp

sstring TheaterName, "", 64
sstring TheaterExtension, "", 5
sstring TemperateTheater, "TEMPERATE"
sstring SnowTheater, "SNOW"
sbyte IsCustomTheater, 0

@HACK 0x00409E8C, LoadMap
    pushad
    
    mov byte[IsCustomTheater], 0
    
    mov edx, eax
    mov eax, TheaterName
    call strcpy
    
    mov ebx, 3
    mov edx, TheaterName
    mov eax, TheaterExtension
    call strncpy
    
    mov edx, TheaterName
    mov eax, TemperateTheater
    call stricmp
    cmp eax, 0
    jz .IsOriginalTheater
    
    mov edx, TheaterName
    mov eax, SnowTheater
    call stricmp
    cmp eax, 0
    jz .IsOriginalTheater
    
    mov byte[IsCustomTheater], 1

.IsOriginalTheater:
    popad
    
    cmp byte[IsCustomTheater], 1
    jnz .DoNotOverride
    mov eax, TemperateTheater
    
.DoNotOverride:
    call 0x0041F7DD
    jmp 0x00409E91
@ENDHACK

@HACK 0x0042497E, LoadTheaterMix
    cmp byte[IsCustomTheater], 1
    jnz .out
    mov eax, TheaterName
    jmp 0x00424983

.out:
    add eax, edx
    add eax, 0x10
    jmp 0x00424983
@ENDHACK

@HACK 0x00424A4A, LoadTheaterPal
    cmp byte[IsCustomTheater], 1
    jnz .out
    mov eax, TheaterName
    jmp 0x00424A4F

.out:
    add eax, edx
    add eax, 0x10
    jmp 0x00424A4F
@ENDHACK

@HACK 0x0041FFFD, LoadTheaterUnknown
    cmp byte[IsCustomTheater], 1
    jnz .out
    mov eax, TheaterName
    jmp 0x00420002

.out:
    add eax, edx
    add eax, 0x10
    jmp 0x00420002
@ENDHACK

@HACK 0x0046446C, LoadTiles1
    cmp byte[IsCustomTheater], 1
    jnz .out
    mov eax, TheaterExtension
    jmp 0x00464471

.out:
    add eax, edx
    add eax, 0x1A
    jmp 0x00464471
@ENDHACK

@HACK 0x00418746, LoadTiles2
    cmp byte[IsCustomTheater], 1
    jnz .out
    mov eax, TheaterExtension
    jmp 0x0041874B

.out:
    add eax, edx
    add eax, 0x1A
    jmp 0x0041874B
@ENDHACK

@HACK 0x00454F5C, LoadTiles3
    cmp byte[IsCustomTheater], 1
    jnz .out
    mov eax, TheaterExtension
    jmp 0x00454F61

.out:
    add eax, edx
    add eax, 0x1A
    jmp 0x00454F61
@ENDHACK

@HACK 0x00405711, LoadTiles4
    cmp byte[IsCustomTheater], 1
    jnz .out
    mov eax, TheaterExtension
    jmp 0x00405716

.out:
    add eax, edx
    add eax, 0x1A
    jmp 0x00405716
@ENDHACK

@HACK 0x0045C3A4, LoadTiles5
    cmp byte[IsCustomTheater], 1
    jnz .out
    mov eax, TheaterExtension
    jmp 0x0045C3A9

.out:
    add eax, edx
    add eax, 0x1A
    jmp 0x0045C3A9
@ENDHACK

@REPLACE 0x00409EC6, 0x00409ECD, SaveMap
    cmp byte[IsCustomTheater], 1
    jnz .out
    mov ecx, TheaterName
    jmp 0x00409ECD

.out:
    mov eax, 0x004AE868
    add ecx, eax
    jmp 0x00409ECD
@ENDREPLACE
