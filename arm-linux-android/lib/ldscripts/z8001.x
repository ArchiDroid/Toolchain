/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("coff-z8k")
OUTPUT_ARCH("z8001")
ENTRY (_start)
SECTIONS
{
.text   0x0000000 :
	{
	  *(.text)
	  *(.strings)
	  *(.rdata)
	}
.ctors   0x2000000  :
	{
	   ___ctors = . ;
	  *(.ctors);
	   ___ctors_end = . ;
	  ___dtors = . ;
	  *(.dtors);
	   ___dtors_end = . ;
	}
.data   0x3000000 :
	{
	   *(.data)
	}
.bss   0x4000000 :
	{
	   __start_bss = . ;
	  *(.bss);
	  *(COMMON);
	   __end_bss = . ;
	}
.heap   0x5000000 :
	{
	   __start_heap = . ;
	   . = . + 20k  ;
	   __end_heap = . ;
	}
.stack  0xf000   :
	{
	   _stack = . ;
	  *(.stack)
	   __stack_top = . ;
	}
}
