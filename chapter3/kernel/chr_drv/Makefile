AR := ar
LD := ld
GCC := gcc
CCFLAG:=-m32 -I../../include -ffreestanding -fno-pic -Wall -fomit-frame-pointer -fno-stack-protector -c
vOBJS :=tty_io.o console.o

tty_io.o: tty_io.c
	$(GCC) $(CCFLAG) -o $@ $<

console.o: console.c
	$(GCC) $(CCFLAG) -o $@ $<

chr_drv.a: $(vOBJS)
	$(AR) rcs $@ $^
	sync

clean:
	rm *.o
	rm chr_drv.a
