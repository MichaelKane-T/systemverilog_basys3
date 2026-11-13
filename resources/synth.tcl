# Read settings supplied by basys3.mk.
set top $::env(MODULE_NAME)
set sources $::env(SV_FILES)
set xdc $::env(XDC_PATH)

# Load the design and board pin assignments.
read_verilog -sv $sources
read_xdc $xdc

# Optional parameter overrides.
set synth_params {}
if {[info exists ::env(SYNTH_PARAMS)]} {
    set synth_params $::env(SYNTH_PARAMS)
}

# Synthesize for the Basys 3 FPGA.
synth_design -top $top -part xc7a35tcpg236-1 {*}$synth_params

# Save the synthesized design for implementation.
write_checkpoint -force synth.dcp
report_utilization -file synth_utilization.rpt
