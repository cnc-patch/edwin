%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

sstring windowTitle, "RA Editor - Press Ctrl+TAB to unlock the cursor"

@PATCH 0x004744C6
    mov eax, windowTitle
@ENDPATCH
