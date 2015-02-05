%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

cextern MapInfoStruct
cextern TileBrowserDialog
;Show the tilebrowser dialog when space was pressed instead of showing the options menu
@CALL 0x0044A048, TileBrowserDialog

@PATCH 0x0044A043 
    mov eax, MapInfoStruct
@ENDPATCH
