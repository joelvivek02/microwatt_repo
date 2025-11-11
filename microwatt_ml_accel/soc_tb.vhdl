library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.wishbone_types.all;

entity soc_tb is
end entity soc_tb;

architecture tb of soc_tb is
    signal clk, rst : std_logic := '0';
    signal wb_ml_in  : wb_io_master_out := wb_io_master_out_init;
    signal wb_ml_out : wb_io_slave_out := wb_io_slave_out_init;
    signal irq_out   : std_logic;

    constant CLK_PERIOD : time := 10 ns;
begin
    -- Clock generation
    clk_process : process
    begin
        clk <= '0'; wait for CLK_PERIOD / 2;
        clk <= '1'; wait for CLK_PERIOD / 2;
    end process;

    -- Instantiate the SoC
    dut : entity work.soc
        port map (
            rst        => rst,
            system_clk => clk,
            wb_ml_in   => wb_ml_in,
            wb_ml_out  => wb_ml_out,
            irq_out    => irq_out
        );

    -- Stimulus process
    stim_proc : process
        variable result : integer := 0;
    begin
        report "Resetting system..." severity note;
        rst <= '1'; wait for 20 ns;
        rst <= '0'; wait for 20 ns;

        -- Write A, B, and C values
        report "Starting ML Accelerator Write Transaction" severity note;

        wb_ml_in.cyc <= '1';
        wb_ml_in.stb <= '1';
        wb_ml_in.we  <= '1';

        wb_ml_in.adr <= (others => '0');
        wb_ml_in.dat <= std_logic_vector(to_unsigned(3, 32)); wait for 10 ns;

        wb_ml_in.adr <= std_logic_vector(to_unsigned(1, 32));
        wb_ml_in.dat <= std_logic_vector(to_unsigned(4, 32)); wait for 10 ns;

        wb_ml_in.adr <= std_logic_vector(to_unsigned(2, 32));
        wb_ml_in.dat <= std_logic_vector(to_unsigned(2, 32)); wait for 10 ns;

        wb_ml_in.adr <= std_logic_vector(to_unsigned(3, 32));
        wb_ml_in.dat <= (others => '0'); wait for 10 ns;

        wb_ml_in.cyc <= '0';
        wb_ml_in.stb <= '0';
        wb_ml_in.we  <= '0';

        wait for 100 ns;

        -- Read result
        wb_ml_in.cyc <= '1';
        wb_ml_in.stb <= '1';
        wb_ml_in.we  <= '0';
        wb_ml_in.adr <= std_logic_vector(to_unsigned(3, 32));

        wait for 10 ns;

        report "Read complete" severity note;
        result := to_integer(unsigned(wb_ml_out.dat));
        report "Result from ML Accelerator (A*B+C): " & integer'image(result) severity note;

        wb_ml_in.cyc <= '0';
        wb_ml_in.stb <= '0';
        wait for 500 ns;

        report "Simulation finished." severity note;
        wait;
    end process;
end architecture tb;
