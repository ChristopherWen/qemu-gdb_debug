.text
.global _start
_start:
	ldr x1, =0x301
	ldr x0, =0x10
	#mov x0, #0
	#mov x1, #1
	#mov x2, #2
	#mov x3, #3
#	tst x1, #(1 << 4) - 1
#	tst命令和ands命令操作基本相似，都是进行与操作之后判断结果pstate[N,C,Z,V]，注意一点：两个位数不等的寄存器进行与操作时，位数少的那方不足位全部补成零在进行与操作。
	ands x1, x1, x0
	#str x30,[sp, #-4]
	mov x0, x1
	.extern main
	bl main
	#ldr x30,[sp],#4
	beq _start
	bne _start
start2:
	ldr x1,=0x301
	ands x1, x1, x3
	beq start2
	bne start2
start3:
	ldr x1,=0x10
	ldr x0,=0x11
	subs x1, x1, x0
	bne start3
	beq start3
	subs x3, x0, x1
#	这个subs命令相当于sub和cmp的结合体，做减法的同时判断x0和x1这两个寄存器里的值的大小
	bhi start3
	blt start3
	bls _start 
