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

