all: analyze elaborate run

analyze:
	ghdl -a --ieee=synopsys *.vhdl

elaborate:
	ghdl -e tb_fullAdder16

run:
	ghdl -r tb_fullAdder16 --vcd=fullAdder16.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave fullAdder16.vcd
