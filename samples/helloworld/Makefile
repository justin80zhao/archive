# A simple Makefile written by Justin.Zhao

TARGET := mytest
OBJS := mytest.o
BIN := ~/bin/

# complier
CC := gcc
# linker
LD := ld
# archiver
AR := ar

# command
DUMP := objdump
RM := rm -rf
ECHO := echo
MV := mv

INCLUDES := -I/usr/include
#LIBS := -L/xxx/xxx/lib
LIBS := 
#DFLAGS := -DMY_MACRO=1 
DFLAGS :=
CFLAGS := -c -g -W -Wall -O2
LFLAGS := 

$(TARGET) : $(OBJS)
	$(CC) $(LIBS) $(LFLAGS) -o $@ $<
	$(DUMP) -h -S $< > $(TARGET).elf

%.o : %.c %.S
	$(CC) $(INCLUDES) $(CFLAGS) -o $@ $<

clean:
	$(RM) $(TARGET) $(OBJS) *.elf

install:
	$(MV) $(TARGET) $(BIN)
    
# claim the pseduo target
.PHONY: clean install
