----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2023 11:54:56 AM
-- Design Name: 
-- Module Name: tb_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use ieee.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is
 constant c_CLK100MHZ_PERIOD : time  := 10 ns;
 signal CLK100MHZ    : std_logic := '0';
 uut_top : entity work.top
    port map (
        CLK100MHZ          => CLK100MHZ,
        CLK100MHZ : in STD_LOGIC;
        SW : in STD_LOGIC_VECTOR (15 downto 0);
        CA : out STD_LOGIC;
        CB : out STD_LOGIC;
        CC : out STD_LOGIC;
        CD : out STD_LOGIC;
         CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           LED16_G : out STD_LOGIC;
           LED16_R : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           BTNR : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNC : in STD_LOGIC
    );
begin
p_clk_gen : process is
  begin

    while now < 1600 ns loop            

      CLK100MHZ <= '0';
      wait for c_CLK100MHZ_PERIOD / 2;
      CLK100MHZ <= '1';
      wait for c_CLK100MHZ_PERIOD / 2;

    end loop;
    wait;                                  -- Process is suspended forever

  end process p_clk_gen;

end Behavioral;
