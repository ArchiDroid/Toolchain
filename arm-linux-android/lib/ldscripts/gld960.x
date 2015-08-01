/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
SECTIONS
{
    .text :
    {
	 CREATE_OBJECT_SYMBOLS
	*(.text)
	 _etext = .;

    }
    .data :
    {
 	*(.data)
	CONSTRUCTORS
	 _edata = .;
    }
    .bss :
    {
	 _bss_start = .;
	*(.bss)
	*(COMMON)
	 _end = .;
    }
}
