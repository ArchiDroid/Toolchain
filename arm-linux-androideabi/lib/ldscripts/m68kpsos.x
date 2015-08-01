/* Default linker script, for normal executables */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT(elf32-m68k)
OUTPUT_ARCH(m68k)
SECTIONS
{
  .text   0x20000 : {
     start = DEFINED(_START) ? _START : DEFINED(_start) ? _start : .;
     PROVIDE(__text = .);
    *(.text);
    *(code);
    *(const);
    *(strings);
    *(pSOS);
    *(pROBE);
    *(pNA);
    *(pHILE);
    *(pREPC);
    *(pRPC);
     ___CTOR_LIST__ = .;
     LONG((___CTOR_END__ - ___CTOR_LIST__) / 4 - 2)
     *(.ctors)
     LONG(0);
     ___CTOR_END__ = .;
     ___DTOR_LIST__ = .;
     LONG((___DTOR_END__ - ___DTOR_LIST__) / 4 - 2);
     *(.dtors);
     LONG(0);
     ___DTOR_END__ = .;
     PROVIDE(__etext = .);
     PROVIDE(_etext = .);
  }
  .data   :  AT(ADDR(.text) + SIZEOF(.text)) {
     PROVIDE(__data = .);
    *(.data);
    *(vars);
     PROVIDE(__edata = .);
     PROVIDE(_edata = .);
  }
  .bss   :
  {
     PROVIDE(__bss = .);
    *(.bss);
    *(zerovars);
    *(COMMON);
     PROVIDE(__ebss = .);
     PROVIDE(__end = .);
     PROVIDE(_end = .);
     PROVIDE(_FreeMemStart = .);
  }
  .stab 0 (NOLOAD) :
  {
    *(.stab);
  }
  .stabstr 0 (NOLOAD) :
  {
    *(.stabstr);
  }
}
