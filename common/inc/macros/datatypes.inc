%include "macros/extern.inc"

%define true 1
%define false 0

%macro gstring 2
    [section .rdata]
    cglobal %1
    %1 db %2,0
    __SECT__
%endmacro

%macro sstring 2
    [section .rdata]
    %1 db %2,0
    __SECT__
%endmacro

%macro gstring 3
    [section .data]
    cglobal %1
    %1 db %2
    %strlen ___StringLength %2
    times ((%3) - (___StringLength)) db 0
    __SECT__
%endmacro

%macro sstring 3
    [section .data]
    %1 db %2
    %strlen ___StringLength %2
    times ((%3) - (___StringLength)) db 0
    __SECT__
%endmacro

%macro gint 2
    [section .data]
    cglobal %1
    %1 dd %2
    __SECT__
%endmacro

%macro sint 2
    [section .data]
    %1 dd %2
    __SECT__
%endmacro

%macro gshort 2
    [section .data]
    cglobal %1
    %1 dw %2
    __SECT__
%endmacro

%macro sshort 2
    [section .data]
    %1 dw %2
    __SECT__
%endmacro

%macro gbyte 2
    [section .data]
    cglobal %1
    %1 db %2
    __SECT__
%endmacro

%macro sbyte 2
    [section .data]
    %1 db %2
    __SECT__
%endmacro

%macro gfunction 1
    [section .text]
    align 16, db 0xCC
    cglobal %1
    %1:
%endmacro

%macro sfunction 1
    [section .text]
    align 16, db 0xCC
    %1:
%endmacro

%macro gbytes 2
    [section .bss]
    cglobal %1
    %1: resb %2
    __SECT__
%endmacro

%macro sbytes 2
    [section .bss]
    %1: resb %2
    __SECT__
%endmacro
