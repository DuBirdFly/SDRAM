onerror {resume}
quietly virtual function -install /Top/sdr_wrapper/ifSdr -env /Top/sdr_wrapper/ifSdr { &{/Top/sdr_wrapper/ifSdr/cs_n, /Top/sdr_wrapper/ifSdr/ras_n, /Top/sdr_wrapper/ifSdr/cas_n, /Top/sdr_wrapper/ifSdr/we_n }} CMD
quietly virtual function -install /Top/sdr_wrapper/ifSdr -env /Top/sdr_wrapper/ifSdr { &{/Top/sdr_wrapper/ifSdr/cs_n, /Top/sdr_wrapper/ifSdr/ras_n, /Top/sdr_wrapper/ifSdr/cas_n, /Top/sdr_wrapper/ifSdr/we_n }} cmd
quietly WaveActivateNextPane {} 0
add wave -noupdate /Top/ifUser/SDR_STATE
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/cke
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/clk
add wave -noupdate -expand -group ifSdr -radix binary -childformat {{(3) -radix binary} {(2) -radix binary} {(1) -radix binary} {(0) -radix binary}} -subitemconfig {/Top/sdr_wrapper/ifSdr/cs_n {-radix binary} /Top/sdr_wrapper/ifSdr/ras_n {-radix binary} /Top/sdr_wrapper/ifSdr/cas_n {-radix binary} /Top/sdr_wrapper/ifSdr/we_n {-radix binary}} /Top/sdr_wrapper/ifSdr/cmd
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/ba
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/addr
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/dqm
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/dq
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {319750 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {196290 ps} {468099 ps}
