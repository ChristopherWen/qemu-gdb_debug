/*OUTPUT_FORMAT("elf64littlearm","elf64littlearm","elf64littlearm")*/
/*指定输出可执行文件的平台为ARM*/
/*ENTRY(_start)*/
ENTRY(test)
SECTIONS
{
	. = 0x40080000;
	/*. = ALIGN(4);*/
	/*.text 0x40000022 : AT(0x40080000)*/
	.text :
	{
	main.o(.text)
	test.o(.text)
	itest.o(.text)
	}
	/*. = ALIGN(16); */
	. = 0x40081000;
	.data :{*(.data)}
	.bss :{*(.bss)}
}
