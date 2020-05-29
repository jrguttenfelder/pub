all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_and8

run:
	ghdl -r tb_and8 --vcd=and8.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave and8.vcd
