/* Default linker script, for normal executables */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("coff-i386")
ENTRY (_start)
SECTIONS
{
  .text  SIZEOF_HEADERS : {
     *(.init)
    *(.text)
     *(.fini)
     etext  =  .;
  }
  .data  0x400000 + (. & 0xffc00fff) : {
    *(.data)
     edata  =  .;
  }
  .bss  SIZEOF(.data) + ADDR(.data) :
  {
    *(.bss)
    *(COMMON)
     end = .;
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
