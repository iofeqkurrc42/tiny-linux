.code16

.text

.globl _start_setup

_start_setup:
    movw %cs,%ax
    movw %ax,%ds
    movw %ax,%es
    movw $setup_msg,%ax
    movw %ax,%bp
    movw $0x01301,%ax
    movw $0x0c,%bx
    movw $16,%cx
    movb $3,%dh
    movb $0,%dl
    int $0x010

setup_msg:
    .ascii "setup is running"
