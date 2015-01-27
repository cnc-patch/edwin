%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

cextern strcpy

gstring RedalertMixPath, "raed1.mix", 256
gstring MainMixPath, "raed.mix", 256

sstring sfmainMix, "%c:", 256

@PATCH 0x0043DA10 ;Load redalert.mix
    mov edx, RedalertMixPath
@ENDPATCH

@PATCH 0x0043DBDA ;Load main.mix
    mov edx, MainMixPath
@ENDPATCH

@HACK 0x00420867, StringFormatMainMix
    pushad
    mov edx, MainMixPath
    mov eax, sfmainMix+3
    call strcpy
    popad
    mov eax, sfmainMix
    jmp 0x0042086C
@ENDHACK
