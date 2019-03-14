--========================================================================================================================
-- Copyright (c) 2019 by Thomas Stenseth.  All rights reserved.
-- You should have received a copy of the license file containing the MIT License (see LICENSE.TXT).
--========================================================================================================================

--------------------------------------------------------------------------------------------------------------------------
-- Description   : 
--------------------------------------------------------------------------------------------------------------------------

--========================================================================================================================
-- This VVC was generated with Bitvis VVC Generator
--========================================================================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library uvvm_util;
context uvvm_util.uvvm_util_context;

--========================================================================================================================
package avalon_st_bfm_pkg is

   --========================================================================================================================
   -- Types and constants for AVALON-ST BFM 
   --========================================================================================================================
   constant C_SCOPE : string := "AVALON-ST BFM";

   -- Avalon Interface signals
   type t_avalon_st_source_if is 
   record
      --channel_o         : std_logic_vector;
      data_o            : std_logic_vector;
      --error_o           : std_logic_vector;
      ready_i           : std_logic;     
      valid_o           : std_logic;
      empty_o           : std_logic_vector;
      endofpacket_o     : std_logic;
      startofpacket_o   : std_logic;
   end record;

   type t_avalon_st_sink_if is 
   record
      --channel_i         : std_logic_vector;
      data_i            : std_logic_vector;
      --error_i           : std_logic_vector;
      ready_o           : std_logic;     
      valid_i           : std_logic;
      empty_i           : std_logic_vector;
      endofpacket_i     : std_logic;
      startofpacket_i   : std_logic;
      -- Debug signal
      check_data        : std_logic_vector;
   end record;

   -- Configuration record to be assigned in the test harness.
   type t_avalon_st_bfm_config is
   record
      max_wait_cycles          : integer;                -- The maximum number of clock cycles to wait before reporting a timeout alert.
      max_wait_cycles_severity : t_alert_level;          -- The above timeout will have this severity
      clock_period             : time;                   -- Period of the clock signal
      clock_period_margin      : time;                   -- Input clock period accuracy margin to specified clock_period
      clock_margin_severity    : t_alert_level;          -- The above margin will have this severity
      setup_time               : time;                   -- Setup time for generated signals, set to clock_period/4
      hold_time                : time;                   -- Hold time for generated signals, set to clock_period/4
      ready_percentage         : natural range 0 to 100; -- Percent of cycles the receive module should assert ready_o signal
      -- Enable/disable specific signals in Alavlon-ST  
      --use_channel              : boolean;          -- Use channel signal
      --use_error                : boolean;          -- Use error signal
      use_empty                : boolean;          -- Use empty signal
      -- Common
      id_for_bfm               : t_msg_id;         -- The message ID used as a general message ID in the Avalon-ST BFM
      id_for_bfm_wait          : t_msg_id;         -- The message ID used for logging waits in the Avalon-ST BFM
      id_for_bfm_poll          : t_msg_id;         -- The message ID used for logging polling in the Avalon-ST BFM
   end record;

   constant C_AVALON_ST_BFM_CONFIG_DEFAULT : t_avalon_st_bfm_config := (
      max_wait_cycles            => 10,
      max_wait_cycles_severity   => failure,
      clock_period               => 10 ns,
      clock_period_margin        => 0 ns,
      clock_margin_severity      => TB_ERROR,
      setup_time                 => 2.5 ns,
      hold_time                  => 2.5 ns,
      ready_percentage           => 100,
      --use_channel                => true,
      --use_error                  => true, 
      use_empty                  => true,
      id_for_bfm                 => ID_BFM,
      id_for_bfm_wait            => ID_BFM_WAIT,
      id_for_bfm_poll            => ID_BFM_POLL
   );


   --========================================================================================================================
   -- BFM procedures 
   --========================================================================================================================

   ------------------------------------------
   -- init_avalon_st_source_if_signals
   ------------------------------------------
   function init_avalon_st_source_if_signals (
      --channel_width  : natural;
      data_width     : natural;
      --error_width    : natural;
      empty_width    : natural
   ) return t_avalon_st_source_if;

   ------------------------------------------
   -- init_avalon_st_sink_if_signals
   ------------------------------------------
   function init_avalon_st_sink_if_signals (
      --channel_width  : natural;
      data_width     : natural;
      --error_width    : natural;
      empty_width    : natural
   ) return t_avalon_st_sink_if;

   ------------------------------------------
   -- avalon_st_send
   ------------------------------------------
   procedure avalon_st_send (
      --constant channel_num       : in     std_logic_vector;
      constant data_array        : in     t_slv_array;
      constant data_width        : in     natural;
      --constant error_bit_mask    : in     t_slv_array;     
      constant empty             : in     std_logic_vector;
      constant empty_width       : in     natural;
      constant msg               : in     string;
      signal clk                 : in     std_logic;
      signal avalon_st_source_if : inout  t_avalon_st_source_if;
      constant scope             : in     string                  := C_SCOPE;
      constant msg_id_panel      : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config            : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   );

   ------------------------------------------
   -- avalon_st_receive
   ------------------------------------------
   procedure avalon_st_receive (
      --variable channel_num          : out     std_logic_vector;
      variable data_array           : out     t_slv_array;
      constant data_width           : in     natural;
      --variable error_bit_mask       : out     t_slv_array;     
      variable empty                : out     std_logic_vector;
      constant empty_width          : in     natural;
      constant msg                  : in     string;
      signal clk                    : in     std_logic;
      --signal avalon_st_sink_if      : inout  t_avalon_st_sink_if;
      signal data_i                 : in std_logic_vector; 
      signal ready_o                : out std_logic;
      signal valid_i                : in std_logic;
      signal empty_i                : in std_logic_vector;
      signal endofpacket_i          : in std_logic;
      signal startofpacket_i        : in std_logic;
      signal check_data             : out std_logic_vector;
      constant scope                : in     string                  := C_SCOPE;
      constant msg_id_panel         : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config               : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   );



