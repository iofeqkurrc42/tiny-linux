GCC := gcc
CCFLAG := -I ../include-nostdinc -Wall -fno-pic -fomit-frame-pointer -c -m32 -Wmain
LDFLAG := -Ttext 0x0 -s --oformat binary -m elf_i386
INCDIR := ../include
OBJS := head.o main.o sched.o chr_drv/chr_drv.a

system: $(OBJS)
	$(LD) $(LDFLAG) -e startup_32 -o $@ $^

head.o:head.S
	$(GCC) -m32 -traditional -c -o $@ $<

main.o:main.c
	$(GCC) $(CCFLAG) -o $@ $<

sched.o:sched.c
	$(GCC) $(CCFLAG) -o $@ $<

chr_drv/chr_drv.a: chr_drv/*.c
	cd chr_drv; make chr_drv.a;cd ..

clean:
	rm *.o
	rm -f system
	cd chr_drv; make clean;cd ..
