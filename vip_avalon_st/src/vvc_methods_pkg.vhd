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

library uvvm_vvc_framework;
use uvvm_vvc_framework.ti_vvc_framework_support_pkg.all;

use work.avalon_st_bfm_pkg.all;
use work.vvc_cmd_pkg.all;
use work.td_target_support_pkg.all;

--========================================================================================================================
--========================================================================================================================
package vvc_methods_pkg is

  --========================================================================================================================
  -- Types and constants for the AVALON_ST VVC 
  --========================================================================================================================
  constant C_VVC_NAME     : string := "AVALON_ST_VVC";

  signal AVALON_ST_VVCT    : t_vvc_target_record := set_vvc_target_defaults(C_VVC_NAME);
  alias  THIS_VVCT         : t_vvc_target_record is AVALON_ST_VVCT;
  alias  t_bfm_config is t_avalon_st_bfm_config;

  -- Type found in UVVM-Util types_pkg
  constant C_AVALON_ST_INTER_BFM_DELAY_DEFAULT : t_inter_bfm_delay := (
    delay_type                          => NO_DELAY,
    delay_in_time                       => 0 ns,
    inter_bfm_delay_violation_severity  => WARNING
  );

  type t_vvc_config is
  record
    inter_bfm_delay                       : t_inter_bfm_delay;-- Minimum delay between BFM accesses from the VVC. If parameter delay_type is set to NO_DELAY, BFM accesses will be back to back, i.e. no delay.
    cmd_queue_count_max                   : natural;          -- Maximum pending number in command executor before executor is full. Adding additional commands will result in an ERROR.
    cmd_queue_count_threshold             : natural;          -- An alert with severity 'cmd_queue_count_threshold_severity' will be issued if command executor exceeds this count. Used for early warning if command executor is almost full. Will be ignored if set to 0.
    cmd_queue_count_threshold_severity    : t_alert_level;    -- Severity of alert to be initiated if exceeding cmd_queue_count_threshold
    result_queue_count_max                : natural;
    result_queue_count_threshold_severity : t_alert_level;
    result_queue_count_threshold          : natural;
    bfm_config                            : t_avalon_st_bfm_config; -- Configuration for the BFM. See BFM quick reference
    msg_id_panel                          : t_msg_id_panel;   -- VVC dedicated message ID panel
  end record;

  type t_vvc_config_array is array (t_channel range <>, natural range <>) of t_vvc_config;

  constant C_AVALON_ST_VVC_CONFIG_DEFAULT : t_vvc_config := (
    inter_bfm_delay                       => C_AVALON_ST_INTER_BFM_DELAY_DEFAULT,
    cmd_queue_count_max                   => C_CMD_QUEUE_COUNT_MAX, --  from adaptation package
    cmd_queue_count_threshold             => C_CMD_QUEUE_COUNT_THRESHOLD,
    cmd_queue_count_threshold_severity    => C_CMD_QUEUE_COUNT_THRESHOLD_SEVERITY,
    result_queue_count_max                => C_RESULT_QUEUE_COUNT_MAX,
    result_queue_count_threshold_severity => C_RESULT_QUEUE_COUNT_THRESHOLD_SEVERITY,
    result_queue_count_threshold          => C_RESULT_QUEUE_COUNT_THRESHOLD,
    bfm_config                            => C_AVALON_ST_BFM_CONFIG_DEFAULT,
    msg_id_panel                          => C_VVC_MSG_ID_PANEL_DEFAULT
  );

  type t_vvc_status is
  record
    current_cmd_idx       : natural;
    previous_cmd_idx      : natural;
    pending_cmd_cnt       : natural;
  end record;

  type t_vvc_status_array is array (t_channel range <>, natural range <>) of t_vvc_status;

  constant C_VVC_STATUS_DEFAULT : t_vvc_status := (
    current_cmd_idx      => 0,
    previous_cmd_idx     => 0,
    pending_cmd_cnt      => 0
  );

  -- Transaction information to include in the wave view during simulation
  type t_transaction_info is
  record
    operation       : t_operation;
    msg             : string(1 to C_VVC_CMD_STRING_MAX_LENGTH);
    --<USER_INPUT> Fields that could be useful to track in the waveview can be placed in this record.
    -- Example:
    -- addr            : unsigned(C_VVC_CMD_ADDR_MAX_LENGTH-1 downto 0);
    -- data            : std_logic_vector(C_VVC_CMD_DATA_MAX_LENGTH-1 downto 0);
  end record;

  type t_transaction_info_array is array (t_channel range <>, natural range <>) of t_transaction_info;

  constant C_TRANSACTION_INFO_DEFAULT : t_transaction_info := (
    --<USER_INPUT> Set the data fields added to the t_transaction_info record to 
    -- their default values here.
    -- Example:
    -- addr                => (others => '0'),
    -- data                => (others => '0'),
    operation           =>  NO_OPERATION,
    msg                 => (others => ' ')
  );


  shared variable shared_avalon_st_vvc_config : t_vvc_config_array(t_channel'left to t_channel'right, 0 to C_MAX_VVC_INSTANCE_NUM-1) := (others => (others => C_AVALON_ST_VVC_CONFIG_DEFAULT));
  shared variable shared_avalon_st_vvc_status : t_vvc_status_array(t_channel'left to t_channel'right, 0 to C_MAX_VVC_INSTANCE_NUM-1) := (others => (others => C_VVC_STATUS_DEFAULT));
  shared variable shared_avalon_st_transaction_info : t_transaction_info_array(t_channel'left to t_channel'right, 0 to C_MAX_VVC_INSTANCE_NUM-1) := (others => (others => C_TRANSACTION_INFO_DEFAULT));


  --========================================================================================================================
  -- Methods dedicated to this VVC 
  -- - These procedures are called from the testbench in order to executor BFM calls 
  --   in the VVC command executor. The VVC will store and forward these calls to the
  --   AVALON_ST BFM when the command is at the from of the VVC command executor.
  --========================================================================================================================


  procedure avalon_st_send(
    signal VVCT                 : inout t_vvc_target_record;
    constant vvc_instance_idx   : in    integer;
    constant data_array         : in    t_slv_array;
    constant empty              : in    std_logic_vector;
    constant msg                : in    string
  );

  procedure avalon_st_receive(
    signal VVCT                 : inout t_vvc_target_record;
    constant vvc_instance_idx   : in    integer;
    constant msg                : in    string
  );

