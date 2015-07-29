export PATH:=/opt/Freescale/KDS_3.0.0/toolchain/bin:${PATH}

all: test

CFLAGS=-g -ggdb -Os -Wall -fno-strict-aliasing -ffunction-sections -fdata-sections -fno-exceptions -fno-delete-null-pointer-checks -fmessage-length=0 -fno-builtin -mthumb -mcpu=cortex-m0plus -MMD -MP -DTOOLCHAIN_GCC_ARM -DNDEBUG -I.  -std=gnu99

# LDFLAGS=-mcpu=cortex-m0plus -mthumb -Os -T ./MKL05Z4.ld -I. -specs=nano.specs -Wl,-Map=./blink.map,--gc-sections  -lm -lgcc -lc -lnosys

test: test.c
	arm-none-eabi-gcc ${CFLAGS} -ggdb -T test.ld -nostdlib $< -o $@
	arm-none-eabi-objcopy -O srec $@ $@.s19
	arm-none-eabi-objcopy -O binary -v $@ $@.bin
	arm-none-eabi-objcopy -O ihex -v $@ $@.ihex
	arm-none-eabi-objdump -D $@ > test.TXT
	arm-none-eabi-nm test > test.nm
	arm-none-eabi-objdump -d test > test.txt

clean:
	-rm -f test test.nm test.txt *.d test.s19 test.bin test.TXT test.ihex


jlink:
	/home/george/FRDM-KL05Z/JLink_Linux_V501c_i386/JLinkGDBServer 

flash:
	arm-none-eabi-gdb -x flash.gdb

ram:
	arm-none-eabi-gdb -x ram.gdb

ci:
	-ci -l -m"regular checkin" -t-"regular checkin" Makefile  README  flash.gdb  ram.gdb  test.c  test.ld

