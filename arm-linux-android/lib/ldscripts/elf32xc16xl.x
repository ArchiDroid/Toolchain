/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("elf32-xc16x")
OUTPUT_ARCH(xc16x:xc16xl)
ENTRY (_start)
MEMORY
{
	vectarea : o =0xc00000, l = 0x0300

	introm    : o = 0xc00300, l = 0x16000
	/* The stack starts at the top of main ram.  */

	dram   : o = 0x8000 , l = 0xffff
	/* At the very top of the address space is the 8-bit area.  */

         ldata  : o =0x4000 ,l = 0x0200
}
SECTIONS
{
/*.vects :
        {
        *(.vects)
       }  > vectarea */
.init :
        {
          *(.init)
        }  >introm
.text :
	{
	  *(.rodata)
	  *(.text.*)
	  *(.text)
	  	   _etext = . ;
	}  > introm
.data :
	{
	  *(.data)
	  *(.data.*)

	   _edata = . ;
	}  > dram
.bss :
	{
	   _bss_start = . ;
	  *(.bss)
	  *(COMMON)
	   _end = . ;
	}  > dram
 .ldata :
         {
          *(.ldata)
         }  > ldata
  .vects :
          {
          *(.vects)
       }  > vectarea
}
