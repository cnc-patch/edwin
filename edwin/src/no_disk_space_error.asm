%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

@CLEAR 0x00460851, 0x90, 0x0046085C
@LJMP 0x00460851, 0x004608F4
