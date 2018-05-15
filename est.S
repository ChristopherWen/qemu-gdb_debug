.global _start
_start:
	.text
	mov x1,#6
	mov x2,#9
	bl loop
	b label
	
loop:
	add x3,x1,x2
	cmp x3,#21
	BR x30
	ADD x3,x3,x1
	bl loop

label:
	mov x1,x2

.end _start

