------------------------------------------------------------------------------------------
-- Project: FPGA video scaler
-- Author: Thomas Stenseth
-- Date: 2019-03-11
-- Version: 0.1
------------------------------------------------------------------------------------------
-- Description:
------------------------------------------------------------------------------------------
-- v0.1:
------------------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library uvvm_util;
context uvvm_util.uvvm_util_context;

library uvvm_vvc_framework;
use uvvm_vvc_framework.ti_vvc_framework_support_pkg.all;
use uvvm_vvc_framework.ti_data_fifo_pkg.all;

library vip_avalon_st;
use vip_avalon_st.avalon_st_bfm_pkg.all;
use vip_avalon_st.vvc_methods_pkg.all;
use vip_avalon_st.td_vvc_framework_common_methods_pkg.all;


-- Test bench entity
entity tb_avalon_st_vvc is
end entity;

-- Test bench architecture
architecture func of tb_avalon_st_vvc is
   constant C_SCOPE              : string  := C_TB_SCOPE_DEFAULT;

   -- Clock and bit period settings
   constant C_CLK_PERIOD         : time := 10 ns;
   constant C_BIT_PERIOD         : time := 16 * C_CLK_PERIOD;
begin
   -----------------------------------------------------------------------------
   -- Instantiate test harness, containing DUT and Executors
   -----------------------------------------------------------------------------
   i_test_harness : entity work.th_avalon_st_vvc;



   ------------------------------------------------
   -- PROCESS: p_main
   ------------------------------------------------
   p_main: process
      variable v_data_array   : t_slv_array(0 to 9)(19 downto 0) := (others => (others => '0'));
      variable v_empty        : std_logic_vector(1 downto 0) := 2x"0";
      variable v_counter      : natural := 10;
   begin

   -- Wait for UVVM to finish initialization
   await_uvvm_initialization(VOID);

   -- Print the configuration to the log
   report_global_ctrl(VOID);
   report_msg_id_panel(VOID);

   -- Enable log message
   disable_log_msg(ALL_MESSAGES);
   enable_log_msg(ID_LOG_HDR);
   enable_log_msg(ID_SEQUENCER);
   enable_log_msg(ID_UVVM_SEND_CMD);

   -- Enable/disable Avalon-ST signals 
   --shared_avalon_st_vvc_config(TX, 1).bfm_config.use_channel   := false;
   --shared_avalon_st_vvc_config(TX, 1).bfm_config.use_error     := false;
   shared_avalon_st_vvc_config(TX, 1).bfm_config.use_empty     := true;


   log(ID_LOG_HDR, "Starting simulation of TB scaler vvc", C_SCOPE);
   log("Wait 10 clock period for reset to be turned off");
   wait for (10 * C_CLK_PERIOD); 

   -- Write data to data_array
   for i in v_data_array'range loop
      -- TODO: write random data from OSVVM
      v_data_array(i) := std_logic_vector(to_unsigned(v_counter, v_data_array(i)'length));
      v_counter := v_counter + 10;
   end loop;


   avalon_st_send(AVALON_ST_VVCT, 1, v_data_array, v_empty, "Sending v_data_array");
   await_completion(AVALON_ST_VVCT, 1, TX, 200*C_CLK_PERIOD);





   -----------------------------------------------------------------------------
   -- Ending the simulation
   -----------------------------------------------------------------------------
   wait for 1000 ns;             -- to allow some time for completion
   report_alert_counters(FINAL); -- Report final counters and print conclusion for simulation (Success/Fail)
   log(ID_LOG_HDR, "SIMULATION COMPLETED", C_SCOPE);

   -- Finish the simulation
   std.env.stop;
   wait;  -- to stop completely

   end process p_main;

end func;
