# DE25-Nano minimal blinky

This Quartus Pro project targets the Terasic DE25-Nano (Agilex 5
`A5EB013BB23BE4SR1`). It blinks `LEDR[0]` once per second using the board's
50 MHz `CLOCK0_50` input. The remaining seven user LEDs stay off.

The design includes the required Agilex 5 Reset Release IP. It holds the
blinker registers in reset until the whole FPGA fabric has entered user mode.

## Build

With GNU Make installed, run this from the repository root:

```text
make compile
```

The Makefile uses Quartus from `C:/altera_pro/26.1/quartus` by default. To use
another installation, pass `QUARTUS_ROOT`, for example:

```text
make QUARTUS_ROOT=C:/intelFPGA_pro/26.1/quartus compile
```

To list the connected JTAG devices, run `make jtag`. To compile and configure
the FPGA in one command, run `make program`. JTAG configuration is volatile.

Alternatively, use the Quartus GUI:

1. Open `quartus/de25-nano-test.qpf` in Quartus Prime Pro.
2. Select **Processing → Start Compilation**.
3. Connect the DE25-Nano's USB-Blaster III Type-C port and power the board.
4. Open **Tools → Programmer**, select the detected hardware, add the generated
   `.sof` from `quartus/output_files/`, then program the Agilex 5 device.

The configuration is volatile when programmed through JTAG. Generate and use
an appropriate flash programming image if the design must start after power-up.

## Pin assignments

`CLOCK0_50` is assigned to `PIN_DJ35`. `LEDR[0]` through `LEDR[7]` are assigned
to `PIN_DF35`, `PIN_DJ32`, `PIN_DN22`, `PIN_DP23`, `PIN_DN25`, `PIN_DP25`,
`PIN_DJ27`, and `PIN_DP30`, respectively. All use the board's 1.1 V I/O bank.
