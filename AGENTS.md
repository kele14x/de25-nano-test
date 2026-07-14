# DE25-Nano project guidance

## Project identity

- Board: Terasic DE25-Nano.
- Device: `A5EB013BB23BE4SR1` (Agilex 5).
- Quartus project: `quartus/de25-nano-test.qpf`.
- Active revision/top-level entity: `de25_nano_test_top`.
- Quartus Prime Pro: 26.1; default local install path:
  `C:/altera_pro/26.1/quartus`.

## Build and programming

Run these commands from the repository root:

```text
make compile  # Generate quartus/output_files/de25_nano_test_top.sof
make jtag     # List detected JTAG cables/devices
make program  # Compile and configure the FPGA through JTAG
```

Override `QUARTUS_ROOT` if Quartus is installed elsewhere. The default JTAG
cable is `DE25-Nano [USB-1]`, and the FPGA is device index `1`.

`make program` changes the connected hardware. Run it only when the user has
explicitly requested FPGA programming. JTAG configuration is volatile.

## Hardware details

- `CLOCK0_50`: `PIN_DJ35`, 50 MHz, 1.1 V I/O.
- `LEDR[0]`: `PIN_DF35`, 1.1 V I/O, active low. It blinks once per second.
- `LEDR[1:7]` are assigned in the QSF and intentionally held off.
- The design includes `rtl/altera_s10_user_rst_clkgate.sv`, the Agilex 5
  Reset Release wrapper. Its endpoint primitive is supplied by Quartus; there
  is no project-owned `.ip` file for it.

## Version-control policy

- Keep HDL (`rtl/`), Quartus `.qpf`/`.qsf`/`.sdc`, `Makefile`, `README.md`,
  `.gitignore`, and this file under version control.
- Do not add Quartus-generated files. `.gitignore` covers `output_files/`,
  `qdb/`, `db/`, `incremental_db/`, `dni/`, and local `.qws` files.
- Use `de25-nano-test.qpf` with revision `de25_nano_test_top`; do not create a
  duplicate QPF named after the revision.
