/* Default linker script, for normal executables */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("coff-tic80")
ENTRY (__start)
SECTIONS
{
  .text  0x2000000 : {
    *(.init)
    *(.fini)
    *(.text)
  }
  .const ALIGN(4) : {
    *(.const)
  }
  .ctors ALIGN(4) : {
     . = ALIGN(4);
     ___CTOR_LIST__ = .;
     LONG(-1)
    *(.ctors)
     ___CTOR_END__ = .;
     LONG(0)
  }
  .dtors ALIGN(4) : {
     ___DTOR_LIST__ = .;
     LONG(-1)
     *(.dtors)
     ___DTOR_END__ = .;
     LONG(0)
  }
   etext  =  .;
  .data : {
    *(.data)
     __edata  =  .;
  }
  .bss : {
     __bss_start = .;
    *(.bss)
    *(COMMON)
      _end = ALIGN(0x8);
      __end = ALIGN(0x8);
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
