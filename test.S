#include <asm.h>
#include <asm_macros.h>


.text
.global _start
_start:
	#adrp x4, cpu
	#adr_global x4, cpu
	#adr x10, cpu
	
	#adr x10, stack	
	#mov sp, x10

	#AAPCS官方调用规则里对sp(stack pointer)赋值的规定是：
	#At all times the following basic constraints must hold:
	#1 Stack-limit < SP <= stack-base. The stack pointer must lie within the extent of the stack.
	#2 A process may only access (for reading or writing) the closed interval of the entire stack delimited by [SP, stack-base – 1].
	#  Additionally, at any point at which memory is accessed via SP, the hardware requires that 
	#3 SP mod 16 = 0. The stack must be quad-word aligned.
	#ldr x10, =0x400aa000
	#mov sp, x10	
	adr_global x10, stack
	mov sp, x10
test_ldr_adr:	
	#测试指令ldr <xt>, <label>和指令adr <xt>, <label>的区别，区别在于：
	#  ldr:Load Register (literal) calculates an address from the PC value and an immediate offset, loads a word from memory,and writes it to a 		#      register.(计算出label地址，并从该地址指向的内存里取出一个字到目标寄存器中) 
	#  adr:Form PC-relative address adds an immediate value to the PC value to form a PC-relative address, and writes the result to the 		#      destination register.(直接计算label地址，并存到目标寄存器中)
	adr x0, ldrt
	ldr x1, ldrt
	adr x2, ldrt2
	ldr x3, ldrt2
	adr x4, stack
	ldr x5, stack
	adr x6, cpu_data
	ldr x7, cpu_data
	

	#将lr保存到栈里面
save_lr:
	sub sp, sp, #0x40
	#这个地方要注意一点：把x29(fp--aks:frame pointer)和x30(lr--aks:linker register)
	#存到栈里面的时候分别都需要8字节的空间，所以这里用到了"sp+0x10"操作。
	stp x29, x30, [sp, #0x10]
	mov x29, sp
	#sub sp, sp, #0x30
	
	#如果参数传递超过8个的话，就要将参数压到栈里面，并且是以sp向上增长的方向压栈。第九个
	#参数是从[sp]开始，往后的可以逐次存到[sp+8]、[sp+0x10]......栈空间里。
	mov x0, #0x1
	mov x1, #0x1
	mov x2, #0x0
	mov x3, #0x0
	mov x4, #0x0
	mov x5, #0x0
	ldr x6, =0x0
	ldr x7, =0x0
	ldr x9, =0x8
	str x9, [sp]
	ldr x9, =0x3
	str x9, [sp, #8]
	.extern main
	bl main

	#从栈中取出之前保存的lr
restore_lr:
	ldp x29, x30, [sp, #0x10]
	add sp, sp, #0x40
 
break:
	#mov pc, x30	
	ret x30
	
	#mov sp, x29
	#ldp x29, x30, [sp], #40

	#add sp, sp, #10
	#add sp, sp, #0x4
	#add sp, sp, #0x4
	#add sp, sp, #0x4
	#add sp, sp, #0x4
	
#break:
	add x24, x24, #0x1
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
.align 16
stack:
	.quad 1
	.quad 6
ldrt:
	.align 8
ldrt2:
.bss
