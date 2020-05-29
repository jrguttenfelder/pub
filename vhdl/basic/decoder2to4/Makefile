all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_decoder2to4

run:
	ghdl -r tb_decoder2to4 --vcd=decoder2to4.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave decoder2to4.vcd
