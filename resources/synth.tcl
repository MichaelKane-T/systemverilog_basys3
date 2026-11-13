set top $::env(MODULE_NAME)
set sources $::env(SV_FILES)
set xdc $::env(XDC_PATH)

read_verilog -sv $sources
read_xdc $xdc

set synth_params {}
if {[info exists ::env(SYNTH_PARAMS)]} {
    set synth_params $::env(SYNTH_PARAMS)
}

synth_design -top $top -part xc7a35tcpg236-1 {*}$synth_params
write_checkpoint -force synth.dcp
report_utilization -file synth_utilization.rpt
