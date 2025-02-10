xsim:
	xvlog -f ./include.rtl.list.xsim ./testbench.v 
	xelab -top testbench -debug all -snapshot testbench_elab
	xsim testbench_elab -R
clean:
	rm -rf xsim.dir/ *.log *.pb *.jou *.wdb
	rm testbench.vcd