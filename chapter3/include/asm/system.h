#ifndef _SYSTEM_H

#define _SYSTEM_H

#define sti() __asm__("sti" ::)
#define cli() __asm__("cli" ::)
#define nop() __asm__("nop" ::)
#define iret() __asm__("iret" ::)

#endif // !_SYSTEM_H
