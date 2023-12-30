onerror {resume}
virtual type { S_A S_B S_C} myStateType
quietly WaveActivateNextPane {} 0
add wave -noupdate /ButtonSync_testbench/Clock
add wave -noupdate /ButtonSync_testbench/Bi
add wave -noupdate /ButtonSync_testbench/Bo
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 228
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {908 ps}
