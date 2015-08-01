/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("elf32-d30v")
OUTPUT_ARCH(d30v)
MEMORY
{
  text  : ORIGIN = 0x00000000, LENGTH = 64K
  data  : ORIGIN = 0x20000000, LENGTH = 32K
  emem (rwx) : ORIGIN = 0x80000000, LENGTH = 8M
  eit			   : ORIGIN = 0xfffff020,  LENGTH = 320
}
SECTIONS
{
  /* Read-only sections, merged into text segment: */
  .hash			  : { *(.hash) }
  .dynsym		  : { *(.dynsym) }
  .dynstr		  : { *(.dynstr) }
  .gnu.version		  : { *(.gnu.version) }
  .gnu.version_d	  : { *(.gnu.version_d) }
  .gnu.version_r	  : { *(.gnu.version_r) }
  .rel.text		  : { *(.rel.text) *(.rel.gnu.linkonce.t*) }
  .rela.text		  : { *(.rela.text) *(.rela.gnu.linkonce.t*) }
  .rel.data		  : { *(.rel.data) *(.rel.gnu.linkonce.d*) }
  .rela.data		  : { *(.rela.data) *(.rela.gnu.linkonce.d*) }
  .rel.rodata		  : { *(.rel.rodata) *(.rel.gnu.linkonce.r*) }
  .rela.rodata		  : { *(.rela.rodata) *(.rela.gnu.linkonce.r*) }
  .rel.stext		  : { *(.rel.stest) }
  .rela.stext		  : { *(.rela.stest) }
  .rel.etext		  : { *(.rel.etest) }
  .rela.etext		  : { *(.rela.etest) }
  .rel.sdata		  : { *(.rel.sdata) }
  .rela.sdata		  : { *(.rela.sdata) }
  .rel.edata		  : { *(.rel.edata) }
  .rela.edata		  : { *(.rela.edata) }
  .rel.eit_v		  : { *(.rel.eit_v) }
  .rela.eit_v		  : { *(.rela.eit_v) }
  .rel.sbss		  : { *(.rel.sbss) }
  .rela.sbss		  : { *(.rela.sbss) }
  .rel.ebss		  : { *(.rel.ebss) }
  .rela.ebss		  : { *(.rela.ebss) }
  .rel.srodata		  : { *(.rel.srodata) }
  .rela.srodata		  : { *(.rela.srodata) }
  .rel.erodata		  : { *(.rel.erodata) }
  .rela.erodata		  : { *(.rela.erodata) }
  .rel.got		  : { *(.rel.got) }
  .rela.got		  : { *(.rela.got) }
  .rel.ctors		  : { *(.rel.ctors) }
  .rela.ctors		  : { *(.rela.ctors) }
  .rel.dtors		  : { *(.rel.dtors) }
  .rela.dtors		  : { *(.rela.dtors) }
  .rel.init		  : { *(.rel.init) }
  .rela.init		  : { *(.rela.init) }
  .rel.fini		  : { *(.rel.fini) }
  .rela.fini		  : { *(.rela.fini) }
  .rel.bss		  : { *(.rel.bss) }
  .rela.bss		  : { *(.rela.bss) }
  .rel.plt		  : { *(.rel.plt) }
  .rela.plt		  : { *(.rela.plt) }
  .init			  : { *(.init) } =0
  /* Internal text space */
  .stext	  : { *(.stext) }		 > text
  /* Internal text space or external memory */
  .text :
  {
    *(.text)
    *(.gnu.linkonce.t*)
    *(SORT_NONE(.init))
    *(SORT_NONE(.fini))
     _etext = . ;
  }  > emem
  /* Internal data space */
  .srodata	  : { *(.srodata) }	 > data
  .sdata	  : { *(.sdata) }		 > data
  /* Internal data space or external memory */
  .rodata	  : { *(.rodata) }	 > emem
  /* C++ exception support.  */
  .eh_frame	  : { KEEP (*(.eh_frame)) }	 > emem
  .gcc_except_table   : { *(.gcc_except_table) }	 > emem
  /* Java class registration support.  */
  .jcr		  : { KEEP (*(.jcr)) }	 >emem
  .ctors   :
  {
     __CTOR_LIST__ = .;
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
     __CTOR_END__ = .;
  }  > emem
    .dtors	  :
  {
     __DTOR_LIST__ = .;
    KEEP (*crtbegin.o(.dtors))
    KEEP (*crtbegin?.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
     __DTOR_END__ = .;
  }  > emem
  .data		  :
  {
    *(.data)
    *(.gnu.linkonce.d*)
    CONSTRUCTORS
     _edata = . ;
  }  > emem
  /* External memory */
  .etext	  :
  {
     PROVIDE (__etext_start = .) ;
    *(.etext)
     PROVIDE (__etext_end = .) ;
  }  > emem
  .erodata	  : { *(.erodata) }	 > emem
  .edata	  : { *(.edata) }		 > emem
  .sbss		  :
  {
     PROVIDE (__sbss_start = .) ;
    *(.sbss)
     PROVIDE (__sbss_end = .) ;
  }  > data
  .ebss		  :
  {
     PROVIDE (__ebss_start = .) ;
    *(.ebss)
     PROVIDE (__ebss_end = .) ;
  }  > data
  .bss		  :
  {
     PROVIDE (__bss_start = .) ;
    *(.bss)
    *(COMMON)
     PROVIDE (__bss_end = .) ;
     _end = . ;
  }  > emem
  .eit_v	  :
  {
     PROVIDE (__eit_start = .) ;
    *(.eit_v)
     PROVIDE (__eit_end = .) ;
  }  > eit
  /* Stabs debugging sections.  */
  .stab		 0 : { *(.stab) }
  .stabstr	 0 : { *(.stabstr) }
  .stab.excl	 0 : { *(.stab.excl) }
  .stab.exclstr	 0 : { *(.stab.exclstr) }
  .stab.index	 0 : { *(.stab.index) }
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment	 0 : { *(.comment) }
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
  PROVIDE (__stack = 0x20008000);
}
