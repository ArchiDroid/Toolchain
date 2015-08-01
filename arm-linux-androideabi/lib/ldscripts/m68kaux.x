/* Default linker script, for normal executables */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("coff-m68k-aux")
ENTRY (_start)
SECTIONS
{
  .text  0x40000 + SIZEOF_HEADERS : {
     *(.init)
     *(.fini)
    *(.text)
     . = ALIGN(4);
     *(.ctors)
     *(.dtors)
     etext = .;
     _etext = .;
  } =0x4E714E71
  .data  (. & (-0x40000 | 0x1000-1)) + 0x40000 : {
    *(.data)
     edata = .;
     _edata = .;
  }
  .bss : {
    *(.bss)
    *(COMMON)
     end = .;
     _end = .;
  }
  .comment 0 (NOLOAD) : { [ .comment ] [ .ident ] }
  .stab 0 (NOLOAD) : { [ .stab ] }
  .stabstr 0 (NOLOAD) : { [ .stabstr ] }
}
