%include "macros/extern.inc"

cextern watcall

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
