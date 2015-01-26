%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"


@PATCH 0x0043C592 ; Size of the empty map that is loaded when the editor was started
    mov ebx, 126
    mov edx, 126
@ENDPATCH
