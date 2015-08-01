/* Default linker script, for normal executables */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("elf32-hppa")
OUTPUT_ARCH(hppa)
ENTRY($START$)
SECTIONS
{
  .text 0x1000 +0x1000:
  {
    __text_start = .;
    CREATE_OBJECT_SYMBOLS
    *(.PARISC.stubs)
    *(.text)
    etext = .;
    _etext = .;
  }
  . = 0x40000000;
  .data :
  {
     . = . + 0x1000 ;
    __data_start = .;
    *(.data)
    CONSTRUCTORS
    edata = .;
    _edata = .;
  }
  . = 0x40000000 + SIZEOF(.data);
  .bss :
  {
   *(.bss)
   *(COMMON)
   end = . ;
   _end = . ;
  }
}
