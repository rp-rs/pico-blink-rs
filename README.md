# pico-blink-rs

Running Rust code on the Raspberry Pi Pico

## Booting

The RP2040 has external QSPI flash. There is an internal mask-ROM bootloader which can read the first 256 bytes of external flash and copy it to the top of SRAM (`0x2004_1f00`). This 256 byte block is the 'second stage bootloader'. Its job is to reconfigure the XIP_SSI interface to the right values for the attached QSPI flash chip (the mask ROM has some very conservative defaults which should work with all chips), and configure the XIP so that the QSPI flash appears at address `0x1000_0000` upwards.

The second stage bootloader then loads the user application once the XIP_SSI configuration is complete. It does this by jumping to `0x1000_0100`, which is 256 bytes into the QSPI flash contents (or immediately after the 256 byte second stage bootloader).

## Licence

This work is licenced under CC0.