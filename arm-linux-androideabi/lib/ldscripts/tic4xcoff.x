/* Default linker script, for normal executables */
/* Linker script for TMS320C4x executable.  */
/* Copyright (C) 2014 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("coff2-tic4x")
OUTPUT_ARCH("tic4x")
ENTRY (_start)
 __HEAP_SIZE = DEFINED(__HEAP_SIZE) ? __HEAP_SIZE : 0x4000;
 __STACK_SIZE  = DEFINED(__STACK_SIZE)  ? __STACK_SIZE  : 0x1000;
/* C30 memory space.  */
MEMORY
{
   EXT0  :  org = 0x0000000, len = 0x800000  /* External address bus.  */
   XBUS  :  org = 0x0800000, len = 0x002000  /* Expansion bus.         */
   IOBUS :  org = 0x0804000, len = 0x002000  /* I/O BUS.               */
   RAM0  :  org = 0x0809800, len = 0x000400  /* Internal RAM block 0.  */
   RAM1  :  org = 0x0809a00, len = 0x000400  /* Internal RAM block 1.  */
   RAM   :  org = 0x0809800, len = 0x000800  /* Internal RAM.          */
   EXT1  :  org = 0x080a000, len = 0x7f6000  /* External address bus.  */
}
/* In the small memory model the .data and .bss sections must be contiguous
   when loaded and fit within the same page.   The DP register is loaded
   with the page address.  */
SECTIONS
{
  /* Reset, interrupt, and trap vectors.  */
  .vectors  0 : {
    *(.vectors)
  }  > EXT0
  /* Constants.  */
  .const : {
    *(.const)
  }  > EXT0
  /* Program code.  */
  .text : {
      __text =  .;
     *(.init)
    *(.text)
     ___CTOR_LIST__ = .;
     LONG(___CTOR_END__ - ___CTOR_LIST__ - 2)
     *(.ctors)
     LONG(0);
     ___CTOR_END__  = .;
     ___DTOR_LIST__ = .;
     LONG(___DTOR_END__ - ___DTOR_LIST__ - 2)
     *(.dtors)
     LONG(0)
     ___DTOR_END__  = .;
     *(.fini)
      __etext =  .;
  }  > EXT0
  /* Global initialised variables.  */
  .data :
  {
      __data  =  .;
    *(.data)
      __edata  = .;
  }  > EXT0
  /* Global uninitialised variables.  */
  .bss : {
     __bss  =  .;
    *(.bss)
    *(COMMON)
      __end  =  .;
  }  > EXT0
  /* Heap.  */
  .heap :
  {
     __heap  =  .;
     . += __HEAP_SIZE;
  }  > EXT0
  /* Stack (grows upward).  */
  .stack :
  {
     __stack  =  .;
    *(.stack)
     .  =  . + __STACK_SIZE;
  }  > EXT0
  .stab 0 (NOLOAD) :
  {
    [ .stab ]
  }
  .stabstr 0 (NOLOAD) :
  {
    [ .stabstr ]
  }
}
