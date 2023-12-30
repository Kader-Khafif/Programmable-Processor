onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /regfile16x16a_tb/clk
add wave -noupdate /regfile16x16a_tb/WriteEnable
add wave -noupdate /regfile16x16a_tb/WAddr
add wave -noupdate /regfile16x16a_tb/WData
add wave -noupdate /regfile16x16a_tb/RAddrA
add wave -noupdate /regfile16x16a_tb/RAddrB
add wave -noupdate /regfile16x16a_tb/RDataA
add wave -noupdate /regfile16x16a_tb/RDataB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
