library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ml_accelerator is
    generic (
        DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 8
    );
    port (
        clk   : in std_logic;
        rst   : in std_logic;
        wb_in  : in wb_io_master_out;
        wb_out : out wb_io_slave_out;
        irq    : out std_logic
    );
end entity ml_accelerator;

architecture rtl of ml_accelerator is
    signal opA, opB, opC, result : unsigned(DATA_WIDTH-1 downto 0) := (others => '0');
    signal busy, done : std_logic := '0';
    signal reg_addr   : unsigned(ADDR_WIDTH-1 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                opA <= (others => '0');
                opB <= (others => '0');
                opC <= (others => '0');
                result <= (others => '0');
                wb_out.ack <= '0';
                wb_out.stall <= '0';
                wb_out.dat <= (others => '0');
                irq <= '0';
                busy <= '0';
                done <= '0';
            else
                wb_out.ack <= '0';
                irq <= '0';

                -- Handle Wishbone write/read
                if wb_in.cyc = '1' and wb_in.stb = '1' then
                    wb_out.ack <= '1';
                    reg_addr <= unsigned(wb_in.adr(ADDR_WIDTH-1 downto 0));

                    if wb_in.we = '1' then
                        case to_integer(reg_addr(3 downto 0)) is
                            when 0 => opA <= unsigned(wb_in.dat);
                            when 1 => opB <= unsigned(wb_in.dat);
                            when 2 => opC <= unsigned(wb_in.dat);
                            when 3 =>
                                -- Start computation
                                result <= (opA * opB) + opC;
                                done <= '1';
                                irq <= '1';
                            when others => null;
                        end case;
                    else
                        case to_integer(reg_addr(3 downto 0)) is
                            when 0 => wb_out.dat <= std_logic_vector(opA);
                            when 1 => wb_out.dat <= std_logic_vector(opB);
                            when 2 => wb_out.dat <= std_logic_vector(opC);
                            when 3 => wb_out.dat <= std_logic_vector(result);
                            when others => wb_out.dat <= (others => '0');
                        end case;
                    end if;
                end if;
            end if;
        end if;
    end process;
end architecture rtl;
