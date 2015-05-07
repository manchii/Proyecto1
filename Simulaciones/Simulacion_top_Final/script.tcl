.main clear;

project compileall;

#vsim -L unisim -t ns -gui filtro_6_testbench glbl;

vsim -t ns -gui work.top_testbench;

add wave -position insertpoint \
sim:/top_testbench/uut/*;

add wave -position insertpoint \
sim:/top_testbench/*;

config wave -signalnamewidth 1;

run -all;

