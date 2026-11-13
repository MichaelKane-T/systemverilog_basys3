# SystemVerilog on the Basys 3

SystemVerilog learning projects by Michael Kane, with shared Make and Tcl scripts for building FPGA designs in Vivado.

The exercises develop combinational logic, clocked registers, counters, and timers through small hardware projects.

## Repository status

The shared build scripts are available in `resources/`. The `labs/lab1` and `labs/lab2` folders are awaiting upload from the local workspace. The lab descriptions below reflect the projects being prepared for this repository.

| Lab | Project | Practice |
| --- | --- | --- |
| Lab 1 | Seven-segment hexadecimal display | Combinational decoding, module connections, and board constraints |
| Lab 2 | Parameterized delay counter and LED blinker | Clocked logic, active-high reset, start control, and a completion pulse |

## Requirements

- AMD Vivado with support for the Artix-7 FPGA
- GNU Make
- Git
- Basys 3 board and a USB connection for hardware testing

Make sure `vivado` is available in your terminal before building.

```bash
vivado -version
make --version
```

## Get the project

```bash
git clone git@github.com:MichaelKane-T/systemverilog_basys3.git
cd systemverilog_basys3
```

## Shared resources

| File | Purpose |
| --- | --- |
| `resources/basys3.mk` | Shared synthesis and implementation targets |
| `resources/synth.tcl` | Reads SystemVerilog and constraints, then creates a synthesized checkpoint |
| `resources/implement.tcl` | Places and routes the design, writes reports, and generates a bitstream |

The scripts target FPGA part `xc7a35tcpg236-1`.

Each lab should contain its SystemVerilog sources, a `basys3.xdc` constraints file, and a small `Makefile`. Shared resources live two levels above each lab folder.

## Configure a lab

For Lab 2, a Makefile can use the following settings. Adjust the source filenames to match the files in the folder.

```makefile
MODULE_NAME := counter_top
REPO_PATH := ../..
SV_FILES := counter.sv counter_top.sv

include $(REPO_PATH)/resources/basys3.mk
```

- `MODULE_NAME` selects the top-level module.
- `REPO_PATH` points from the lab folder to the repository root.
- `SV_FILES` lists the source files needed to build the design.
- `XDC_FILE` optionally selects another constraints file. Its default is `basys3.xdc`.

The XDC port names must match the top-level SystemVerilog port names exactly.

## Build a lab

After the lab sources have been uploaded, run these commands from its folder.

```bash
cd labs/lab2
make synth
make implement
```

To run synthesis and implementation together, use

```bash
make build
```

The build creates a `work/` directory inside the lab folder.

| Output | Purpose |
| --- | --- |
| `work/synth.dcp` | Synthesized design checkpoint |
| `work/implement.dcp` | Placed and routed design checkpoint |
| `work/design.bit` | Programming file |
| `work/synth_utilization.rpt` | Synthesis resource usage |
| `work/implement_utilization.rpt` | Implementation resource usage |
| `work/timing_summary.rpt` | Timing analysis |
| `work/synth.log` | Synthesis messages |
| `work/implement.log` | Implementation messages |

Open a saved checkpoint in Vivado with

```bash
make open_synth_checkpoint
make open_implement_checkpoint
```

## Program the board

After a successful build, open Vivado Hardware Manager, connect to the Basys 3, and program the device with the lab's `work/design.bit` file.

## Lab 2 timing

Set `CLK_FREQ_HZ` to the frequency of the clock supplied to the timer. For a direct 100 MHz board-clock connection, use `100_000_000`.

The beginner timer calculates the delay using

```systemverilog
localparam int DELAY_CYCLES =
    (CLK_FREQ_HZ * DELAY_MS) / 1000;
```

This expression uses integer arithmetic. Choose positive parameters that produce a whole number of cycles, and keep their product within the signed 32-bit integer range. For example, 100 MHz multiplied by 10 ms fits, while 100 MHz multiplied by 500 ms exceeds that range. Longer delays require a wider intermediate calculation before building the design.

A full 1 Hz LED blink needs a toggle approximately every 500 ms. Verify the timer in simulation with a short delay first.

## Troubleshooting

| Message | What to check |
| --- | --- |
| No rule to make target | Run Make in the lab folder and check the Makefile include path |
| Cannot read an environment variable | Run the Tcl scripts through the supplied Makefile |
| Unspecified I/O standard or unconstrained port | Assign a package pin and I/O standard to every external port in the XDC file |
| Source file missing | Check the filenames in `SV_FILES` |
| Bitstream generation failed | Find the first error in the Vivado log |

The scripts have been added to the repository but have not yet been validated in a complete Vivado run.

## License

See [LICENSE](LICENSE).