end package avalon_st_bfm_pkg;


--========================================================================================================================
--========================================================================================================================

package body avalon_st_bfm_pkg is

   ---------------------------------------------------------------------------------
   -- initialize Avalon-ST to DUT signals
   ---------------------------------------------------------------------------------
   function init_avalon_st_source_if_signals (
         --channel_width  : natural;
         data_width     : natural;
         --error_width    : natural;
         empty_width    : natural
      ) return t_avalon_st_source_if is
      variable result : t_avalon_st_source_if(
         --channel_o(channel_width - 1 downto 0),
         data_o(data_width - 1 downto 0),
         --error_o(error_width -1 downto 0),
         empty_o(empty_width -1 downto 0)
      );
   begin
      --result.channel_o        := (result.channel_o'range    => '0');
      result.data_o           := (result.data_o'range       => '0');
      --result.error_o          := (result.error_o'range      => '0');
      result.ready_i          := 'Z';
      result.valid_o          := '0';
      result.empty_o          := (result.empty_o'range      => '0');
      result.endofpacket_o    := '0';
      result.startofpacket_o  := '0';
      return result;
   end function;

   ---------------------------------------------------------------------------------
   -- initialize DUT to Avalon-ST signals
   ---------------------------------------------------------------------------------
   function init_avalon_st_sink_if_signals (
         --channel_width  : natural;
         data_width     : natural;
         --error_width    : natural;
         empty_width    : natural
      ) return t_avalon_st_sink_if is
      variable result : t_avalon_st_sink_if(
         --channel_i(channel_width - 1 downto 0),
         data_i(data_width - 1 downto 0),
         --error_i(error_width -1 downto 0),
         empty_i(empty_width -1 downto 0),
         check_data(data_width -1 downto 0)
      );
   begin
      --result.channel_i        := (result.channel_i'range    => 'Z');
      result.data_i           := (result.data_i'range       => 'Z');
      --result.error_i          := (result.error_i'range      => 'Z');
      result.ready_o          := '0';
      result.valid_i          := 'Z';
      result.empty_i          := (result.empty_i'range      => 'Z');
      result.endofpacket_i    := 'Z';
      result.startofpacket_i  := 'Z';
      return result;
   end function;

   ------------------------------------------
   -- avalon_st_send
   ------------------------------------------
   procedure avalon_st_send (
      --constant channel_num       : in     std_logic_vector;
      constant data_array        : in     t_slv_array;
      constant data_width        : in     natural;
      --constant error_bit_mask    : in     t_slv_array;     
      constant empty             : in     std_logic_vector;
      constant empty_width       : in     natural;
      constant msg               : in     string;
      signal clk                 : in     std_logic;
      signal avalon_st_source_if : inout t_avalon_st_source_if;
      constant scope             : in     string                  := C_SCOPE;
      constant msg_id_panel      : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config            : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   ) is
      constant proc_name : string := "avalon_st_send";
      --onstant proc_call : string := proc_name & "(" & to_string(data_array, HEX, AS_IS, INCL_RADIX) & ")";
      constant proc_call : string := proc_name & "(" & to_string(data_width) & " bits)";
   begin
      check_value(data_array'ascending, TB_ERROR, "Sanity check: Check that data_array is ascending (defined with 'to'), for byte order clarity", scope, ID_NEVER, msg_id_panel, proc_call);

      -- setup_time and hold_time checking
      check_value(config.setup_time < config.clock_period/2, TB_FAILURE, "Sanity check: Check that setup_time do not exceed clock_period/2.", scope, ID_NEVER, msg_id_panel, proc_call);
      check_value(config.hold_time < config.clock_period/2, TB_FAILURE, "Sanity check: Check that hold_time do not exceed clock_period/2.", scope, ID_NEVER, msg_id_panel, proc_call);
      check_value(config.setup_time > 0 ns, TB_FAILURE, "Sanity check: Check that setup_time is more than 0 ns.", scope, ID_NEVER, msg_id_panel, proc_call);
      check_value(config.hold_time > 0 ns, TB_FAILURE, "Sanity check: Check that hold_time is more than 0 ns.", scope, ID_NEVER, msg_id_panel, proc_call);

      -- check if enough room for setup_time in low period
      if (clk = '0') and (config.setup_time > (config.clock_period/2 - clk'last_event))then
         await_value(clk, '1', 0 ns, config.clock_period/2, TB_FAILURE, proc_name & ": timeout waiting for clk low period for setup_time.");
      end if;
      -- Wait setup_time specified in config record
      wait_until_given_time_before_rising_edge(clk, config.setup_time, config.clock_period);

      log(ID_PACKET_INITIATE, proc_call & " => " & add_msg_delimiter(msg), scope, msg_id_panel);
      wait until rising_edge(clk);

      -- Loop through data_array
      for byte in 0 to data_array'high loop

         -- Wait for ready signal
         while (avalon_st_source_if.ready_i = '0') loop
            -- No valid data on data_o
            avalon_st_source_if.valid_o <= '0';

            -- Wait for next clock cycle, then check for ready
            wait until rising_edge(clk);
         end loop;

         -- Check for start of data_array
         if (byte = 0) then
            -- Beginning of packet transmission, send startofpacket
            log(ID_PACKET_DATA, proc_call & " => Sending startofpacket", scope, msg_id_panel);
            avalon_st_source_if.startofpacket_o <= '1', '0' after config.clock_period;
         end if;

         ---- Set channel to recieve data
         --if (config.use_channel) then
         --   avalon_st_source_if.channel_o <= channel_num;
         --end if;

         ---- Send error bit mask
         --if (config.use_error) then
         --   avalon_st_source_if.error_o <= error_bit_mask(byte);
         --end if;

         -- Send byte to data_o
         log(ID_PACKET_DATA, proc_call & " => Data: " & to_string(data_array(byte)(data_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & ", array entry# " & to_string(byte) & ". " & add_msg_delimiter(msg), scope, msg_id_panel);
         avalon_st_source_if.data_o <= data_array(byte)(data_width-1 downto 0);
         avalon_st_source_if.valid_o <= '1';

         -- Check for end of data_array
         if byte = data_array'high then
            -- Packet done
            if (config.use_empty) then
               -- Send empty signal together with last data
               log(ID_PACKET_DATA, proc_call & " => Number of symbols that are empty: " & to_string(empty, DEC, AS_IS, INCL_RADIX), scope, msg_id_panel);
               avalon_st_source_if.empty_o <= empty(empty_width-1 downto 0);
            end if;
            -- Send endofpacket
            log(ID_PACKET_DATA, proc_call & " => Sending endofpacket", scope, msg_id_panel);
            avalon_st_source_if.endofpacket_o <= '1', '0' after config.clock_period;
            avalon_st_source_if.valid_o <= '1', '0' after config.clock_period;
         end if;
         wait until rising_edge(clk);
      end loop;

      log(ID_PACKET_COMPLETE, proc_call & " => " & add_msg_delimiter(msg), scope, msg_id_panel);
   end procedure;

   ------------------------------------------
   -- avalon_st_receive
   ------------------------------------------
   procedure avalon_st_receive (
      --variable channel_num          : out     std_logic_vector;
      variable data_array           : out     t_slv_array;
      constant data_width           : in     natural;
      --variable error_bit_mask       : out     t_slv_array;     
      variable empty                : out     std_logic_vector;
      constant empty_width          : in     natural;
      constant msg                  : in     string;
      signal clk                    : in     std_logic;
      --signal avalon_st_sink_if      : inout  t_avalon_st_sink_if;
      signal data_i                 : in std_logic_vector; 
      signal ready_o                : out std_logic;
      signal valid_i                : in std_logic;
      signal empty_i                : in std_logic_vector;
      signal endofpacket_i          : in std_logic;
      signal startofpacket_i        : in std_logic;
      signal check_data             : out std_logic_vector;
      constant scope                : in     string                  := C_SCOPE;
      constant msg_id_panel         : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config               : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   ) is
      constant proc_name : string := "avalon_st_receive";
      constant proc_call : string := proc_name & "()";

      variable v_ready_low_done  : boolean   := false;
      variable v_received_sop    : boolean   := false;
      variable v_done            : boolean   := false;
      variable v_byte            : natural   := 0;
   begin
      log(ID_DEBUG, "Begin avalon_st_recieve inside BFM");
      check_value(data_array'ascending, TB_ERROR, "Sanity check: Check that data_array is ascending (defined with 'to'), for byte order clarity", scope, ID_NEVER, msg_id_panel, proc_call);
      
      -- setup_time and hold_time checking
      check_value(config.setup_time < config.clock_period/2, TB_FAILURE, "Sanity check: Check that setup_time do not exceed clock_period/2.", scope, ID_NEVER, msg_id_panel, proc_call);
      check_value(config.hold_time < config.clock_period/2, TB_FAILURE, "Sanity check: Check that hold_time do not exceed clock_period/2.", scope, ID_NEVER, msg_id_panel, proc_call);
      check_value(config.setup_time > 0 ns, TB_FAILURE, "Sanity check: Check that setup_time is more than 0 ns.", scope, ID_NEVER, msg_id_panel, proc_call);
      check_value(config.hold_time > 0 ns, TB_FAILURE, "Sanity check: Check that hold_time is more than 0 ns.", scope, ID_NEVER, msg_id_panel, proc_call);

      -- check if enough room for setup_time in low period
      if (clk = '0') and (config.setup_time > (config.clock_period/2 - clk'last_event))then
         await_value(clk, '1', 0 ns, config.clock_period/2, TB_FAILURE, proc_name & ": timeout waiting for clk low period for setup_time.");
      end if;
      -- Wait setup_time specified in config record
      wait_until_given_time_before_rising_edge(clk, config.setup_time, config.clock_period);
      log(ID_PACKET_INITIATE, proc_call & " => Receive packet. " & add_msg_delimiter(msg), scope, msg_id_panel);

      ------------------------------------------------------------------------------------------------------------
      -- Sample byte by byte until receive is done, (until endofpacket is received)
      ------------------------------------------------------------------------------------------------------------
      while not v_done loop
         -- Hold module before asserting ready
         if not v_ready_low_done then
            wait_until_given_time_after_rising_edge(clk, config.hold_time);
            v_ready_low_done := true;
         end if;

         if (random(1,100) <= config.ready_percentage) then
            -- Signal that the module is ready to recieve
            ready_o <= '1';
         else
            ready_o <= '0';
         end if;

         -- Wait for start of packet on a valid signal
         if (startofpacket_i = '1') and (valid_i = '1') then
            v_received_sop := true;
         end if;
         
         -- Sample data packet on each valid signal until endofpacket is recieved
         if v_received_sop and (valid_i = '1') then
            -- TODO: add last ready = 1 check, else assert error
            data_array(v_byte)(data_width-1 downto 0) := data_i;
            log(ID_PACKET_DATA, proc_call & " => Rx: " & to_string(data_array(v_byte)(data_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & ", data_array entry# " & to_string(v_byte) & ". " & add_msg_delimiter(msg), scope, msg_id_panel);

            if(endofpacket_i = '1') then
               -- Empty signal received together with last data
               empty(empty_width-1 downto 0) := empty_i;
               log(ID_PACKET_DATA, proc_call & " => Rx empty: " & to_string(empty(empty_width-1 downto 0), DEC, AS_IS, INCL_RADIX), scope, msg_id_panel);
               -- Done receiving data
               v_done := true;
               -- Signal that module is not ready to receive any more data
               ready_o <= '0';
            else
               -- Increase counter for data_array for next data to be received
               v_byte := v_byte + 1;
            end if; 

         end if;

         wait until rising_edge(clk);
      end loop;

   end procedure;
end package body avalon_st_bfm_pkg;

