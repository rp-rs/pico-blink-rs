MEMORY
{
  /* NOTE 1 K = 1 KiBi = 1024 bytes */
  /* To suit Raspberry Pi RP2040 SoC */
  BOOT_LOADER : ORIGIN = 0x10000000, LENGTH = 512
  FLASH : ORIGIN = 0x10000200, LENGTH = 2048K - 512
  RAM : ORIGIN = 0x20000000, LENGTH = 256K
}

SECTIONS {

  /* ### Boot loader */
  .boot_loader ORIGIN(BOOT_LOADER) :
  {
    KEEP(*(.boot_loader*));
  } > BOOT_LOADER

} INSERT BEFORE .text;