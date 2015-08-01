/* Default linker script, for normal executables */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("a.out-riscix")
OUTPUT_ARCH(arm)
__DYNAMIC  =  0;
SECTIONS
{
  .text 0x8000:
  {
    CREATE_OBJECT_SYMBOLS
    *(.text)
    _etext = ALIGN(0x8000);
    __etext = ALIGN(0x8000);
  }
  .data  ALIGN(0x8000) :
  {
    *(.data)
    CONSTRUCTORS
    _edata  =  .;
    __edata =  .;
  }
  .bss SIZEOF(.data) + ADDR(.data) :
  {
    __bss_start = .;
   *(.bss)
   *(COMMON)
   _end = ALIGN(4) ;
   __end = ALIGN(4) ;
  }
}
