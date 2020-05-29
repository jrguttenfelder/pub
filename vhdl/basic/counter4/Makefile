all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_counter4

run:
	ghdl -r tb_counter4 --vcd=counter4.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave counter4.vcd
