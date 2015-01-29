%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

@PATCH 0x00474778 ;no assert
    retn
@ENDPATCH

@SJMP 0x0044B16A, 0x0044B195 ;right click unselect crash
