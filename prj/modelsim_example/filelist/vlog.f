//* Base command ****************************************
-incr -mfcu -sv

-work work

//* UVM 1.1d ********************************************
-L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF
+acc

+incdir+D:/Codes/Modelsim/Modelsim_10_7/verilog_src/uvm-1.1d/src
D:/Codes/Modelsim/Modelsim_10_7/verilog_src/uvm-1.1d/src/uvm_pkg.sv

//* define *********************************************
// +define+W9825G6DH_6
+define+Micron_SG75_256Mb_x16

+define+x16

//* Include directories *********************************
+incdir+../../memory/MicronSDRAM

//* Dut Files *******************************************

//* Memory Model ****************************************
../../memory/MicronSDRAM/sdr.v

//* Testbench Files *************************************
../../memory/MicronSDRAM/test.v
