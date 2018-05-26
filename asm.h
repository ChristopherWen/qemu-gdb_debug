// for local or global functions
#define END_FUNCTION(x) .cfi_endproc; .size x, . - x

//#define LOCAL_DATA(x) .type x,STT_OBJECT; x:
#define LOCAL_DATA(x)  x:; .word 0x1
#define DATA(x) .global x; .hidden x; LOCAL_DATA(x)

// for local or global data
//#define END_DATA(x) .size x, . - x
#define END_DATA(x) .size x, . - x
