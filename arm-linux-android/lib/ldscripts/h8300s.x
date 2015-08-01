/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("coff-h8300")
OUTPUT_ARCH(h8300s)
ENTRY (_start)
/* The memory size is 256KB to coincide with the simulator.
   Don't change either without considering the other.  */
MEMORY
{
	/* 0xc4 is a magic entry.  We should have the linker just
	   skip over it one day...  */
	vectors : o = 0x0000, l = 0xc4
	magicvectors : o = 0xc4, l = 0x3c
	/* We still only use 256k as the main ram size.  */
	ram    : o = 0x0100, l = 0x3fefc
	/* The stack starts at the top of main ram.  */
	topram : o = 0x3fffc, l = 0x4
	/* This holds variables in the "tiny" sections.  */
	tiny   : o = 0xff8000, l = 0x7f00
	/* At the very top of the address space is the 8-bit area.  */
	eight  : o = 0xffff00, l = 0x100
}
SECTIONS
{
.vectors :
	{
	  /* Use something like this to place a specific
	     function's address into the vector table.
	     LONG (ABSOLUTE (_foobar)).  */
	  *(.vectors)
	}  > vectors
.text :
	{
	  *(.rodata)
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
.data :
	{
	  *(.data)
	   _edata = . ;
	}  > ram
.bss :
	{
	   _bss_start = . ;
	  *(.bss)
	  *(COMMON)
	   _end = . ;
	}  >ram
.stack :
	{
	   _stack = . ;
	  *(.stack)
	}  > topram
.tiny :
	{
	  *(.tiny)
	}  > tiny
.eight :
	{
	  *(.eight)
	}  > eight
.stab 0 (NOLOAD) :
	{
	  [ .stab ]
	}
.stabstr 0 (NOLOAD) :
	{
	  [ .stabstr ]
	}
}
