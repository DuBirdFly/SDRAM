onerror {resume}
quietly virtual function -install /Top/sdr_wrapper/ifSdr -env /Top/sdr_wrapper/ifSdr { &{/Top/sdr_wrapper/ifSdr/cs_n, /Top/sdr_wrapper/ifSdr/ras_n, /Top/sdr_wrapper/ifSdr/cas_n, /Top/sdr_wrapper/ifSdr/we_n }} CMD
quietly virtual function -install /Top/sdr_wrapper/ifSdr -env /Top/sdr_wrapper/ifSdr { &{/Top/sdr_wrapper/ifSdr/cs_n, /Top/sdr_wrapper/ifSdr/ras_n, /Top/sdr_wrapper/ifSdr/cas_n, /Top/sdr_wrapper/ifSdr/we_n }} cmd
quietly virtual function -install /Top/sdr_wrapper/u_sdr -env /Top/#INITIAL#28 { &{/Top/sdr_wrapper/u_sdr/Act_b3, /Top/sdr_wrapper/u_sdr/Act_b2, /Top/sdr_wrapper/u_sdr/Act_b1, /Top/sdr_wrapper/u_sdr/Act_b0 }} ACT_BANK
quietly virtual function -install /Top/sdr_wrapper/u_sdr -env /Top/#INITIAL#28 { &{/Top/sdr_wrapper/u_sdr/Pc_b3, /Top/sdr_wrapper/u_sdr/Pc_b2, /Top/sdr_wrapper/u_sdr/Pc_b1, /Top/sdr_wrapper/u_sdr/Pc_b0 }} PRE_BANK
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/cke
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/clk
add wave -noupdate -expand -group ifSdr -radix binary -childformat {{(3) -radix binary} {(2) -radix binary} {(1) -radix binary} {(0) -radix binary}} -subitemconfig {/Top/sdr_wrapper/ifSdr/cs_n {-radix binary} /Top/sdr_wrapper/ifSdr/ras_n {-radix binary} /Top/sdr_wrapper/ifSdr/cas_n {-radix binary} /Top/sdr_wrapper/ifSdr/we_n {-radix binary}} /Top/sdr_wrapper/ifSdr/cmd
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/ba
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/addr
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/dqm
add wave -noupdate -expand -group ifSdr /Top/sdr_wrapper/ifSdr/dq
add wave -noupdate -expand -group sdr /Top/sdr_wrapper/u_sdr/B3_row_addr
add wave -noupdate -expand -group sdr /Top/sdr_wrapper/u_sdr/B2_row_addr
add wave -noupdate -expand -group sdr /Top/sdr_wrapper/u_sdr/B1_row_addr
add wave -noupdate -expand -group sdr /Top/sdr_wrapper/u_sdr/B0_row_addr
add wave -noupdate -expand -group sdr -radix binary /Top/sdr_wrapper/u_sdr/ACT_BANK
add wave -noupdate -expand -group sdr -radix binary /Top/sdr_wrapper/u_sdr/PRE_BANK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {281250 ps} 0}
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
WaveRestoreZoom {5671 ps} {1484394 ps}
