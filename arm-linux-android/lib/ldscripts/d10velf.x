/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("elf32-d10v", "elf32-d10v",
	      "elf32-d10v")
OUTPUT_ARCH(d10v)
ENTRY(_start)
/* Do we need any of these for elf?
   __DYNAMIC = 0;    */
MEMORY
{
  /* These are the values for the D10V-TS3 board.
     There are other memory regions available on
     the TS3 (eg ROM, FLASH, etc) but these are not
     used by this script.  */
  INSN       : org = 0x01000000, len = 256K
  DATA       : org = 0x02000000, len = 48K
  /* This is a fake memory region at the top of the
     on-chip RAM, used as the start of the
     (descending) stack.  */
  STACK      : org = 0x0200BFFC, len = 4
}
SECTIONS
{
  .text 0x01014000 :
  {
    KEEP (*(SORT_NONE(.init)))
    KEEP (*(SORT_NONE(.init.*)))
    KEEP (*(SORT_NONE(.fini)))
    KEEP (*(SORT_NONE(.fini.*)))
    *(.text)
    *(.text.*)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
    *(.gnu.linkonce.t*)
    _etext = .;
    PROVIDE (etext = .);
  }  >INSN =0
  .rodata 0x02000004 : {
    *(.rodata)
    *(.gnu.linkonce.r*)
    *(.rodata.*)
  }  >DATA
  .rodata1   : {
    *(.rodata1)
    *(.rodata1.*)
   }  >DATA
  .data    :
  {
    *(.data)
    *(.data.*)
    *(.gnu.linkonce.d*)
    CONSTRUCTORS
  }  >DATA
  .data1   : {
    *(.data1)
    *(.data1.*)
  }  >DATA
  .ctors   :
  {
    /* gcc uses crtbegin.o to find the start of
       the constructors, so we make sure it is
       first.  Because this is a wildcard, it
       doesn't matter if the user does not
       actually link against crtbegin.o; the
       linker won't look for a file to match a
       wildcard.  The wildcard also means that it
       doesn't matter which directory crtbegin.o
       is in.  */
    KEEP (*crtbegin.o(.ctors))
    KEEP (*crtbegin?.o(.ctors))
    /* We don't want to include the .ctor section from
       the crtend.o file until after the sorted ctors.
       The .ctor section from the crtend file contains the
       end of ctors marker and it must be last */
    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o) .ctors))
    KEEP (*(SORT(.ctors.*)))
    KEEP (*(.ctors))
  } >DATA
   .dtors         :
  {
    KEEP (*crtbegin.o(.dtors))
    KEEP (*crtbegin?.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
  } >DATA
  /* We want the small data sections together, so single-instruction offsets
     can access them all, and initialized data all before uninitialized, so
     we can shorten the on-disk segment size.  */
  .sdata     : {
    *(.sdata)
    *(.sdata.*)
  }  >DATA
  _edata = .;
  PROVIDE (edata = .);
  __bss_start = .;
  .sbss      : { *(.sbss) *(.scommon) }  >DATA
  .bss       :
  {
   *(.dynbss)
   *(.dynbss.*)
   *(.bss)
   *(.bss.*)
   *(COMMON)
  }  >DATA
  _end = . ;
  PROVIDE (end = .);
   .stack : { _stack = .; *(.stack) } >STACK
  /* Stabs debugging sections.  */
  .stab 0 : { *(.stab) }
  .stabstr 0 : { *(.stabstr) }
  .stab.excl 0 : { *(.stab.excl) }
  .stab.exclstr 0 : { *(.stab.exclstr) }
  .stab.index 0 : { *(.stab.index) }
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment 0 : { *(.comment) }
  /* DWARF debug sections.
     Symbols in the DWARF debugging sections are relative to the beginning
     of the section so we begin them at 0.  */
  /* DWARF 1 */
  .debug          0 : { *(.debug) }
  .line           0 : { *(.line) }
  /* GNU DWARF 1 extensions */
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  /* DWARF 1.1 and DWARF 2 */
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  /* DWARF 2 */
  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
  .debug_abbrev   0 : { *(.debug_abbrev) }
  .debug_line     0 : { *(.debug_line .debug_line.* .debug_line_end ) }
  .debug_frame    0 : { *(.debug_frame) }
  .debug_str      0 : { *(.debug_str) }
  .debug_loc      0 : { *(.debug_loc) }
  .debug_macinfo  0 : { *(.debug_macinfo) }
  /* SGI/MIPS DWARF 2 extensions */
  .debug_weaknames 0 : { *(.debug_weaknames) }
  .debug_funcnames 0 : { *(.debug_funcnames) }
  .debug_typenames 0 : { *(.debug_typenames) }
  .debug_varnames  0 : { *(.debug_varnames) }
  /* DWARF 3 */
  .debug_pubtypes 0 : { *(.debug_pubtypes) }
  .debug_ranges   0 : { *(.debug_ranges) }
  /* DWARF Extension.  */
  .debug_macro    0 : { *(.debug_macro) }
}
