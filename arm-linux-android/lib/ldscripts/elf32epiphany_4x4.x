/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("elf32-epiphany", "elf32-epiphany",
	      "elf32-epiphany")
OUTPUT_ARCH(epiphany)
ENTRY(_start)
/* BSP specific*/
__PROG_SIZE_FOR_CORE__ = 1M;
__HEAP_SIZE_FOR_CORE__ = 1M;
__MAX_NUM_CORES_IN_ROWS__ = 4;
__MAX_NUM_CORES_IN_COLS__ = 4;
__FIRST_CORE_ROW_ = 0x20;
__FIRST_CORE_COL_ = 0x24;
PROVIDE (__CORE_ROW_ = __FIRST_CORE_ROW_);
PROVIDE (__CORE_COL_ = __FIRST_CORE_COL_);
/* generic don't touch */
/* used to calculated the slice address in the external memory*/
__CORE_NUM_ =  (__CORE_ROW_ -  __FIRST_CORE_ROW_ )* __MAX_NUM_CORES_IN_COLS__ + (__CORE_COL_ - __FIRST_CORE_COL_ ) ;
MEMORY
 {
 	EXTERNAL_DRAM_0 (WXAI) :     ORIGIN = 0x80000000,      LENGTH = 0x1000000  /*.text, data, rodata, bss and .stack*/
    EXTERNAL_DRAM_1 (WXAI) :        ORIGIN = 0x81000000,      LENGTH = 0x1000000 /*.heap */
    EXTERNAL_SRAM (WXAI) :       ORIGIN = 0x92000000,      LENGTH =   8K /* small external RAM, used for testing*/
    /* run time lib and crt0*/
    RESERVED_CRT0_RAM (WXAI) :    ORIGIN = 0,      LENGTH = 0x400
    /* user program, per bank usage */
    BANK0_SRAM (WXAI) : ORIGIN = LENGTH(RESERVED_CRT0_RAM),   LENGTH = 8K - LENGTH(RESERVED_CRT0_RAM)
    BANK1_SRAM (WXAI) : ORIGIN = 0x2000, LENGTH = 8K
    BANK2_SRAM (WXAI) : ORIGIN = 0x4000, LENGTH = 8K
    BANK3_SRAM (WXAI) : ORIGIN = 0x6000, LENGTH = 8K
    /* user program, continious placement */
    INTERNAL_RAM        (WXAI) :     ORIGIN = LENGTH(RESERVED_CRT0_RAM),  LENGTH = 32K - LENGTH(RESERVED_CRT0_RAM)
    MMR (WAI) 	      : ORIGIN = 0xF000, LENGTH = 32K
    /* multi cores space */
	CORE_0x20_0x24_INTERNAL_RAM :      ORIGIN = 0x82400000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x20_0x25_INTERNAL_RAM :      ORIGIN = 0x82500000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x20_0x26_INTERNAL_RAM :      ORIGIN = 0x82600000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x20_0x27_INTERNAL_RAM :      ORIGIN = 0x82700000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x21_0x24_INTERNAL_RAM :      ORIGIN = 0x86400000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x21_0x25_INTERNAL_RAM :      ORIGIN = 0x86500000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x21_0x26_INTERNAL_RAM :      ORIGIN = 0x86600000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x21_0x27_INTERNAL_RAM :      ORIGIN = 0x86700000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x22_0x24_INTERNAL_RAM :      ORIGIN = 0x8a400000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x22_0x25_INTERNAL_RAM :      ORIGIN = 0x8a500000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x22_0x26_INTERNAL_RAM :      ORIGIN = 0x8a600000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x22_0x27_INTERNAL_RAM :      ORIGIN = 0x8a700000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x23_0x24_INTERNAL_RAM :      ORIGIN = 0x8e400000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x23_0x25_INTERNAL_RAM :      ORIGIN = 0x8e500000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x23_0x26_INTERNAL_RAM :      ORIGIN = 0x8e600000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x23_0x27_INTERNAL_RAM :      ORIGIN = 0x8e700000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
	CORE_0x24_0x24_INTERNAL_RAM :      ORIGIN = 0x82000000+LENGTH(RESERVED_CRT0_RAM),      LENGTH = 32K- LENGTH(RESERVED_CRT0_RAM)
 }
