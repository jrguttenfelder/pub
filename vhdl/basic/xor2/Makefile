all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_xor2

run:
	ghdl -r tb_xor2 --vcd=xor2.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave xor2.vcd
