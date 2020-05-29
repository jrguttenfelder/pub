all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_mooreModel

run:
	ghdl -r tb_mooreModel --vcd=mooreModel.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave mooreModel.vcd
