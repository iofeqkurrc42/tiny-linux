#define __LIBRARY__

void main(void) {
    tty_init();
    __asm__ __volatile__(
        "loop: \n\r"
        "jmp loop\n\r"
    ::);
}
