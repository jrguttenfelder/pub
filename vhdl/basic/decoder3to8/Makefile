all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_decoder3to8

run:
	ghdl -r tb_decoder3to8 --vcd=decoder3to8.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave decoder3to8.vcd
