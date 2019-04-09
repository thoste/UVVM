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
      --check_data        : std_logic_vector;
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
      use_channel              : boolean;          -- Use channel signal
      use_error                : boolean;          -- Use error signal
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
      use_channel                => false,
      use_error                  => false, 
      use_empty                  => false,
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

   --------------------------------------------------------
   --
   -- Avalon-ST send
   --
   --------------------------------------------------------
   procedure avalon_st_send (
      --constant channel_num          : in     std_logic_vector;
      constant data_array           : in     t_slv_array;
      constant data_width           : in     natural;
      --constant error_bit_mask       : in     t_slv_array;     
      constant empty                : in     std_logic_vector;
      constant empty_width          : in     natural;
      constant msg                  : in     string;
      signal   clk                  : in     std_logic;
      signal   avalon_st_source_if  : inout  t_avalon_st_source_if;
      constant scope                : in     string                  := C_SCOPE;
      constant msg_id_panel         : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config               : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   );

   ---------------------------------------------------------------------------------
   -- Overloaded version without records
   ---------------------------------------------------------------------------------
   procedure avalon_st_send (
      --constant channel_num       : in     std_logic_vector;
      constant data_array        : in     t_slv_array;
      constant data_width        : in     natural;
      --constant error_bit_mask    : in     t_slv_array;     
      constant empty             : in     std_logic_vector;
      constant empty_width       : in     natural;
      constant msg               : in     string;
      signal   clk               : in     std_logic;
      signal   data_o            : inout  std_logic_vector; 
      signal   ready_i           : inout  std_logic;
      signal   valid_o           : inout  std_logic;
      signal   empty_o           : inout  std_logic_vector;
      signal   endofpacket_o     : inout  std_logic;
      signal   startofpacket_o   : inout  std_logic;
      constant scope             : in     string                  := C_SCOPE;
      constant msg_id_panel      : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config            : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   );

   --------------------------------------------------------
   --
   -- Avalon-ST receive
   --
   --------------------------------------------------------
   procedure avalon_st_receive (
      --variable channel_num          : inout     std_logic_vector;
      variable data_array           : inout  t_slv_array;
      constant data_width           : in     natural;
      variable data_length          : inout  natural;
      --variable error_bit_mask       : inout     t_slv_array;     
      variable empty                : inout  std_logic_vector;
      constant empty_width          : in     natural;
      constant msg                  : in     string;
      signal   clk                  : in     std_logic;
      signal   avalon_st_sink_if    : inout  t_avalon_st_sink_if;
      constant scope                : in     string                  := C_SCOPE;
      constant msg_id_panel         : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config               : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   );

   ---------------------------------------------------------------------------------
   -- Overloaded version without records
   ---------------------------------------------------------------------------------
   procedure avalon_st_receive (
      --variable channel_num          : inout     std_logic_vector;
      variable data_array           : inout  t_slv_array;
      constant data_width           : in     natural;
      variable data_length          : inout  natural;
      --variable error_bit_mask       : inout     t_slv_array;     
      variable empty                : inout  std_logic_vector;
      constant empty_width          : in     natural;
      constant msg                  : in     string;
      signal   clk                  : in     std_logic;
      signal   data_i               : inout  std_logic_vector; 
      signal   ready_o              : inout  std_logic;
      signal   valid_i              : inout  std_logic;
      signal   empty_i              : inout  std_logic_vector;
      signal   endofpacket_i        : inout  std_logic;
      signal   startofpacket_i      : inout  std_logic;
      constant scope                : in     string                  := C_SCOPE;
      constant msg_id_panel         : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config               : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   );

   --------------------------------------------------------
   --
   -- Avalon-ST expect
   --
   --------------------------------------------------------
   procedure avalon_st_expect (
      constant exp_data_array    : in     t_slv_array;
      constant exp_data_width    : in     natural;
      constant exp_empty         : in     std_logic_vector;
      constant exp_empty_width   : in     natural;
      constant msg               : in     string;
      signal   clk               : in     std_logic;
      signal   avalon_st_sink_if : inout  t_avalon_st_sink_if;
      constant alert_level       : in     t_alert_level          := error;
      constant scope             : in     string                 := C_SCOPE;
      constant msg_id_panel      : in     t_msg_id_panel         := shared_msg_id_panel;
      constant config            : in     t_avalon_st_bfm_config := C_AVALON_ST_BFM_CONFIG_DEFAULT
   );

   ---------------------------------------------------------------------------------
   -- Overloaded version without records
   ---------------------------------------------------------------------------------
   procedure avalon_st_expect (
      constant exp_data_array    : in     t_slv_array;
      constant exp_data_width    : in     natural;
      constant exp_empty         : in     std_logic_vector;
      constant exp_empty_width   : in     natural;
      constant msg               : in     string;
      signal   clk               : in     std_logic;
      signal   data_i            : inout std_logic_vector; 
      signal   ready_o           : inout std_logic;
      signal   valid_i           : inout std_logic;
      signal   empty_i           : inout std_logic_vector;
      signal   endofpacket_i     : inout std_logic;
      signal   startofpacket_i   : inout std_logic;
      constant alert_level       : in     t_alert_level          := error;
      constant scope             : in     string                 := C_SCOPE;
      constant msg_id_panel      : in     t_msg_id_panel         := shared_msg_id_panel;
      constant config            : in     t_avalon_st_bfm_config := C_AVALON_ST_BFM_CONFIG_DEFAULT
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
         empty_i(empty_width -1 downto 0)
         --check_data(data_width -1 downto 0)
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

   --------------------------------------------------------
   --
   -- Avalon-ST send
   --
   --------------------------------------------------------
   procedure avalon_st_send (
      --constant channel_num          : in     std_logic_vector;
      constant data_array           : in     t_slv_array;
      constant data_width           : in     natural;
      --constant error_bit_mask       : in     t_slv_array;     
      constant empty                : in     std_logic_vector;
      constant empty_width          : in     natural;
      constant msg                  : in     string;
      signal   clk                  : in     std_logic;
      signal   avalon_st_source_if  : inout  t_avalon_st_source_if;
      constant scope                : in     string                  := C_SCOPE;
      constant msg_id_panel         : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config               : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   ) is
      constant proc_name : string := "avalon_st_send";
      --onstant proc_call : string := proc_name & "(" & to_string(data_array, HEX, AS_IS, INCL_RADIX) & ")";
      constant proc_call : string := proc_name & "(" & to_string(data_width) & " bits)";

      variable v_tot_symbols : natural;
      variable v_top_sym : natural;
      variable v_bot_sym : natural;
      variable v_empty : natural;
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

         -- Send symbols to data_o
         log(ID_PACKET_DATA, proc_call & " => TX: " & to_string(data_array(byte)(data_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & ", array entry# " & to_string(byte) & ". " & add_msg_delimiter(msg), scope, msg_id_panel);
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
            --avalon_st_source_if.endofpacket_o <= '1', '0' after config.clock_period;
            --avalon_st_source_if.valid_o <= '1', '0' after config.clock_period;
            avalon_st_source_if.endofpacket_o <= '1';
            avalon_st_source_if.valid_o <= '1';
         end if;
         wait until rising_edge(clk);
      end loop;

      -- Wait until module is done recieving
      while (avalon_st_source_if.ready_i = '0') loop
         -- Wait for next clock cycle, then check for ready
         wait until rising_edge(clk);
      end loop;

      log(ID_PACKET_COMPLETE, proc_call & " => Sent " & to_string(data_array'high + 1) & " data entries", scope, msg_id_panel);
      
      -- Done, set avalon_st_source_if back to default
      avalon_st_source_if <= init_avalon_st_source_if_signals(
         data_width  => avalon_st_source_if.data_o'length,
         empty_width => avalon_st_source_if.empty_o'length
      );
   end procedure avalon_st_send;


   ---------------------------------------------------------------------------------
   -- Overloaded version without records
   ---------------------------------------------------------------------------------
   procedure avalon_st_send (
      --constant channel_num       : in     std_logic_vector;
      constant data_array        : in     t_slv_array;
      constant data_width        : in     natural;
      --constant error_bit_mask    : in     t_slv_array;     
      constant empty             : in     std_logic_vector;
      constant empty_width       : in     natural;
      constant msg               : in     string;
      signal   clk               : in     std_logic;
      signal   data_o            : inout  std_logic_vector; 
      signal   ready_i           : inout  std_logic;
      signal   valid_o           : inout  std_logic;
      signal   empty_o           : inout  std_logic_vector;
      signal   endofpacket_o     : inout  std_logic;
      signal   startofpacket_o   : inout  std_logic;
      constant scope             : in     string                  := C_SCOPE;
      constant msg_id_panel      : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config            : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   ) is
   begin
      -- Simply call the record version
      avalon_st_send(
         data_array        => data_array,
         data_width        => data_width,
         empty             => empty,
         empty_width       => empty_width,
         msg               => msg,
         clk               => clk,
         avalon_st_source_if.data_o            => data_o,
         avalon_st_source_if.ready_i           => ready_i,
         avalon_st_source_if.valid_o           => valid_o,
         avalon_st_source_if.empty_o           => empty_o,
         avalon_st_source_if.endofpacket_o     => endofpacket_o,
         avalon_st_source_if.startofpacket_o   => startofpacket_o,
         scope          => scope,
         msg_id_panel   => msg_id_panel,
         config         => config
      );
   end procedure avalon_st_send;


   --------------------------------------------------------
   --
   -- Avalon-ST receive
   --
   --------------------------------------------------------
   procedure avalon_st_receive (
      --variable channel_num          : inout     std_logic_vector;
      variable data_array           : inout     t_slv_array;
      constant data_width           : in     natural;
      variable data_length          : inout  natural;
      --variable error_bit_mask       : inout     t_slv_array;     
      variable empty                : inout  std_logic_vector;
      constant empty_width          : in     natural;
      constant msg                  : in     string;
      signal   clk                  : in     std_logic;
      signal   avalon_st_sink_if    : inout  t_avalon_st_sink_if;
      constant scope                : in     string                  := C_SCOPE;
      constant msg_id_panel         : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config               : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   ) is
      constant proc_name : string := "avalon_st_receive";
      constant proc_call : string := proc_name & "(" & to_string(data_width) & " bits)";

      variable v_ready_low_done  : boolean   := false;
      variable v_received_sop    : boolean   := false;
      variable v_done            : boolean   := false;
      variable v_byte            : natural   := 0;

      variable v_data_i          : std_logic_vector(19 downto 0) := (others => '0');
      variable v_valid_i       : std_logic := '0';
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

      ------------------------------------------------------------------------------------------------------------
      -- Sample byte by byte until receive is done, (until endofpacket is received)
      ------------------------------------------------------------------------------------------------------------
      while not v_done loop
         -- Hold module before asserting ready
         if not v_ready_low_done then
            wait_until_given_time_after_rising_edge(clk, config.hold_time);
            v_ready_low_done := true;
         end if;

         -- Assert signals on rising edge
         wait until rising_edge(clk);

         if (random(1,100) <= config.ready_percentage) then
            -- Signal that the module is ready to recieve
            avalon_st_sink_if.ready_o <= '1';
         else
            avalon_st_sink_if.ready_o <= '0';
         end if;

         -- Wait for start of packet on a valid signal
         if (avalon_st_sink_if.startofpacket_i = '1') and (avalon_st_sink_if.valid_i = '1') then
            v_received_sop := true;
            log(ID_PACKET_DATA, proc_call & " => Received startofpacket", scope, msg_id_panel);
         end if;
         
         -- Sample data packet on each valid signal until endofpacket is recieved
         if v_received_sop and (avalon_st_sink_if.valid_i = '1') and avalon_st_sink_if.ready_o = '1' then
            -- TODO: add last ready = 1 check, else assert error
            data_array(v_byte)(data_width-1 downto 0) := avalon_st_sink_if.data_i;
            log(ID_PACKET_DATA, proc_call & " => RX: " & to_string(data_array(v_byte)(data_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & ", data_array entry# " & to_string(v_byte) & ". " & add_msg_delimiter(msg), scope, msg_id_panel);

            if(avalon_st_sink_if.endofpacket_i = '1') then
               log(ID_PACKET_DATA, proc_call & " => Received endofpacket", scope, msg_id_panel);
               -- Empty signal received together with last data
               empty(empty_width-1 downto 0) := avalon_st_sink_if.empty_i;
               log(ID_PACKET_DATA, proc_call & " => RX empty signal: " & to_string(empty(empty_width-1 downto 0), HEX, AS_IS, INCL_RADIX), scope, msg_id_panel);
               
               -- DANGEROUS!!!! 
               -- Done receiving data
               v_done := true;
               -- Signal that module is not ready to receive any more data
               avalon_st_sink_if.ready_o <= '0'; 
               -- TODO:
               -- May lose data if new data arrives on next clock cycle
               -- This happens since endofpacket_i and data_i is sampled on current clk, but ready_o is set low on next clk cycle
               -- Avalon-ST with ready latency of 1 (Avalon-ST video) implies that a module should be able to recieve data one clk cycle after setting ready low
            else
               -- Increase counter for data_array for next data to be received
               v_byte := v_byte + 1;
            end if;
         end if;

      end loop;

      data_length := v_byte;
      log(ID_PACKET_COMPLETE, proc_call & " => Recieved " & to_string(data_length + 1) & " data entires", scope, msg_id_panel);

      -- Done, set avalon_st_sink_if back to default
      avalon_st_sink_if <= init_avalon_st_sink_if_signals(
         data_width  => avalon_st_sink_if.data_i'length,
         empty_width => avalon_st_sink_if.empty_i'length
      );
   end procedure avalon_st_receive;


   ---------------------------------------------------------------------------------
   -- Overloaded version without records
   ---------------------------------------------------------------------------------
   procedure avalon_st_receive (
      --variable channel_num          : inout     std_logic_vector;
      variable data_array           : inout     t_slv_array;
      constant data_width           : in     natural;
      variable data_length          : inout  natural;
      --variable error_bit_mask       : inout     t_slv_array;     
      variable empty                : inout  std_logic_vector;
      constant empty_width          : in     natural;
      constant msg                  : in     string;
      signal   clk                  : in     std_logic;
      signal   data_i               : inout  std_logic_vector; 
      signal   ready_o              : inout  std_logic;
      signal   valid_i              : inout  std_logic;
      signal   empty_i              : inout  std_logic_vector;
      signal   endofpacket_i        : inout  std_logic;
      signal   startofpacket_i      : inout  std_logic;
      constant scope                : in     string                  := C_SCOPE;
      constant msg_id_panel         : in     t_msg_id_panel          := shared_msg_id_panel;
      constant config               : in     t_avalon_st_bfm_config  := C_AVALON_ST_BFM_CONFIG_DEFAULT
   ) is
   begin
      -- Simply call the record version
      avalon_st_receive(
         data_array                          => data_array,
         data_length                         => data_length,
         data_width                          => data_width,
         empty                               => empty,
         empty_width                         => empty_width,
         msg                                 => msg,
         clk                                 => clk,
         avalon_st_sink_if.data_i            => data_i,
         avalon_st_sink_if.ready_o           => ready_o,
         avalon_st_sink_if.valid_i           => valid_i,
         avalon_st_sink_if.empty_i           => empty_i,
         avalon_st_sink_if.endofpacket_i     => endofpacket_i,
         avalon_st_sink_if.startofpacket_i   => startofpacket_i,
         scope                               => scope,
         msg_id_panel                        => msg_id_panel,
         config                              => config
      );
   end procedure avalon_st_receive;


   --------------------------------------------------------
   --
   -- Avalon-ST expect
   --
   --------------------------------------------------------
   procedure avalon_st_expect (
      constant exp_data_array    : in     t_slv_array;
      constant exp_data_width    : in     natural;
      constant exp_empty         : in     std_logic_vector;
      constant exp_empty_width   : in     natural;
      constant msg               : in     string;
      signal   clk               : in     std_logic;
      signal   avalon_st_sink_if : inout  t_avalon_st_sink_if;
      constant alert_level       : in     t_alert_level          := error;
      constant scope             : in     string                 := C_SCOPE;
      constant msg_id_panel      : in     t_msg_id_panel         := shared_msg_id_panel;
      constant config            : in     t_avalon_st_bfm_config := C_AVALON_ST_BFM_CONFIG_DEFAULT
   ) is
      constant proc_name : string := "avalon_st_expect";
      constant proc_call : string := proc_name & "(" & to_string(exp_data_width) & " data bits, " & to_string(exp_empty_width) & " empty bits)";

      variable v_config          : t_avalon_st_bfm_config := config;
      variable v_rx_data_array   : t_slv_array(exp_data_array'range)(exp_data_array(0)'range);  -- received data
      variable v_rx_data_length  : natural;
      variable v_rx_data_width   : natural;
      variable v_rx_empty_slv    : std_logic_vector(exp_empty'range);
      variable v_rx_empty_width  : natural;
      variable v_data_error_cnt  : natural := 0;
      variable v_empty_error_cnt : natural := 0;
      variable v_first_errored_byte : natural;
   begin
      v_rx_data_width   := exp_data_width; 
      v_rx_empty_width  := exp_empty_width;

      -- Receive and store data
      avalon_st_receive(
         data_array        => v_rx_data_array,
         data_length       => v_rx_data_length,
         data_width        => v_rx_data_width,
         empty             => v_rx_empty_slv,
         empty_width       => v_rx_empty_width,
         msg               => msg,
         clk               => clk,
         data_i            => avalon_st_sink_if.data_i,
         ready_o           => avalon_st_sink_if.ready_o,
         valid_i           => avalon_st_sink_if.valid_i,
         empty_i           => avalon_st_sink_if.empty_i,
         endofpacket_i     => avalon_st_sink_if.endofpacket_i,
         startofpacket_i   => avalon_st_sink_if.startofpacket_i,
         scope             => scope,
         msg_id_panel      => msg_id_panel,
         config            => v_config
      );

      -- Check if each received bit matches the expected
      -- Find and report the first errored byte
      for byte in v_rx_data_array'high downto 0 loop
         for i in v_rx_data_width-1 downto 0 loop
            if (exp_data_array(byte)(i) = '-') or  -- Expected set to don't care, or
               (v_rx_data_array(byte)(i) = exp_data_array(byte)(i)) then  -- received value matches expected
               -- Check is OK
            else
               -- Received byte does not match the expected byte
               --log(ID_PACKET_DATA, proc_call & "=> DATA NOT OK, checked " & to_string(v_rx_data_array(byte)(v_rx_data_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & " = " & to_string(exp_data_array(byte)(v_rx_data_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & msg, scope, msg_id_panel);
               v_data_error_cnt     := v_data_error_cnt + 1;
               v_first_errored_byte := byte;
            end if;
         end loop;
      end loop;

      for j in v_rx_empty_width-1 downto 0 loop
         if(exp_empty(j) = '-') or
            (v_rx_empty_slv(j) = exp_empty(j)) then
               -- Check is OK
         else
            -- Received empty does not match expected empty
            --log(ID_PACKET_DATA, proc_call & "=> EMPTY NOT OK, checked " & to_string(v_rx_empty_slv(v_rx_empty_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & " = " & to_string(exp_empty(v_rx_empty_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & msg, scope, msg_id_panel);
            v_empty_error_cnt     := v_empty_error_cnt + 1;
         end if;
      end loop;

      -- No more than one alert per packet
    if v_data_error_cnt /= 0 then
      alert(alert_level, proc_call & "=> Failed in " & to_string(v_data_error_cnt) & " data bits. First mismatch in byte# " & to_string(v_first_errored_byte) & ". Was " & to_string(v_rx_data_array(v_first_errored_byte)(v_rx_data_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & ". Expected " & to_string(exp_data_array(v_first_errored_byte)(v_rx_data_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & "." & LF & add_msg_delimiter(msg), scope);
    elsif v_empty_error_cnt /= 0 then
      alert(alert_level, proc_call & "=> Failed in " & to_string(v_empty_error_cnt) & " empty bits. Was " & to_string(v_rx_empty_slv(v_rx_empty_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & ". Expected " & to_string(exp_empty(v_rx_empty_width-1 downto 0), HEX, AS_IS, INCL_RADIX) & "." & LF & add_msg_delimiter(msg), scope);
    else
      log(config.id_for_bfm, proc_call & "=> OK, received " & to_string(v_rx_data_array'length) & " data entries. " & add_msg_delimiter(msg), scope, msg_id_panel);
    end if;

   end procedure avalon_st_expect;


   ---------------------------------------------------------------------------------
   -- Overloaded version without records
   ---------------------------------------------------------------------------------
   procedure avalon_st_expect (
      constant exp_data_array    : in     t_slv_array;
      constant exp_data_width    : in     natural;
      constant exp_empty         : in     std_logic_vector;
      constant exp_empty_width   : in     natural;
      constant msg               : in     string;
      signal   clk               : in     std_logic;
      signal   data_i            : inout  std_logic_vector; 
      signal   ready_o           : inout  std_logic;
      signal   valid_i           : inout  std_logic;
      signal   empty_i           : inout  std_logic_vector;
      signal   endofpacket_i     : inout  std_logic;
      signal   startofpacket_i   : inout  std_logic;
      constant alert_level       : in     t_alert_level          := error;
      constant scope             : in     string                 := C_SCOPE;
      constant msg_id_panel      : in     t_msg_id_panel         := shared_msg_id_panel;
      constant config            : in     t_avalon_st_bfm_config := C_AVALON_ST_BFM_CONFIG_DEFAULT
   ) is
   begin
      -- Simply call the record version
      avalon_st_expect(
         exp_data_array                      => exp_data_array,
         exp_data_width                      => exp_data_width,
         exp_empty                           => exp_empty,
         exp_empty_width                     => exp_empty_width,
         msg                                 => msg,
         clk                                 => clk,
         avalon_st_sink_if.data_i            => data_i,
         avalon_st_sink_if.ready_o           => ready_o,
         avalon_st_sink_if.valid_i           => valid_i,
         avalon_st_sink_if.empty_i           => empty_i,
         avalon_st_sink_if.endofpacket_i     => endofpacket_i,
         avalon_st_sink_if.startofpacket_i   => startofpacket_i,
         scope                               => scope,
         msg_id_panel                        => msg_id_panel,
         config                              => config
      );
   end procedure avalon_st_expect;

end package body avalon_st_bfm_pkg;

