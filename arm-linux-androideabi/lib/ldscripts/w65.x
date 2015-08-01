/* Default linker script, for normal executables */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("coff-w65")
OUTPUT_ARCH(w65)
MEMORY
{
	ram   : o = 0x1000, l = 512k
}
SECTIONS
{
.text :
	{
	  *(.text)
	  *(.strings)
   	   _etext = . ;
	}  > ram
	.tors :
  {
    ___ctors = . ;
    *(.ctors)
    ___ctors_end = . ;
    ___dtors = . ;
    *(.dtors)
    ___dtors_end = . ;
  } > ram
.data  :
	{
	  *(.data)
	   _edata = . ;
	}  > ram

.bss  :
	{
	   _bss_start = . ;
	  *(.bss)
	  *(COMMON)
	   _end = . ;
	}  >ram

.stack  0x30000  :
	{
	   _stack = . ;
	  *(.stack)
	}  > ram

.stab  . (NOLOAD) :
	{
	  [ .stab ]
	}

.stabstr  . (NOLOAD) :
	{
	  [ .stabstr ]
	}
}
