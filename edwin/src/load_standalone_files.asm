%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

sstring mainMix, "raed.mix"
sstring sfmainMix, "%c:raed.mix"
sstring redalertMix, "raed1.mix"
sstring redalertIni, "edwin.ini"

@PATCH 0x0043DBDA
    mov edx, mainMix
@ENDPATCH

@PATCH 0x00420867
    mov eax, sfmainMix
@ENDPATCH

@PATCH 0x0043DA10
    mov edx, redalertMix
@ENDPATCH

@PATCH 0x004607D2
    mov edx, redalertIni
@ENDPATCH
