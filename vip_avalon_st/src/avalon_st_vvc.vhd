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

use work.avalon_st_bfm_pkg.all;
use work.vvc_cmd_pkg.all;

--========================================================================================================================
entity avalon_st_vvc is
   generic (
      --GC_CHANNEL_WIDTH                          : natural;
      GC_DATA_WIDTH                             : natural;
      --GC_ERROR_WIDTH                            : natural;
      GC_EMPTY_WIDTH                            : natural;
      GC_INSTANCE_IDX                           : natural;
      GC_AVALON_ST_BFM_CONFIG                   : t_avalon_st_bfm_config     := C_AVALON_ST_BFM_CONFIG_DEFAULT;
      GC_CMD_QUEUE_COUNT_MAX                    : natural                    := 1000;
      GC_CMD_QUEUE_COUNT_THRESHOLD              : natural                    := 950;
      GC_CMD_QUEUE_COUNT_THRESHOLD_SEVERITY     : t_alert_level              := WARNING;
      GC_RESULT_QUEUE_COUNT_MAX                 : natural                    := 1000;
      GC_RESULT_QUEUE_COUNT_THRESHOLD           : natural                    := 950;
      GC_RESULT_QUEUE_COUNT_THRESHOLD_SEVERITY  : t_alert_level              := WARNING
   );
   port (
      clk                        : in std_logic;
      --avalon_st_source_if        : inout t_avalon_st_source_if  := init_avalon_st_source_if_signals(GC_CHANNEL_WIDTH, GC_DATA_WIDTH, GC_ERROR_WIDTH, GC_EMPTY_WIDTH);
      --avalon_st_sink_if          : inout t_avalon_st_sink_if    := init_avalon_st_sink_if_signals(GC_CHANNEL_WIDTH, GC_DATA_WIDTH, GC_ERROR_WIDTH, GC_EMPTY_WIDTH)
      avalon_st_source_if        : inout t_avalon_st_source_if  := init_avalon_st_source_if_signals(GC_DATA_WIDTH, GC_EMPTY_WIDTH);
      avalon_st_sink_if          : inout t_avalon_st_sink_if    := init_avalon_st_sink_if_signals(GC_DATA_WIDTH, GC_EMPTY_WIDTH)
   );
end entity avalon_st_vvc;

--========================================================================================================================
--========================================================================================================================
architecture struct of avalon_st_vvc is

begin

   -- AVALON_ST SINK VVC
   i1_avalon_st_sink: entity work.avalon_st_sink_vvc
      generic map(
         --GC_CHANNEL_WIDTH                          => GC_CHANNEL_WIDTH,
         GC_DATA_WIDTH                             => GC_DATA_WIDTH,
         --GC_ERROR_WIDTH                            => GC_ERROR_WIDTH,
         GC_EMPTY_WIDTH                            => GC_EMPTY_WIDTH,
         GC_INSTANCE_IDX                           => GC_INSTANCE_IDX,
         GC_CHANNEL                                => RX,
         GC_AVALON_ST_BFM_CONFIG                   => GC_AVALON_ST_BFM_CONFIG,
         GC_CMD_QUEUE_COUNT_MAX                    => GC_CMD_QUEUE_COUNT_MAX,
         GC_CMD_QUEUE_COUNT_THRESHOLD              => GC_CMD_QUEUE_COUNT_THRESHOLD,
         GC_CMD_QUEUE_COUNT_THRESHOLD_SEVERITY     => GC_CMD_QUEUE_COUNT_THRESHOLD_SEVERITY
      )
      port map(
         clk                                 => clk,
         --avalon_st_sink_if.channel_i        => avalon_st_sink_if.channel_i,
         avalon_st_sink_if.data_i           => avalon_st_sink_if.data_i,
         --avalon_st_sink_if.error_i          => avalon_st_sink_if.error_i,
         avalon_st_sink_if.ready_o          => avalon_st_sink_if.ready_o,
         avalon_st_sink_if.valid_i          => avalon_st_sink_if.valid_i,
         avalon_st_sink_if.empty_i          => avalon_st_sink_if.empty_i,
         avalon_st_sink_if.endofpacket_i    => avalon_st_sink_if.endofpacket_i,
         avalon_st_sink_if.startofpacket_i  => avalon_st_sink_if.startofpacket_i
         --avalon_st_sink_if.check_data        => avalon_st_sink_if.check_data
      );


   -- AVALON_ST SOURCE VVC
   i1_avalon_st_source: entity work.avalon_st_source_vvc
      generic map(
         --GC_CHANNEL_WIDTH                          => GC_CHANNEL_WIDTH,
         GC_DATA_WIDTH                             => GC_DATA_WIDTH,
         --GC_ERROR_WIDTH                            => GC_ERROR_WIDTH,
         GC_EMPTY_WIDTH                            => GC_EMPTY_WIDTH,
         GC_INSTANCE_IDX                           => GC_INSTANCE_IDX,
         GC_CHANNEL                                => TX,
         GC_AVALON_ST_BFM_CONFIG                   => GC_AVALON_ST_BFM_CONFIG,
         GC_CMD_QUEUE_COUNT_MAX                    => GC_CMD_QUEUE_COUNT_MAX,
         GC_CMD_QUEUE_COUNT_THRESHOLD              => GC_CMD_QUEUE_COUNT_THRESHOLD,
         GC_CMD_QUEUE_COUNT_THRESHOLD_SEVERITY     => GC_CMD_QUEUE_COUNT_THRESHOLD_SEVERITY
      )
      port map(
         clk                                   => clk,
         --avalon_st_source_if.channel_o        => avalon_st_source_if.channel_o,
         avalon_st_source_if.data_o           => avalon_st_source_if.data_o,
         --avalon_st_source_if.error_o          => avalon_st_source_if.error_o,
         avalon_st_source_if.ready_i          => avalon_st_source_if.ready_i,
         avalon_st_source_if.valid_o          => avalon_st_source_if.valid_o,
         avalon_st_source_if.empty_o          => avalon_st_source_if.empty_o,
         avalon_st_source_if.endofpacket_o    => avalon_st_source_if.endofpacket_o,
         avalon_st_source_if.startofpacket_o  => avalon_st_source_if.startofpacket_o
      );


end struct;

