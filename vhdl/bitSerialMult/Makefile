all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_bitSerialMult

run:
	ghdl -r tb_bitSerialMult --vcd=bitSerialMult.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave bitSerialMult.vcd