end package vvc_methods_pkg;


package body vvc_methods_pkg is


  --========================================================================================================================
  -- Methods dedicated to this VVC
  --========================================================================================================================

  procedure avalon_st_send(
    signal VVCT                 : inout t_vvc_target_record;
    constant vvc_instance_idx   : in    integer;
    constant data_array         : in    t_slv_array;
    constant empty              : in    std_logic_vector;
    constant msg                : in    string
  ) is
    constant proc_name : string := get_procedure_name_from_instance_name(vvc_instance_idx'instance_name);
    constant proc_call : string := proc_name & "(" & to_string(VVCT, vvc_instance_idx) & ", " & to_string(data_array'length) & " data entries)";
  begin

    -- Create command by setting common global 'VVCT' signal record and dedicated VVC 'shared_vvc_cmd' record
    -- locking semaphore in set_general_target_and_command_fields to gain exclusive right to VVCT and shared_vvc_cmd
    -- semaphore gets unlocked in await_cmd_from_sequencer of the targeted VVC
    set_general_target_and_command_fields(VVCT, vvc_instance_idx, TX, proc_call, msg, QUEUED, SEND);
    -- Sanity check to avoid confusing fatal error
    check_value(data_array'length > 0, TB_ERROR, proc_call & "data_array length must be > 0", "VVC");

    -- Generate cmd record
    for i in data_array'range loop
      shared_vvc_cmd.data_array(i)(data_array(i)'range) := data_array(i);
    end loop;
    shared_vvc_cmd.data_array_length                := data_array'length;
    shared_vvc_cmd.empty(empty'range)               := empty;

    -- Send command record
    send_command_to_vvc(VVCT);
  end procedure;

  procedure avalon_st_receive(
    signal VVCT                 : inout t_vvc_target_record;
    constant vvc_instance_idx   : in    integer;
    constant msg                : in    string
  ) is
    constant proc_name : string := get_procedure_name_from_instance_name(vvc_instance_idx'instance_name);
    constant proc_call : string := proc_name & "()";
  begin
    -- Create command by setting common global 'VVCT' signal record and dedicated VVC 'shared_vvc_cmd' record
    -- locking semaphore in set_general_target_and_command_fields to gain exclusive right to VVCT and shared_vvc_cmd
    -- semaphore gets unlocked in await_cmd_from_sequencer of the targeted VVC
    set_general_target_and_command_fields(VVCT, vvc_instance_idx, RX, proc_call, msg, QUEUED, RECEIVE);

    -- Send command record
    send_command_to_vvc(VVCT);
  end procedure;



end package body vvc_methods_pkg;
