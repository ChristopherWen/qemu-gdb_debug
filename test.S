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
	beq test
	bne test
start2:
	ldr x1,=0x301
	ands x1, x1, x3
	beq test2
	bne test2
start3:
	ldr x1,=0x10
	ldr x0,=0x11
	subs x1, x1, x0
	bne .break
	beq .break
	subs x3, x0, x1
#	这个subs命令相当于sub和cmp的结合体，做减法的同时判断x0和x1这两个寄存器里的值的大小
	bhi .break
	blt .break
	bls .Lbre
test:
	b start2
test2:
	b start3

break_test:	
	MOV X1,#3
	BL .Lbre

temp .req x17

.Lbre:
	str x1, [x1]
	str x0, [x3]
	ldr x9, [x1]
	ldr x16, [x1, #8]
	ldp x11,x12,[x1]
	ldr x14,=0x0
	add x11,x11,x14
	add x12,x11,x14
        ADD X1,X1,#6
        LDR X3,=0x010200040
	ubfx x4, x3, #20, #4
#	这行命令里ubfx 的用处是从x3寄存器的第20位开始截4位出来存到x4寄存器中
#	add x4, x3, #:lo12:x3
        MOV X4,#2
.break:
        STR X4,[X3]
        LDR X5,[X3]
        mov X15,X30
	mrs temp, sctlr_el1
	bic temp, temp, #(1<<4);
	bic temp, temp, x0, lsl #5
	ldr x16, =0b0
	orr x16, x16, #(1<<1)
	BL .Lexit
	bl .iLbreak_test
        mov x30,x15
        BR x30

.Lexit:
	LDR x1,=0x0
	ret x30

.iLbreak_test:
	ADD X0,X0,X1
	MOV X0,#0x18
	LDR X1,=0x20026
	BR x30
