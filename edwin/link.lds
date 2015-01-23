/* GNU ld linker script for bin.dat */
ENTRY(_start);
SECTIONS
{
    BEGTEXT         0x401000   : { bin.o(BEGTEXT) }
    DGROUP          0x49F000   : { bin.o(DGROUP) }
    .bss            0x4CC000   : { . = 0x73E00; }
    .idata          0x540000   : { bin.o(.idata) }
    /DISCARD/                  : { bin.o(.edata) }
    /DISCARD/                  : { bin.o(.reloc) }
    /DISCARD/                  : { bin.o(.rsrc ) }

    .p_text    ALIGN(0x1000)   : { *(.text); }
    .p_rdata   ALIGN(0x1000)   : { *(.rdata); }
    .p_data    ALIGN(0x1000)   : { *(.data) *(.bss) *(COMMON); }

    .rsrc      ALIGN(0x1000)   : { *(.rsrc) }
    .patch     ALIGN(0x1000)   : { *(.patch) }
}
