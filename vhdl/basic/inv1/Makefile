all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_inv1

run:
	ghdl -r tb_inv1 --vcd=inv1.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave inv1.vcd
