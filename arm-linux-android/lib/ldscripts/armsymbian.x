/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("elf32-littlearm-symbian", "elf32-bigarm-symbian",
	      "elf32-littlearm-symbian")
OUTPUT_ARCH(arm)
ENTRY(_start)
/* Do we need any of these for elf?
   __DYNAMIC = 0;    */
/* ARM's proprietary toolchain generate these symbols to match the start
   and end of particular sections of the image.  SymbianOS uses these
   symbols.  We provide them for compatibility with ARM's toolchains.
   These symbols should be bound locally; each shared object may define
   its own version of these symbols.  */

VERSION
{
  /* Give these a dummy version to work around linker lameness.
     The name used shouldn't matter as these are all local symbols.  */
  __GNU {
    local:
      Image$$ER_RO$$Base;
      Image$$ER_RO$$Limit;
      SHT$$INIT_ARRAY$$Base;
      SHT$$INIT_ARRAY$$Limit;
      .ARM.exidx$$Base;
      .ARM.exidx$$Limit;
  };
}
SECTIONS
{
  /* Read-only sections, merged into text segment: */
  PROVIDE (__executable_start = SEGMENT_START("text", 0x8000));
   . = SEGMENT_START("text", 0x8000);
  /* Define Image$$ER_RO$$Base.  */
  PROVIDE (Image$$ER_RO$$Base = .);
  .init           :
  {
    KEEP (*(.init))
  } =0
  .text           :
  {
    *(.text .stub .text.* .gnu.linkonce.t.*)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
    *(.glue_7t) *(.glue_7) *(.vfp11_veneer) *(.v4_bx)
  } =0
  .fini           :
  {
    KEEP (*(.fini))
  } =0
  /* The SymbianOS kernel requires that the PLT go at the end of the
     text section.  */
  .plt            : { *(.plt) }
  PROVIDE (__etext = .);
  PROVIDE (_etext = .);
  PROVIDE (etext = .);
  /* Define Image$$ER_RO$$Limit.  */
  PROVIDE (Image$$ER_RO$$Limit = .);
  .rodata         : { *(.rodata .rodata.* .gnu.linkonce.r.*) }
  .rodata1        : { *(.rodata1) }
  /* On SymbianOS, put  .init_array and friends in the read-only
     segment; there is no runtime relocation applied to these
     arrays.  */
  .preinit_array     :
  {
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array))
    PROVIDE_HIDDEN (__preinit_array_end = .);
  }
  .init_array     :
  {
    /* SymbianOS uses this symbol.  */
    PROVIDE (SHT$$INIT_ARRAY$$Base = .);
    PROVIDE_HIDDEN (__init_array_start = .);
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array))
    PROVIDE_HIDDEN (__init_array_end = .);
    /* SymbianOS uses this symbol.  */
    PROVIDE (SHT$$INIT_ARRAY$$Limit = .);
  }
  .fini_array     :
  {
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array))
    PROVIDE_HIDDEN (__fini_array_end = .);
  }
  .ARM.extab   : { *(.ARM.extab* .gnu.linkonce.armextab.*) }
   PROVIDE_HIDDEN (.ARM.exidx$$Base = .);
   PROVIDE_HIDDEN (__exidx_start = .);
  .ARM.exidx   : { *(.ARM.exidx* .gnu.linkonce.armexidx.*) }
   PROVIDE_HIDDEN (__exidx_end = .);
   PROVIDE_HIDDEN (.ARM.exidx$$Limit = .);
  .eh_frame_hdr : { *(.eh_frame_hdr) }
  .eh_frame       : ONLY_IF_RO { KEEP (*(.eh_frame)) }
  .gcc_except_table   : ONLY_IF_RO { KEEP (*(.gcc_except_table)) *(.gcc_except_table.*) }
  /* Adjust the address for the data segment.  We want to adjust up to
     the same address within the page on the next page up.  */
  . = SEGMENT_START("data", ALIGN(CONSTANT (MAXPAGESIZE)) + (. & (CONSTANT (MAXPAGESIZE) - 1)));
  /* Exception handling  */
  .eh_frame       : ONLY_IF_RW { KEEP (*(.eh_frame)) }
  .gcc_except_table   : ONLY_IF_RW { KEEP (*(.gcc_except_table)) *(.gcc_except_table.*) }
  /* Thread Local Storage sections  */
  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
  .ctors          :
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
    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .ctors))
    KEEP (*(SORT(.ctors.*)))
    KEEP (*(.ctors))
  }
  .dtors          :
  {
    KEEP (*crtbegin.o(.dtors))
    KEEP (*crtbegin?.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
  }
  .jcr            : { KEEP (*(.jcr)) }
  .data.rel.ro : { *(.data.rel.ro.local) *(.data.rel.ro .data.rel.ro.*) }
  .data           :
  {
    __data_start = . ;
    *(.data .data.* .gnu.linkonce.d.*)
    SORT(CONSTRUCTORS)
  }
  .data1          : { *(.data1) }
  _edata = .;
  PROVIDE (edata = .);
  . = DEFINED(__bss_segment_start) ? __bss_segment_start : .;
  __bss_start = .;
  __bss_start__ = .;
  .bss            :
  {
   *(.dynbss)
   *(.bss .bss.* .gnu.linkonce.b.*)
   *(COMMON)
   /* Align here to ensure that the .bss section occupies space up to
      _end.  Align after .bss to ensure correct alignment even if the
      .bss section disappears because there are no input sections.  */
   . = ALIGN(32 / 8);
  }
  _bss_end__ = . ; __bss_end__ = . ;
  . = ALIGN(32 / 8);
  __end__ = . ;
  _end = .;
  PROVIDE (end = .);
  /* These sections are not mapped under the BPABI.  */
  .dynamic      0 : { *(.dynamic) }
  .hash         0 : { *(.hash) }
  .dynsym       0 : { *(.dynsym) }
  .dynstr       0 : { *(.dynstr) }
  .gnu.version  0 : { *(.gnu.version) }
  .gnu.version_d 0: { *(.gnu.version_d) }
  .gnu.version_r 0: { *(.gnu.version_r) }
  .interp       0 : { *(.interp) }
  /* Stabs debugging sections.  */
  .stab          0 : { *(.stab) }
  .stabstr       0 : { *(.stabstr) }
  .stab.excl     0 : { *(.stab.excl) }
  .stab.exclstr  0 : { *(.stab.exclstr) }
  .stab.index    0 : { *(.stab.index) }
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment       0 : { *(.comment) }
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
    .stack         0x80000 :
  {
    _stack = .;
    *(.stack)
  }
  .note.gnu.arm.ident 0 : { KEEP (*(.note.gnu.arm.ident)) }
  /DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink)  *(.gnu.lto_*) }
  .rel.init     0 : { *(.rel.init) }
  .rela.init    0 : { *(.rela.init) }
  .rel.text     0 : { *(.rel.text .rel.text.* .rel.gnu.linkonce.t.*) }
  .rela.text    0 : { *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*) }
  .rel.fini     0 : { *(.rel.fini) }
  .rela.fini    0 : { *(.rela.fini) }
  .rel.rodata   0 : { *(.rel.rodata .rel.rodata.* .rel.gnu.linkonce.r.*) }
  .rela.rodata  0 : { *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*) }
  .rel.data.rel.ro 0 : { *(.rel.data.rel.ro .rel.data.rel.ro.*) }
  .rela.data.rel.ro 0 : { *(.rela.data.rel.ro .rela.data.rel.ro.*) }
  .rel.data     0 : { *(.rel.data .rel.data.* .rel.gnu.linkonce.d.*) }
  .rela.data    0 : { *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*) }
  .rel.tdata	0 : { *(.rel.tdata .rel.tdata.* .rel.gnu.linkonce.td.*) }
  .rela.tdata	0 : { *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*) }
  .rel.tbss	0 : { *(.rel.tbss .rel.tbss.* .rel.gnu.linkonce.tb.*) }
  .rela.tbss	0 : { *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*) }
  .rel.ctors    0 : { *(.rel.ctors) }
  .rela.ctors   0 : { *(.rela.ctors) }
  .rel.dtors    0 : { *(.rel.dtors) }
  .rela.dtors   0 : { *(.rela.dtors) }
  .rel.bss      0 : { *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*) }
  .rela.bss     0 : { *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*) }
  .rel.init_array  0 : { *(.rel.init_array) }
  .rela.init_array 0 : { *(.rela.init_array) }
  .rel.fini_array  0 : { *(.rel.fini_array) }
  .rela.fini_array 0 : { *(.rela.fini_array) }
  .rel.plt      0 : { *(.rel.plt) }
  .rela.plt     0 : { *(.rela.plt) }
  .rel.other    0 : { *(.rel.*) }
  .rela.other   0 : { *(.rela.*) }
  .reli.other   0 : { *(.reli.*) }
}
