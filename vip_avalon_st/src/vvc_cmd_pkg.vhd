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

--========================================================================================================================
--========================================================================================================================
package vvc_cmd_pkg is


  --========================================================================================================================
  -- t_operation
  -- - VVC and BFM operations
  --========================================================================================================================
  type t_operation is (
    NO_OPERATION,
    AWAIT_COMPLETION,
    AWAIT_ANY_COMPLETION,
    ENABLE_LOG_MSG,
    DISABLE_LOG_MSG,
    FLUSH_COMMAND_QUEUE,
    FETCH_RESULT,
    INSERT_DELAY,
    TERMINATE_CURRENT_COMMAND,
    -- VVC local
    SEND,
    RECEIVE, 
    EXPECT
  );

  -- Constants for the maximum sizes to use in this VVC.
  -- You can create VVCs with smaller sizes than these constants, but not larger.
  
  -- Create constants for the maximum sizes to use in this VVC.
  --constant C_VVC_CMD_CHANNEL_MAX_WIDTH        : natural := 128;   -- From Avalon Interface Specifications, chapter 5.2
  constant C_VVC_CMD_DATA_MAX_WIDTH           : natural := 4096;  -- From Avalon Interface Specifications, chapter 5.2
  constant C_VVC_CMD_DATA_MAX_LENGTH          : natural := 8192;  -- Max number of entries in array, (max data entries sent between startofpacket - endofpacket)
  --constant C_VVC_CMD_ERROR_MAX_WIDTH          : natural := 256;   -- From Avalon Interface Specifications, chapter 5.2
  constant C_VVC_CMD_EMPTY_MAX_WIDTH          : natural := 5;     -- From Avalon Interface Specifications, chapter 5.2
  constant C_VVC_CMD_STRING_MAX_LENGTH        : natural := 1000;

  --========================================================================================================================
  -- t_vvc_cmd_record
  -- - Record type used for communication with the VVC
  --========================================================================================================================
  type t_vvc_cmd_record is record
    -- VVC dedicated fields
    data_array            : t_slv_array(0 to C_VVC_CMD_DATA_MAX_LENGTH-1)(C_VVC_CMD_DATA_MAX_WIDTH-1 downto 0); 
    data_array_length     : integer range 0 to C_VVC_CMD_DATA_MAX_LENGTH;
    empty                 : std_logic_vector(C_VVC_CMD_EMPTY_MAX_WIDTH-1 downto 0);
    -- Common VVC fields
    operation             : t_operation;
    proc_call             : string(1 to C_VVC_CMD_STRING_MAX_LENGTH);
    msg                   : string(1 to C_VVC_CMD_STRING_MAX_LENGTH);
    cmd_idx               : natural;
    command_type          : t_immediate_or_queued;
    msg_id                : t_msg_id;
    gen_integer_array     : t_integer_array(0 to 1); -- Increase array length if needed
    gen_boolean           : boolean; -- Generic boolean
    timeout               : time;
    alert_level           : t_alert_level;
    delay                 : time;
    quietness             : t_quietness;
  end record;

  constant C_VVC_CMD_DEFAULT : t_vvc_cmd_record := (
    data_array            => (others => (others => '0')),
    data_array_length     => 1,
    empty                 => (others => '0'),
    -- Common VVC fields
    operation             => NO_OPERATION,
    proc_call             => (others => NUL),
    msg                   => (others => NUL),
    cmd_idx               => 0,
    command_type          => NO_COMMAND_TYPE,
    msg_id                => NO_ID,
    gen_integer_array     => (others => -1),
    gen_boolean           => false,
    timeout               => 0 ns,
    alert_level           => FAILURE,
    delay                 => 0 ns,
    quietness             => NON_QUIET
  );

  --========================================================================================================================
  -- shared_vvc_cmd
  -- - Shared variable used for transmitting VVC commands
  --========================================================================================================================
  shared variable shared_vvc_cmd : t_vvc_cmd_record := C_VVC_CMD_DEFAULT;

  --========================================================================================================================
  -- t_vvc_result, t_vvc_result_queue_element, t_vvc_response and shared_vvc_response :
  -- 
  -- - Used for storing the result of a BFM procedure called by the VVC,
  --   so that the result can be transported from the VVC to for example a sequencer via
  --   fetch_result() as described in VVC_Framework_common_methods_QuickRef
  -- 
  -- - t_vvc_result includes the return value of the procedure in the BFM.
  --   It can also be defined as a record if multiple values shall be transported from the BFM
  --========================================================================================================================
  --subtype  t_vvc_result is std_logic_vector(C_VVC_CMD_DATA_MAX_LENGTH-1 downto 0);

  type t_vvc_result is record 
    data_array    : t_slv_array(0 to C_VVC_CMD_DATA_MAX_LENGTH-1)(C_VVC_CMD_DATA_MAX_WIDTH-1 downto 0);
    data_length   : natural;
    empty         : std_logic_vector(C_VVC_CMD_EMPTY_MAX_WIDTH-1 downto 0);
  end record;

  type t_vvc_result_queue_element is record
    cmd_idx       : natural;   -- from UVVM handshake mechanism
    result        : t_vvc_result;
  end record;

  type t_vvc_response is record
    fetch_is_accepted    : boolean;
    transaction_result   : t_transaction_result;
    result               : t_vvc_result;
  end record;

  shared variable shared_vvc_response : t_vvc_response;

  --========================================================================================================================
  -- t_last_received_cmd_idx : 
  -- - Used to store the last queued cmd in vvc interpreter.
  --========================================================================================================================
  type t_last_received_cmd_idx is array (t_channel range <>,natural range <>) of integer;

  --========================================================================================================================
  -- shared_vvc_last_received_cmd_idx
  --  - Shared variable used to get last queued index from vvc to sequencer
  --========================================================================================================================
  shared variable shared_vvc_last_received_cmd_idx : t_last_received_cmd_idx(t_channel'left to t_channel'right, 0 to C_MAX_VVC_INSTANCE_NUM) := (others => (others => -1));

  --===============================================================================================
  -- Procedures 
  --===============================================================================================
  function to_string(
    result : t_vvc_result 
  ) return string;  

end package vvc_cmd_pkg;


package body vvc_cmd_pkg is
-- Custom to_string overload needed when result is of a type that haven't got one already
  function to_string(
    result : t_vvc_result 
  ) return string is 
  begin
    return to_string(result.data_array'high) & " Bytes";
  end;

end package body vvc_cmd_pkg;

