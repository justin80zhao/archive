# A simple Makefile written by Justin.Zhao

TARGET := mytest
OBJS := mytest.o
BIN := ~/bin/

# complier
CC := g++
# linker
#LD := ld
LD := g++
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
CFLAGS := -c -g -W -Wall -O2 -std=c++11
LFLAGS := -pthread

$(TARGET) : $(OBJS)
	$(LD) $(LIBS) $(LFLAGS) -o $@ $<
	$(DUMP) -h -S $@ > $(TARGET).elf

%.o : %.c %.S
	$(CC) $(INCLUDES) $(CFLAGS) -o $@ $<

clean:
	$(RM) $(TARGET) $(OBJS) *.elf

install:
	$(MV) $(TARGET) $(BIN)
    
# claim the pseduo target
.PHONY: clean install
