all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_register16

run:
	ghdl -r tb_register16 --vcd=register16.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave register16.vcd
