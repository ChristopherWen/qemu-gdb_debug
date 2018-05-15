#include <stdio.h>
typedef unsigned long long int pte_t;
int main(int a)
{
/*pte_t array[18];
__asm__ __volatile__("ldr x0, =0xfffff\n\t"
	"mov x1, #0\n\t"
	"add x1, x0, #:lo4:array"
	);
*/
	unsigned int p0 = 10;
	const char * p1 = "wen";
	unsigned long int p2 = 10;
	unsigned long long int p3 = 10;
	/*printf("what the fuck is?");
	printf("unsigned int 占用的字节数是：%d\n", sizeof(p0));
	printf("const char * 占用的字节数是：%d\n", sizeof(p1));
        printf("unsigned long int占用的字节数是：%d\n", sizeof(p2));
        printf("unsigned long long int占用的字节数是：%d\n", sizeof(p3));
	*/
	/*新加的*/
	unsigned long x = 0x66;
        __asm__ volatile("mov   x14, %0\n\t"
                        ::"r"(x));
        return (x+a);
	/*若出问题，则删除上面这段，回复下面这行代码*/
	//return a;
}


