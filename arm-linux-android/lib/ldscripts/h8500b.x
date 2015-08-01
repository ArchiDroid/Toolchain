/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("coff-h8500")
OUTPUT_ARCH(h8500)
/* Code and data, both larger than 64k */
SECTIONS
{
.text  0x10000 :
	{
	  *(.text)
	   _etext = . ;
	}
.data   0x20000 :
	{
	  *(.data)
	   _edata = . ;
	}
.rdata   0x30000 :
	{
	  *(.rdata);
	  *(.strings)

    ___ctors = . ;
    *(.ctors)
    ___ctors_end = . ;
    ___dtors = . ;
    *(.dtors)
    ___dtors_end = . ;
	}
.bss   0x40000 :
	{
	   __start_bss = . ;
	  *(.bss)
	  *(COMMON)
	   _end = . ;
	}
.stack   0x50000 :
	{
	   _stack = . ;
	  *(.stack)
	}
.stab  0 (NOLOAD) :
	{
	  [ .stab ]
	}
.stabstr  0 (NOLOAD) :
	{
	  [ .stabstr ]
	}
}
