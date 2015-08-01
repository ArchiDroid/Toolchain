/* Default linker script, for normal executables */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("a.out-tic30")
OUTPUT_ARCH(tms320c30)
PROVIDE (__stack = 0);
SECTIONS
{
  . = 0x0;
  .text :
  {
    CREATE_OBJECT_SYMBOLS
    *(.text)
    _etext = .;
    __etext = .;
  }
  . = ALIGN(128);
  .data :
  {
    *(.data)
    _edata  =  .;
    __edata  =  .;
  }
  .bss :
  {
    __bss_start = .;
   *(.bss)
   *(COMMON)
   _end = ALIGN(4) ;
   __end = ALIGN(4) ;
  }
}
