library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.wishbone_types.all;

entity soc is
    generic (
        MEMORY_SIZE : natural := 1024;
        RAM_INIT_FILE : string := "";
        CLK_FREQ : positive := 100_000_000;
        SIM : boolean := true
    );
    port (
        rst        : in  std_logic;
        system_clk : in  std_logic;

        -- ML Accelerator interface (simulation only)
        wb_ml_in  : in  wb_io_master_out;
        wb_ml_out : out wb_io_slave_out;
        irq_out   : out std_logic
    );
end entity soc;

architecture behaviour of soc is
    signal accel_rst : std_logic;
    signal accel_irq : std_logic;
begin
    accel_rst <= rst;

    ml_accel_inst : entity work.ml_accelerator
        port map (
            clk   => system_clk,
            rst   => accel_rst,
            wb_in  => wb_ml_in,
            wb_out => wb_ml_out,
            irq    => accel_irq
        );

    irq_out <= accel_irq;
end architecture behaviour;
