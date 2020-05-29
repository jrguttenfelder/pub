all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_mux4to1

run:
	ghdl -r tb_mux4to1 --vcd=mux4to1.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave mux4to1.vcd
