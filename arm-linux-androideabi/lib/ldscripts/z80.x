/* Default linker script, for normal executables */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
/* Create a cp/m executable; load and execute at 0x100.  */
OUTPUT_FORMAT("binary")
. = 0x100;
__Ltext = .;
ENTRY (__Ltext)
OUTPUT_ARCH("z80")
SECTIONS
{
.text :	{
	*(.text)
	*(text)
	 __Htext = .;
	}
.data :	{
	 __Ldata = .;
	*(.data)
	*(data)
	 __Hdata = .;
	}
.bss :	{
	 __Lbss = .;
	*(.bss)
	*(bss)
	 __Hbss = .;
	}
}
