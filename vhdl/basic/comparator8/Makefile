all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_comparator8

run:
	ghdl -r tb_comparator8 --vcd=comparator8.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave comparator8.vcd
