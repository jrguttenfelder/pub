all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_and2

run:
	ghdl -r tb_and2 --vcd=and2.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave and2.vcd
