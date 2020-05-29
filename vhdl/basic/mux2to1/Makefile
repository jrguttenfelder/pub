all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_mux2to1

run:
	ghdl -r tb_mux2to1 --vcd=mux2to1.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave mux2to1.vcd
