.main clear;

project compileall;

vsim -gui work.Receive_testbench;

vsim -t ns Receive_testbench;

add wave -position insertpoint \
sim:/Receive_testbench/*;

config wave -signalnamewidth 1;

run -all;
