#========================================================================================================================
# Copyright (c) 2017 by Bitvis AS.  All rights reserved.
# You should have received a copy of the license file containing the MIT License (see LICENSE.TXT), if not, 
# contact Bitvis AS <support@bitvis.no>.
#
# UVVM AND ANY PART THEREOF ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH UVVM OR THE USE OR
# OTHER DEALINGS IN UVVM.
#========================================================================================================================

onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -expand -group {Global} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/clk_i

# AVALON_ST SOURCE
add wave -noupdate -expand -group {Avalon-ST Source} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/startofpacket_o
add wave -noupdate -expand -group {Avalon-ST Source} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/endofpacket_o
add wave -noupdate -expand -group {Avalon-ST Source} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/data_o
add wave -noupdate -expand -group {Avalon-ST Source} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/empty_o
add wave -noupdate -expand -group {Avalon-ST Source} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/valid_o
add wave -noupdate -expand -group {Avalon-ST Source} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/ready_i

# AVALON_ST SINK
add wave -noupdate -expand -group {Avalon-ST Sink} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/startofpacket_i
add wave -noupdate -expand -group {Avalon-ST Sink} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/endofpacket_i
add wave -noupdate -expand -group {Avalon-ST Sink} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/data_i
add wave -noupdate -expand -group {Avalon-ST Sink} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/empty_i
add wave -noupdate -expand -group {Avalon-ST Sink} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/valid_i
add wave -noupdate -expand -group {Avalon-ST Sink} -radix hexadecimal /tb_avalon_st_vvc/i_test_harness/ready_o

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1411622 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 221
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 2
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
WaveRestoreZoom {0 ps} {27512625 ps}
