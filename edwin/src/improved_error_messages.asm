%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

sstring UnableToSetVideoMode, "Error - Unable to set the video mode. The chosen resolution is not supported, please go to the video options and change it."
sstring UnableToAllocateVideoBuffer, "Error - Unable to allocate primary video buffer. Please check your graphic card drivers or go to the video options and enable CnC-DDraw."

@PATCH 0x00460A10
    mov eax, UnableToSetVideoMode
@ENDPATCH

@PATCH 0x00460B71
    mov eax, UnableToAllocateVideoBuffer
@ENDPATCH
