# Open the design saved by synthesis.
open_checkpoint synth.dcp

# Optimize, place, and connect the FPGA logic.
opt_design
place_design
route_design

# Save reports and generate the programming file.
report_timing_summary -file timing_summary.rpt
report_utilization -file implement_utilization.rpt
write_bitstream -force design.bit

# Save the completed implementation.
write_checkpoint -force implement.dcp
