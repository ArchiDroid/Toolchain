/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT(pei-i386)
ENTRY (__start)
header = .;
__fltused = .; /* set up floating pt for MS .obj\'s */
__ldused = .;
SECTIONS
{
  .text  __image_base__ + __section_alignment__  :
  {
     __text_start__ = . ;
     *(.init)
    *(.text)
    *(.text$*)
    *(.glue_7t)
    *(.glue_7)
     ___CTOR_LIST__ = .; __CTOR_LIST__ = . ;
			LONG (-1); *(.ctors); *(.ctor); LONG (0);
     ___DTOR_LIST__ = .; __DTOR_LIST__ = . ;
			LONG (-1); *(.dtors); *(.dtor);  LONG (0);
     *(.fini)
    /* ??? Why is .gcc_exc here?  */
     *(.gcc_exc)
     etext = .;
     __text_end__ = .;
    *(.gcc_except_table)
  }
  /* The Cygwin32 library uses a section to avoid copying certain data
     on fork.  This used to be named ".data".  The linker used
     to include this between __data_start__ and __data_end__, but that
     breaks building the cygwin32 dll.  Instead, we name the section
     ".data_cygwin_nocopy" and explicitly include it after __data_end__. */
  .data BLOCK(__section_alignment__) :
  {
    __data_start__ = . ;
    *(.data)
    *(.data2)
    *(.data$*)
    __data_end__ = . ;
    *(.data_cygwin_nocopy)
  }
  .bss BLOCK(__section_alignment__) :
  {
    __bss_start__ = . ;
    *(.bss)
    *(COMMON)
    /* link.exe apparently pulls in .obj's because of UNDEF common
	symbols, which is not the coff way, but that's MS for you. */
    *(.CRT$XCA)
    *(.CRT$XCZ)
    *(.CRT$XIA)
    *(.CRT$XIZ)
    __bss_end__ = . ;
  }
  .rdata BLOCK(__section_alignment__) :
  {
    *(.rdata)
    *(.rdata$*)
    *(.eh_frame)
  }
  .edata BLOCK(__section_alignment__) :
  {
    *(.edata)
  }
  /DISCARD/ :
  {
    *(.debug$S)
    *(.debug$T)
    *(.debug$F)
    *(.drectve)
    *(.debug*)
  }
  .idata BLOCK(__section_alignment__) :
  {
    /* This cannot currently be handled with grouped sections.
	See pe.em:sort_sections.  */
    *(.idata$2)
    *(.idata$3)
    /* These zeroes mark the end of the import list.  */
    LONG (0); LONG (0); LONG (0); LONG (0); LONG (0);
    *(.idata$4)
    *(.idata$5)
    *(.idata$6)
    *(.idata$7)
  }
  .CRT BLOCK(__section_alignment__) :
  {
    *(.CRT$*)
  }
  .endjunk BLOCK(__section_alignment__) :
  {
    /* end is deprecated, don't use it */
     end = .;
     _end = .;
     __end__ = .;
  }
  .reloc BLOCK(__section_alignment__) :
  {
    *(.reloc)
  }
  .rsrc BLOCK(__section_alignment__) :
  {
    *(.rsrc)
    *(.rsrc$*)
  }
  .exc BLOCK(__section_alignment__) :
  {
    *(.exc)
    *(.exc$*)
  }
  .stab BLOCK(__section_alignment__) (NOLOAD) :
  {
    [ .stab ]
  }
  .stabstr BLOCK(__section_alignment__) (NOLOAD) :
  {
    [ .stabstr ]
  }
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
