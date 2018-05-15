/*OUTPUT_FORMAT("elf64littlearm","elf64littlearm","elf64littlearm")*/
/*指定输出可执行文件的平台为ARM*/
ENTRY(_start)
SECTIONS
{
	. = 0x40080004;
	/*. = ALIGN(4);*/
	/*.text 0x40000022 : AT(0x40080000)*/
	.text :
	{
	test.o(.text)
	itest.o(.text)
	/*test_asm_args = 0x40080000;*/
	
	*(.text) 
	
	/*. = 0x40080fff;*/
	/*lbreak = .;*/
	} 
	
	. = ALIGN(4);
}
