open_checkpoint synth.dcp
opt_design
place_design
route_design
report_timing_summary -file timing_summary.rpt
report_utilization -file implement_utilization.rpt
write_bitstream -force design.bit
write_checkpoint -force implement.dcp
