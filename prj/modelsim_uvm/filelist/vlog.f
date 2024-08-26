//* Base command ****************************************
-incr -mfcu -sv

-work work

//* UVM 1.1d ********************************************
-L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF
+acc

+incdir+D:/Codes/Modelsim/Modelsim_10_7/verilog_src/uvm-1.1d/src
D:/Codes/Modelsim/Modelsim_10_7/verilog_src/uvm-1.1d/src/uvm_pkg.sv

//* define *********************************************
+define+Micron_SG75_256Mb_x16
+define+x16

+incdir+../../memory/MicronSDRAM
../../memory/MicronSDRAM/sdr.v

//* Dut Files *******************************************

//* Testbench Files *************************************
+incdir+../../sim/env
+incdir+../../sim/sdr
+incdir+../../sim/top
+incdir+../../sim/wrapper

../../sim/top/Top.sv

