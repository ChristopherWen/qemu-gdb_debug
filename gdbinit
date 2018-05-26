set target-async on
set pagination off
symbol-file ./test.elf
set non-stop off
target remote :1234
#layout split
br test_ldr_adr
br save_lr
br restore_lr
br break
layout split
c
info reg $x0 x29 x30 sp pc
