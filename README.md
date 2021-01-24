# pico-blink-rs

Running Rust code on the Raspberry Pi Pico

## Booting

The RP2040 has external QSPI flash. There is an internal mask-ROM bootloader which can read the first 256 bytes of external flash and copy it to the top of SRAM (`0x2004_1f00`). This 256 byte block is the 'second stage bootloader'. Its job is to reconfigure the XIP_SSI interface to the right values for the attached QSPI flash chip (the mask ROM has some very conservative defaults which should work with all chips), and configure the XIP so that the QSPI flash appears at address `0x1000_0000` upwards.

The second stage bootloader then loads the user application once the XIP_SSI configuration is complete. It does this by jumping to `0x1000_0100`, which is 256 bytes into the QSPI flash contents (or immediately after the 256 byte second stage bootloader). We emulate this by storing the second stage bootloader in a static array at the start of our application.

The application needs to relocate the vector table using VTOR, then set the stack pointer
and call the reset function manually. Rather than do that in Rust, currently we copy the first 256 bytes of the "blink" pico-sdk example, which does this for us. Yes, this is ugly. The bootloader should be trimmed back to 256 bytes and some Rust code written which sets up VTOR correctly. Or, we can ask Raspberry Pi Trading to change boot2 to expect a Vector Table at 0x100 instead of a function: see https://github.com/raspberrypi/pico-sdk/pull/10.

We should also write a BSP for the pico, and a HAL for the RP2040. Basically, don't do any of what I did here. But hey, it blinks!

## Licence

This work is licenced under CC0. The bootrom binaries are Copyright Raspberry Pi Trading and build from pico-sdk v1.0.0.
