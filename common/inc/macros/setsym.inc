%include "macros/extern.inc"

cextern watcall

; for C
%macro setcglob 2
    global _%2
    _%2 equ %1
%endmacro

; for c++
%macro setxglob 3
    setcglob {%1}, {%2}
    global %3
    %3 equ _%2
%endmacro

; watcall functions
%macro setwatglob 3
    global _%2
    global %2
    %2 equ %1
    
    [section .text]
    align 16, db 0xCC
    _%2:
    push %1
    push %3
    jmp watcall
    __SECT__
%endmacro
