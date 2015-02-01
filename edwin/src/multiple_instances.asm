%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

@CLEAR 0x0046051E, 0x90, 0x00460524
@SJMP 0x0046051E, 0x00460548
