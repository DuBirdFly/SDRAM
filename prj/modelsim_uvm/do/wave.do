onerror {resume}
quietly virtual function -install /Top/ifSdr -env /Top/#INITIAL#28 { &{/Top/ifSdr/cs_n, /Top/ifSdr/ras_n, /Top/ifSdr/cas_n, /Top/ifSdr/we_n }} cmd
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group ifSdr /Top/ifSdr/clk
add wave -noupdate -expand -group ifSdr /Top/ifSdr/cke
add wave -noupdate -expand -group ifSdr -radix binary /Top/ifSdr/cmd
add wave -noupdate -expand -group ifSdr /Top/ifSdr/addr
add wave -noupdate -expand -group ifSdr /Top/ifSdr/ba
add wave -noupdate -expand -group ifSdr /Top/ifSdr/dq
add wave -noupdate -expand -group ifSdr /Top/ifSdr/dqm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {274710 ps} 0}
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
WaveRestoreZoom {258271 ps} {386984 ps}
