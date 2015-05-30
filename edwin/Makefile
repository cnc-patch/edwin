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
            src/edwin.ini-func.o \
            src/edwin.ini.o \
            src/limit_cpu_usage.o \
            src/show_tilebrowser_hotkey.o \
            src/cut_selected_area.o \
            src/single_proc_affinity.o \
            src/keep_rules_ini_mods.o \
            src/window_procedure.o \
            src/no_disk_space_error.o \
            src/custom_mix_names.o \
            src/multiple_instances.o \
            src/change_window_title.o \
            src/slower_scrollrate.o \
            src/hires.o \
            src/load_map_command_line.o \
            src/theaters.o \
            src/crash_fixes.o \
            src/longer_filenames.o \
            src/improved_error_messages.o \
            \
            watcall.o \
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
