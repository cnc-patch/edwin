-include ../config.mk

GAME        = edwin

LSCRIPT     = link.lds
ORIGBIN     = bin.dat
INBIN       = bin.o
ALIGNMENT   = 0x0200

IMPORT      = 1 0x140000 3308


INCLUDES    = -Iinc/ -I../shared/inc/ -I../common/inc/

LIBS        = -nostdlib
OBJS        = \
            src/window_procedure.o \
            src/no_disk_space_error.o \
            src/load_standalone_files.o \
            src/allow_multiple_instances.o \
            src/change_window_title.o \
            src/slower_scrollrate.o \
            src/edwin.ini.o \
            src/hires.o \
            src/mega_map.o \
            src/theaters.o \
            \
            sym.o \
            res/res.o


DLL_OBJS    = bin.o # now this is a hack

.PHONY: default
default: $(GAME).exe

$(INBIN):
	$(PETOOL) pe2obj $(ORIGBIN) $(INBIN)

$(GAME).exe: .dump-.patch-.import-.$(GAME).exe
	$(CP) $< $@

pure-$(GAME).exe: .dump-.import-.pure-$(GAME).exe
	$(CP) $< $@


include ../common/generic.mk

WFLAGS	   += -Ires/ -I../shared/res/ -I../common/res/
