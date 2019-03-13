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


-- Test harness entity
entity th_avalon_st_vvc is
   generic (
         --CHANNEL_WIDTH     : natural := 1;
         DATA_WIDTH        : natural := 20;
         --ERROR_WIDTH       : natural := 1;
         EMPTY_WIDTH       : natural := 2
      );
end entity;

-- Test harness architecture
architecture struct of th_avalon_st_vvc is
   -- DSP interface and general control signals
   signal clk_i               : std_logic := '0';
   signal sreset_i            : std_logic := '0';

   -- Sink
   --signal channel_i           : std_logic_vector(CHANNEL_WIDTH - 1 downto 0);
   signal data_i              : std_logic_vector(DATA_WIDTH - 1 downto 0);
   --signal error_i             : std_logic_vector(ERROR_WIDTH - 1 downto 0);
   signal ready_o             : std_logic;
   signal valid_i             : std_logic := '0';
   signal empty_i             : std_logic_vector(EMPTY_WIDTH - 1 downto 0);
   signal endofpacket_i       : std_logic := '0';
   signal startofpacket_i     : std_logic := '0';
   
   
   -- Source
   --signal channel_o           : std_logic_vector(CHANNEL_WIDTH - 1 downto 0);
   signal data_o              : std_logic_vector(DATA_WIDTH - 1 downto 0);
   --signal error_o             : std_logic_vector(ERROR_WIDTH - 1 downto 0);
   signal ready_i             : std_logic := '0';
   signal valid_o             : std_logic;
   signal empty_o             : std_logic_vector(EMPTY_WIDTH - 1 downto 0);
   signal endofpacket_o       : std_logic;
   signal startofpacket_o     : std_logic;
   

   constant C_CLK_PERIOD : time := 10 ns; -- 100 MHz
begin
   -----------------------------------------------------------------------------
   -- Instantiate the concurrent procedure that initializes UVVM
   -----------------------------------------------------------------------------
   i_ti_uvvm_engine : entity uvvm_vvc_framework.ti_uvvm_engine;

   -----------------------------------------------------------------------------
   -- AVALON ST VVC
   -----------------------------------------------------------------------------
   i1_avalon_st_vvc: entity vip_avalon_st.avalon_st_vvc
   generic map(
      --GC_CHANNEL_WIDTH  => CHANNEL_WIDTH,
      GC_DATA_WIDTH     => DATA_WIDTH,
      --GC_ERROR_WIDTH    => ERROR_WIDTH,
      GC_EMPTY_WIDTH    => EMPTY_WIDTH,
      GC_INSTANCE_IDX   => 1
   )
   port map(
      clk   => clk_i,
      -- Sink
      --avalon_st_sink_if.channel_i            => channel_i,
      avalon_st_sink_if.data_i               => data_i,
      --avalon_st_sink_if.error_i              => error_i,
      avalon_st_sink_if.ready_o              => ready_o,
      avalon_st_sink_if.valid_i              => valid_i,
      avalon_st_sink_if.empty_i              => empty_i,
      avalon_st_sink_if.endofpacket_i        => endofpacket_i,
      avalon_st_sink_if.startofpacket_i      => startofpacket_i,
      -- Source
      --avalon_st_source_if.channel_o          => channel_o,
      avalon_st_source_if.data_o             => data_o,
      --avalon_st_source_if.error_o            => error_o,
      avalon_st_source_if.ready_i            => ready_i,
      avalon_st_source_if.valid_o            => valid_o,
      avalon_st_source_if.empty_o            => empty_o,
      avalon_st_source_if.endofpacket_o      => endofpacket_o,
      avalon_st_source_if.startofpacket_o    => startofpacket_o
   );


   -----------------------------------------------------------------------------
   -- Reset process
   -----------------------------------------------------------------------------  
   -- Toggle the reset after 5 clock periods
   p_sreset: sreset_i <= '1', '0' after 5 *C_CLK_PERIOD;

   -----------------------------------------------------------------------------
   -- Clock process
   -----------------------------------------------------------------------------  
   p_clk: process
   begin
      clk_i <= '0', '1' after C_CLK_PERIOD / 2;
      wait for C_CLK_PERIOD;
   end process;

   p_ready: process
   begin
      ready_i <= '0';
      for i in 0 to 5 loop
         wait until rising_edge(clk_i);
      end loop;
      ready_i <= '1';
      for i in 0 to 5 loop
         wait until rising_edge(clk_i);
      end loop;
   end process;

end struct;
