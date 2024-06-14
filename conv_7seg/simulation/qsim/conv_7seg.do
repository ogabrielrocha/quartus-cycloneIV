onerror {quit -f}
vlib work
vlog -work work conv_7seg.vo
vlog -work work conv_7seg.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.conv_7seg_vlg_vec_tst
vcd file -direction conv_7seg.msim.vcd
vcd add -internal conv_7seg_vlg_vec_tst/*
vcd add -internal conv_7seg_vlg_vec_tst/i1/*
add wave /*
run -all
