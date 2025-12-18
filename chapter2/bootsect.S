SETUPLEN=4

BOOTSEG=0x7c0

INITSEG=0x9000

SETUPSEG=0x9020

SYSSEG=0x1000

ENDSEG=SYSSEG+SYSSIZE

ROOT_DEV=0x000

.code16

.text

.global _start
_start:
    jmpl $BOOTSEG,$start2

start2:
    movw $BOOTSEG,%ax
    movw %ax,%ds
    movw $INITSEG,%ax
    movw %ax,%es
    movw $256,%cx
    subw %si,%si
    subw %di,%di

    rep
    movsw

    jmpl $INITSEG,$go

go:
    movw %cs,%ax
    movw %ax,%ds
    movw %ax,%es
    movw %ax,%ss
    movw $0xFF00,%sp

load_setup:
    movw $0x0000,%dx
    movw $0x0002,%cx
    movw $0x0200,%bx
    movb $SETUPLEN,%al
    movb $0x02,%ah
    int $0x13
    jnc ok_load_setup
    movw $0x0000,%dx
    movw $0x0000,%ax
    int $0x13
    jmp load_setup

ok_load_setup:

    movw $msg,%ax
    movw %ax,%bp
    movw $0x01301,%ax
    movw $0x0c,%bx
    movw $21,%cx
    movb $0,%dl
    int $0x010

    jmpl $SETUPSEG,$0

msg:
.ascii "Setup has been loaded"

.org 508
root_dev:
    .word ROOT_DEV
boot_flag:
    .word 0xaa55
