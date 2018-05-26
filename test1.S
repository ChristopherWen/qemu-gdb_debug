#include <asm.h>
#include <asm_macros.h>


.text
.global _start
_start:
	adrp x4, cpu
	adr_global x4, cpu
	mov SP, x4	
	adr x5, cpu_data
	ldr x6, [x5]
	adr x3, cpu
	ldr x4, [x3]
	#ands x1, x1, x0
	#stp x29, x30, [sp, #-40]!
	#mov x29, sp
	#mov x0, x1
	mov x0, x6
	mov x1, x4
	mov x2, #0x4
	.extern main
	#add sp, sp, #0x40
	bl main
	add x8, x8, #0x1
	#mov sp, x29
	#ldp x29, x30, [sp], #40
	#add sp, sp, #10
	
	#可能出bug的地方
	#ldr x7, [sp]
	#mov x8, sp
	
	#ldr x30,[sp],#4
	#subs x1, x1, x0	
#start2:
	#ldr x1,=0x301

.data
cpu_data:
	.word 0x1
	.align 8
cpu:
	.word 0x232


.bss
