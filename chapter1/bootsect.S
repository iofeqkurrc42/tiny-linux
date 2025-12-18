BOOTSEG=0x7c0

.code16
.text

.global _start
_start:
    jmpl $BOOTSEG,$start2

start2:
    movw $BOOTSEG,%ax
    movw %ax,%ds
    movw %ax,%es
    movw %ax,%fs
    movw %ax,%gs

    movw $msg,%ax
    movw %ax,%bp
    movw $0x01301,%ax
    movw $0x0c,%bx  #⽂字为红⾊
    movw $12,%cx   #字符串⻓度
    movb $0,%dl
    int $0x010    #通知显卡刷新内容

loop:
    jmp loop

msg:
    .ascii "Hello World!"

.org 510
boot_flag:
    .word 0xaa55
