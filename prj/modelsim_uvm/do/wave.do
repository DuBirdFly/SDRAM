onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group ifSdr /Top/ifSdr/clk
add wave -noupdate -expand -group ifSdr /Top/ifSdr/cke
add wave -noupdate -expand -group ifSdr /Top/ifSdr/cs_n
add wave -noupdate -expand -group ifSdr /Top/ifSdr/ras_n
add wave -noupdate -expand -group ifSdr /Top/ifSdr/cas_n
add wave -noupdate -expand -group ifSdr /Top/ifSdr/we_n
add wave -noupdate -expand -group ifSdr /Top/ifSdr/addr
add wave -noupdate -expand -group ifSdr /Top/ifSdr/ba
add wave -noupdate -expand -group ifSdr /Top/ifSdr/dq
add wave -noupdate -expand -group ifSdr /Top/ifSdr/dqm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {1050 ns}
