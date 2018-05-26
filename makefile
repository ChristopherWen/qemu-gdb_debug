CC=aarch64-linux-gnu-gcc
LD=aarch64-linux-gnu-ld
OBJDUMP=aarch64-linux-gnu-objdump
OBJCOPY=aarch64-linux-gnu-objcopy
GDBINIT:=gdbinit

C++=aarch64-linux-gun-g++

define gdbinit =
	@aarch64-linux-gnu-gdb -x $(GDBINIT)
endef

OBJ := test
OBJ : $(OBJ).S
	$(CC) -g -c -I/home/wsy/桌面/rTT/ -o $(OBJ).o $(OBJ).S
	@#$(CC) -g -c -o $(OBJ).o $(OBJ).S
	$(CC) -g -c -o itest.o itest.c
	@#$(LD) -Ttext 0x40080000 -g $(OBJ).o itest.o -o $(OBJ).elf
	$(LD) -T a.lds -g $(OBJ).o itest.o -o $(OBJ).elf
	$(OBJCOPY) -O binary $(OBJ).elf $(OBJ).bin
	$(OBJDUMP) -D $(OBJ).elf > $(OBJ).dump
clean:
	rm *.o *.elf *.bin *.dump

.PHONY: gdbinit test sub_test sub_clean args
gdbinit:
	$(gdbinit)

CFILE := itest

test: $(CFILE).S

$(CFILE).S:
	$(CC) -g -c $(CFILE).c -o $(CFILE).o
	$(LD) -Ttext 0x40080000 -g $(CFILE).o -o $(CFILE).elf
	$(OBJCOPY) -O binary $(CFILE).elf $(CFILE).bin
	$(OBJDUMP) -d $(CFILE).elf > $(CFILE).dump

#这是函数调用汇编，汇编再调用函数的编译脚本部分
CALLER := main
CALLEE := itest
args:
	$(CC) -g -c -I/home/wsy/桌面/rTT/ -o $(OBJ).o $(OBJ).S
	@#$(CC) -g -c -o $(OBJ).o $(OBJ).S
	@#$(CC) -g -c -o $(CALLEE).o $(CALLER).o $(CALLEE).c $(CALLER).c
	$(CC) -g -c $(CALLEE).c $(CALLER).c
	@#$(LD) -Ttext 0x40080000 -g $(OBJ).o $(CALLEE).o -o $(OBJ).elf
	$(LD) -T a.lds -g $(OBJ).o $(CALLEE).o $(CALLER).o -o $(OBJ).elf
	$(OBJCOPY) -O binary $(OBJ).elf $(OBJ).bin
	$(OBJDUMP) -D $(OBJ).elf > $(OBJ).dump

sub_test:
#	$(CC) -E $(CFILE).c -o $(CFILE).i
#	$(CC) -S $(CFILE).i -o $(CFILE).S
	$(CC) -g -c $(CFILE).c -o $(CFILE).o
	$(LD) -Ttext 0x40080000 -g $(CFILE).o -o $(CFILE).elf
	$(OBJCOPY) -O binary $(CFILE).elf $(CFILE).elf
	$(OBJDUMP) -d $(CFILE).elf > $(CFILE).dump
	$(CC) itest.o -o itest

sub_clean:
	@rm -r itest.o itest.S itest.dump itest.bin itest.elf itest.i
