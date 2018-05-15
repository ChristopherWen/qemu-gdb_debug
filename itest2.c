#include <stdio.h>
int main()
{
        // printk("test_c_args:\n");
        //printk("%0x %0x %0x %0x\n",a,b,c,d);
        unsigned long x = 0x66;
        __asm__ volatile("mov   x14, %0\n\t"
                        ::"r"(x));
        return (x);
}

