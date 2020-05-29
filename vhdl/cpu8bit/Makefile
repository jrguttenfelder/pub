all: analyze elaborate run

analyze:
	ghdl -a alu/*.vhdl
	ghdl -a common/*.vhdl
	ghdl -a controller/*.vhdl
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_cpu

run:
	ghdl -r tb_cpu --vcd=cpu.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave cpu.vcd
