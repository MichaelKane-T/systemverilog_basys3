if {$argc < 3} {
    error "Usage: -tclargs TOP XDC SOURCE.sv ?MORE_SOURCES.sv?"
}

set top [lindex $argv 0]
set xdc [lindex $argv 1]
set sources [lrange $argv 2 end]

read_verilog -sv $sources
read_xdc $xdc

synth_design -top $top -part xc7a35tcpg236-1
opt_design
place_design
route_design
write_bitstream -force "${top}.bit"