SECTIONS
{
   IVT 0 : {*.o(IVT)  } > RESERVED_CRT0_RAM
   RESERVED_CRT0 : {*.o(RESERVED_CRT0)  } > RESERVED_CRT0_RAM
   RESERVED_CRT0 : {*.o(reserved_crt0)  } > RESERVED_CRT0_RAM
   CORE_RAM_0 :   {*.o(core_ram_0)  }  > BANK0_SRAM
   CORE_RAM_1 :   {*.o(core_ram_1)  }  > BANK1_SRAM
   CORE_RAM_2 :   {*.o(core_ram_2)  }  > BANK2_SRAM
   CORE_RAM_3 :   {*.o(core_ram_3)  }  > BANK3_SRAM
   SRAM_SOUTH :  {*.o(sram)  }  > EXTERNAL_SRAM
   DRAM_WEST :  {*.o(dram)  }  > EXTERNAL_DRAM_1
   CORE_INTERNAL :  {*.o(core_ram_internal)  }    /*> INTERNAL_RAM*/
   /* the newlib  (libc and libm)  library is maped to the dedicated section */
   __new_lib_start_external_ =  ( ORIGIN(EXTERNAL_DRAM_0) + __PROG_SIZE_FOR_CORE__ *__CORE_NUM_ );
   __new_lib_start_ = DEFINED(__USE_INTERNAL_MEM_FOR_NEW_LIB_) ? ORIGIN(BANK1_SRAM) :  __new_lib_start_external_ ;
   NEW_LIB_RO __new_lib_start_ : { lib_a-*.o(.text  .rodata )  *.o(libgloss_epiphany)  }  /*  > INTERNAL_RAM*/
   GNU_C_BUILTIN_LIB_RO     ADDR(NEW_LIB_RO) + SIZEOF(NEW_LIB_RO) : {
   								*mulsi3.o(.text  .rodata)  *modsi3.o(.text  .rodata)
   								*divsi3.o(.text  .rodata)  	*udivsi3.o(.text  .rodata)
   							    *umodsi3.o(.text  .rodata)   _*.o(.text  .rodata)
   }

   NEW_LIB_WR   ADDR(GNU_C_BUILTIN_LIB_RO) + SIZEOF(GNU_C_BUILTIN_LIB_RO)  : { lib_a-*.o(.data ) }    /* >  INTERNAL_RAM*/
   __init_start = DEFINED(__USE_INTERNAL_MEM_) ? ORIGIN(BANK1_SRAM) :  (ADDR(NEW_LIB_WR) + SIZEOF(NEW_LIB_WR) ) ;
   __init_start = DEFINED(__USE_INTERNAL_MEM_FOR_NEW_LIB_) ? ADDR(NEW_LIB_WR) + SIZEOF(NEW_LIB_WR)  : __init_start;
  /* Read-only sections, merged into text segment: */
  /*PROVIDE (__executable_start = 0x40); . = 0x40;*/
  .interp         : { *(.interp) }
  .note.gnu.build-id : { *(.note.gnu.build-id) }
  .hash           : { *(.hash) }
  .gnu.hash       : { *(.gnu.hash) }
  .dynsym         : { *(.dynsym) }
  .dynstr         : { *(.dynstr) }
  .gnu.version    : { *(.gnu.version) }
  .gnu.version_d  : { *(.gnu.version_d) }
  .gnu.version_r  : { *(.gnu.version_r) }
  .rela.init      : { *(.rela.init) }
  .rela.text      : { *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*) }
  .rela.fini      : { *(.rela.fini) }
  .rela.rodata    : { *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*) }
  .rela.data.rel.ro   : { *(.rela.data.rel.ro* .rela.gnu.linkonce.d.rel.ro.*) }
  .rela.data      : { *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*) }
  .rela.tdata	  : { *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*) }
  .rela.tbss	  : { *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*) }
  .rela.ctors     : { *(.rela.ctors) }
  .rela.dtors     : { *(.rela.dtors) }
  .rela.got       : { *(.rela.got) }
  .rela.bss       : { *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*) }
  .rela.plt       : { *(.rela.plt) }
  .init  __init_start  :
  {
    KEEP (*(.init))
  }     /*> INTERNAL_RAM*/ =0x01a2
  .plt            : { *(.plt) }
  .fini ADDR(.init)+SIZEOF(.init)   :
  {
    KEEP (*(.fini))
  }    /*> INTERNAL_RAM*/ =0x01a2
  .text ADDR(.fini)+SIZEOF(.fini)   :
  {
    *(.text .stub .text.* .gnu.linkonce.t.*)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
  }    /*> INTERNAL_RAM */ =0x01a2
  PROVIDE (__etext = .);
  PROVIDE (_etext = .);
  PROVIDE (etext = .);
  .rodata1        : { *(.rodata1) }
  .eh_frame_hdr : { *(.eh_frame_hdr) }
  .eh_frame       : ONLY_IF_RO { KEEP (*(.eh_frame)) }
  .gcc_except_table   : ONLY_IF_RO { *(.gcc_except_table .gcc_except_table.*) }
  /* Adjust the address for the data segment.  We want to adjust up to
     the same address within the page on the next page up.  */
  . = ALIGN(1) + (. & (1 - 1));
  /* Exception handling  */
  .eh_frame       : ONLY_IF_RW { KEEP (*(.eh_frame)) }
  .gcc_except_table   : ONLY_IF_RW { *(.gcc_except_table .gcc_except_table.*) }
  /* Thread Local Storage sections  */
  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
  .preinit_array     :
  {
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array))
    PROVIDE_HIDDEN (__preinit_array_end = .);
  }
  .init_array     :
  {
     PROVIDE_HIDDEN (__init_array_start = .);
     KEEP (*(SORT(.init_array.*)))
     KEEP (*(.init_array))
     PROVIDE_HIDDEN (__init_array_end = .);
  }
  .fini_array     :
  {
    PROVIDE_HIDDEN (__fini_array_start = .);
    KEEP (*(.fini_array))
    KEEP (*(SORT(.fini_array.*)))
    PROVIDE_HIDDEN (__fini_array_end = .);
  }
  .ctors    ADDR(.text) + SIZEOF(.text)        :
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
  }  /*> INTERNAL_RAM*/
  .dtors     ADDR(.ctors) + SIZEOF(.ctors)      :
  {
    KEEP (*crtbegin.o(.dtors))
    KEEP (*crtbegin?.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
  }   /*> INTERNAL_RAM*/
  .jcr            : { KEEP (*(.jcr)) }
  .data.rel.ro : { *(.data.rel.ro.local* .gnu.linkonce.d.rel.ro.local.*) *(.data.rel.ro* .gnu.linkonce.d.rel.ro.*) }
  .dynamic        : { *(.dynamic) }
  .got            : { *(.got.plt) *(.got) }
  .data ADDR(.dtors)+SIZEOF(.dtors)   :
  {
    *(.data .data.* .gnu.linkonce.d.*)
    SORT(CONSTRUCTORS)
  }  /*> INTERNAL_RAM*/
  .data1          : { *(.data1) }
  .rodata ADDR(.data)+SIZEOF(.data)   : { *(.rodata .rodata.* .gnu.linkonce.r.*) }  /*> INTERNAL_RAM*/
  _edata = .; PROVIDE (edata = .);
  /* Align ___bss_start and _end to a multiple of 8 so that we can use strd
     to clear bss.  N.B., without adding any extra alignment, we would have
     to clear the bss byte by byte.  */
  . = ALIGN(8);
  ___bss_start = .;
  .bss ADDR(.rodata)+SIZEOF(.rodata)   :
  {
   *(.dynbss)
   *(.bss .bss.* .gnu.linkonce.b.*)
   *(COMMON)
   /* Align here to ensure that the .bss section occupies space up to
      _end.  Align after .bss to ensure correct alignment even if the
      .bss section disappears because there are no input sections.
      FIXME: Why do we need it? When there is no .bss section, we don't
      pad the .data section.  */
   . = ALIGN(. != 0 ? 32 / 8 : 1);
  }  /*> INTERNAL_RAM*/
  . = ALIGN(32 / 8);
  . = ALIGN(32 / 8);
  . = ALIGN(8);
  _end = .; PROVIDE (end = .);
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
  /**/
  PROVIDE ( __stack_start_ = ORIGIN(EXTERNAL_DRAM_0) + __PROG_SIZE_FOR_CORE__ * __CORE_NUM_ + __PROG_SIZE_FOR_CORE__  - 0x10) ;
  .stack __stack_start_ :  {    ___stack = .;    *(.stack)  }
  PROVIDE (  ___heap_start = ORIGIN(EXTERNAL_DRAM_1)  + __HEAP_SIZE_FOR_CORE__ * __CORE_NUM_ );
  /*.heap_start      __heap_start_    :  {    _heap_start_ = .;    *(.heap_start)  }*/
  PROVIDE (  ___heap_end =   ORIGIN(EXTERNAL_DRAM_1)  + __HEAP_SIZE_FOR_CORE__ * __CORE_NUM_  + __HEAP_SIZE_FOR_CORE__ - 4 );
 /* .heap_end      __heap_end_    :  {    _heap_end_ = .;    *(.heap_end)  }*/
  .gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }
  /DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) }
}
