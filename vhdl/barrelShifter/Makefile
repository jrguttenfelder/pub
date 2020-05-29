all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_barrelShifter

run:
	ghdl -r tb_barrelShifter --vcd=barrelShifter.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave barrelShifter.vcd
