MEMORY
{
  VECTORS (rx) : ORIGIN = 0x00000000, LENGTH = 0x00000400
  FLASH_PROTECTION      (rx) : ORIGIN = 0x00000400, LENGTH = 0x00000010
  FLASH (rx) : ORIGIN = 0x00000410, LENGTH = 32K - 0x00000410
  RAM (rwx) : ORIGIN = 0x1FFFFC00, LENGTH = 4K - 0xC0
}

ENTRY (Reset_Handler)

SECTIONS
{
  .isr_vector :
  {
    __vector_table = .;
    KEEP(*(.vector_table))
    *(.text.Reset_Handler)	
    . = ALIGN(4);
  } > VECTORS = 0

  .flash_protect :
  {
    KEEP(*(.kinetis_flash_config_field))
    . = ALIGN(4);
  } > FLASH_PROTECTION

  .text : { _btext = .; *(.text) _etext = . ; } > FLASH 
  /* .text : { _btext = .; *(.text) _etext = . ; } > RAM */
  .data : { _bdata = . ; *(.data); _edata = . ;  } > RAM
  .bss  : { _bstart = . ; *(.bss) *(COMMON)  ; _bend = . ;} > RAM

  .heap :
  {
    __end__ = .;
    end = __end__;
    *(.heap*)
    __HeapLimit = .;
  } > RAM

  .stack_dummy :
  {
    *(.stack)
  } > RAM

  __StackTop = ORIGIN(RAM) + LENGTH(RAM);
  __StackLimit = __StackTop - SIZEOF(.stack_dummy);
  PROVIDE(__stack = __StackTop);
  /* Check if data + heap + stack exceeds RAM limit */
  ASSERT(__StackLimit >= __HeapLimit, "region RAM overflowed with stack")
}

