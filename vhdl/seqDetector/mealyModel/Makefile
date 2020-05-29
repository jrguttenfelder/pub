all: analyze elaborate run

analyze:
	ghdl -a *.vhdl

elaborate:
	ghdl -e tb_mealyModel

run:
	ghdl -r tb_mealyModel --vcd=mealyModel.vcd --stop-time=2ms

clean:
	rm -f *.vcd *.cf

view:
	gtkwave mealyModel.vcd
