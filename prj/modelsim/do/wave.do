onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/sdram0/Clk
add wave -noupdate /test/sdram0/Cke
add wave -noupdate /test/sdram0/Cs_n
add wave -noupdate /test/sdram0/Ras_n
add wave -noupdate /test/sdram0/Cas_n
add wave -noupdate /test/sdram0/We_n
add wave -noupdate /test/sdram0/Addr
add wave -noupdate /test/sdram0/Ba
add wave -noupdate /test/sdram0/Dq
add wave -noupdate /test/sdram0/Dqm
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {653050 ps} {654050 ps}
