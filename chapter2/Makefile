AS := as
LD := ld -m elf_x86_64

LDFLAG := -Ttext 0x0 -s --oformat binary

image : linux.img

linux.img : tools/build bootsect setup
	./tools/build bootsect setup > $@

tools/build : tools/build.c
	gcc -o $@ $<

bootsect : bootsect.o
	$(LD) $(LDFLAG) -o $@ $<

bootsect.o : bootsect.S
	$(AS) -o $@ $<

setup : setup.o
	$(LD) $(LDFLAG) -e _start_setup -o $@ $<

setup.o : setup.S
	$(AS) -o $@ $<


clean:
	rm -f *.o
	rm -f bootsect
	rm -f setup
	rm -f tools/build
	rm -f linux.img
	rm -rf bochsout.txt bx_enh_dbg.ini
