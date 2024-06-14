# Legal Notice: (C)2023 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_internal_jtag|tckutap}
#set_clock_groups -asynchronous -group {altera_internal_jtag|tckutap}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	p2_grms_qsys_nios2_qsys_grms 	p2_grms_qsys_nios2_qsys_grms:*
set 	p2_grms_qsys_nios2_qsys_grms_oci 	p2_grms_qsys_nios2_qsys_grms_nios2_oci:the_p2_grms_qsys_nios2_qsys_grms_nios2_oci
set 	p2_grms_qsys_nios2_qsys_grms_oci_break 	p2_grms_qsys_nios2_qsys_grms_nios2_oci_break:the_p2_grms_qsys_nios2_qsys_grms_nios2_oci_break
set 	p2_grms_qsys_nios2_qsys_grms_ocimem 	p2_grms_qsys_nios2_qsys_grms_nios2_ocimem:the_p2_grms_qsys_nios2_qsys_grms_nios2_ocimem
set 	p2_grms_qsys_nios2_qsys_grms_oci_debug 	p2_grms_qsys_nios2_qsys_grms_nios2_oci_debug:the_p2_grms_qsys_nios2_qsys_grms_nios2_oci_debug
set 	p2_grms_qsys_nios2_qsys_grms_wrapper 	p2_grms_qsys_nios2_qsys_grms_jtag_debug_module_wrapper:the_p2_grms_qsys_nios2_qsys_grms_jtag_debug_module_wrapper
set 	p2_grms_qsys_nios2_qsys_grms_jtag_tck 	p2_grms_qsys_nios2_qsys_grms_jtag_debug_module_tck:the_p2_grms_qsys_nios2_qsys_grms_jtag_debug_module_tck
set 	p2_grms_qsys_nios2_qsys_grms_jtag_sysclk 	p2_grms_qsys_nios2_qsys_grms_jtag_debug_module_sysclk:the_p2_grms_qsys_nios2_qsys_grms_jtag_debug_module_sysclk
set 	p2_grms_qsys_nios2_qsys_grms_oci_path 	 [format "%s|%s" $p2_grms_qsys_nios2_qsys_grms $p2_grms_qsys_nios2_qsys_grms_oci]
set 	p2_grms_qsys_nios2_qsys_grms_oci_break_path 	 [format "%s|%s" $p2_grms_qsys_nios2_qsys_grms_oci_path $p2_grms_qsys_nios2_qsys_grms_oci_break]
set 	p2_grms_qsys_nios2_qsys_grms_ocimem_path 	 [format "%s|%s" $p2_grms_qsys_nios2_qsys_grms_oci_path $p2_grms_qsys_nios2_qsys_grms_ocimem]
set 	p2_grms_qsys_nios2_qsys_grms_oci_debug_path 	 [format "%s|%s" $p2_grms_qsys_nios2_qsys_grms_oci_path $p2_grms_qsys_nios2_qsys_grms_oci_debug]
set 	p2_grms_qsys_nios2_qsys_grms_jtag_tck_path 	 [format "%s|%s|%s" $p2_grms_qsys_nios2_qsys_grms_oci_path $p2_grms_qsys_nios2_qsys_grms_wrapper $p2_grms_qsys_nios2_qsys_grms_jtag_tck]
set 	p2_grms_qsys_nios2_qsys_grms_jtag_sysclk_path 	 [format "%s|%s|%s" $p2_grms_qsys_nios2_qsys_grms_oci_path $p2_grms_qsys_nios2_qsys_grms_wrapper $p2_grms_qsys_nios2_qsys_grms_jtag_sysclk]
set 	p2_grms_qsys_nios2_qsys_grms_jtag_sr 	 [format "%s|*sr" $p2_grms_qsys_nios2_qsys_grms_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$p2_grms_qsys_nios2_qsys_grms_oci_break_path|break_readreg*] -to [get_keepers *$p2_grms_qsys_nios2_qsys_grms_jtag_sr*]
set_false_path -from [get_keepers *$p2_grms_qsys_nios2_qsys_grms_oci_debug_path|*resetlatch]     -to [get_keepers *$p2_grms_qsys_nios2_qsys_grms_jtag_sr[33]]
set_false_path -from [get_keepers *$p2_grms_qsys_nios2_qsys_grms_oci_debug_path|monitor_ready]  -to [get_keepers *$p2_grms_qsys_nios2_qsys_grms_jtag_sr[0]]
set_false_path -from [get_keepers *$p2_grms_qsys_nios2_qsys_grms_oci_debug_path|monitor_error]  -to [get_keepers *$p2_grms_qsys_nios2_qsys_grms_jtag_sr[34]]
set_false_path -from [get_keepers *$p2_grms_qsys_nios2_qsys_grms_ocimem_path|*MonDReg*] -to [get_keepers *$p2_grms_qsys_nios2_qsys_grms_jtag_sr*]
set_false_path -from *$p2_grms_qsys_nios2_qsys_grms_jtag_sr*    -to *$p2_grms_qsys_nios2_qsys_grms_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$p2_grms_qsys_nios2_qsys_grms_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$p2_grms_qsys_nios2_qsys_grms_oci_debug_path|monitor_go
