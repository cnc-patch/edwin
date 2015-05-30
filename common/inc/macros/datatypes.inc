%include "macros/extern.inc"

%macro gstring 2
    cglobal %1
    sstring %1, %2
%endmacro

%macro sstring 2
    [section .rdata]
    %1 db %2,0
    __SECT__
%endmacro

%macro gstring 3
    cglobal %1
    sstring %1, %2, %3
%endmacro

%macro sstring 3
    %strlen ___StringLength %2
    
    %if ___StringLength > 0
        [section .data]
        %1 db %2
        times ((%3) - (___StringLength)) db 0
        __SECT__
    %else
        [section .bss]
        %1 resb %3
        __SECT__
    %endif
%endmacro

%macro gint 2
    cglobal %1
    sint %1, {%2}
%endmacro

%macro sint 2
    %ifidni %2,0
        [section .bss]
        %1 resd 1
        __SECT__
    %else
        [section .data]
        %1 dd %2
        __SECT__
    %endif
%endmacro

%macro gshort 2
    cglobal %1
    sshort %1, {%2}
%endmacro

%macro sshort 2
    %ifidni %2,0
        [section .bss]
        %1 resw 1
        __SECT__
    %else
        [section .data]
        %1 dw %2
        __SECT__
    %endif
%endmacro

%macro gbyte 2
    cglobal %1
    sbyte %1, {%2}
%endmacro

%macro sbyte 2
    %ifidni %2,0
        [section .bss]
        %1 resb 1
        __SECT__
    %else
        [section .data]
        %1 db %2
        __SECT__
    %endif
%endmacro

%macro gbyte 3
    cglobal %1
    sbyte %1, {%2}, %3
%endmacro

%macro sbyte 3
    %ifidni %2,0
        [section .bss]
        %1 resb %3
        __SECT__
    %else
        [section .data]
        %1 times %3 db %2
        __SECT__
    %endif
%endmacro

%macro gfunction 1
    cglobal %1
    sfunction %1
%endmacro

%macro sfunction 1
    [section .text]
    align 16, db 0xCC
    %1:
%endmacro

%macro gfile 2
    cglobal %1
    cglobal %1Length
    sfile %1, %2
%endmacro

%macro sfile 2
    [section .rdata]
    %1 incbin %2
    %1Length dd $-%1
    __SECT__
%endmacro
