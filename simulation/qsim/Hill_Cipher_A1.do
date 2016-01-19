onerror {exit -code 1}
vlib work
vlog -work work Hill_Cipher_A1.vo
vlog -work work Multiplexer.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.Multiplexer_vlg_vec_tst -voptargs="+acc"
vcd file -direction Hill_Cipher_A1.msim.vcd
vcd add -internal Multiplexer_vlg_vec_tst/*
vcd add -internal Multiplexer_vlg_vec_tst/i1/*
run -all
quit -f
