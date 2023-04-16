----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2023 11:51:57 AM
-- Design Name: 
-- Module Name: top - Behavioral
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



library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( CLK100MHZ : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (15 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           BTNC : in STD_LOGIC);
           
end top;



----------------------------------------------------------
-- Architecture body for top level
----------------------------------------------------------
architecture behavioral of top is
 signal clk_1sec : std_logic;
 signal sig_1sec : unsigned (3 downto 0);
 signal sig_10sec : unsigned (3 downto 0);
 signal sig_100sec : unsigned (3 downto 0);
 
 signal sig_1sec_vector : STD_LOGIC_VECTOR (3 downto 0);
 signal sig_10sec_vector : STD_LOGIC_VECTOR (3 downto 0);
 signal sig_100sec_vector : STD_LOGIC_VECTOR (3 downto 0);
 signal setup : STD_LOGIC; 

type t_state is (
    SETUP_STATE,
    SETUP_ROUND,
    SETUP_ROUND_TIME,
    SETUP_BRAKE_TIME,
    RUN
    );
    
signal sigstate: t_state; 

begin

  --------------------------------------------------------
  -- Instance (copy) of driver_7seg_4digits entity
  --------------------------------------------------------
  clk_en1 : entity work.clock_enable
    generic map (
      -- FOR SIMULATION, KEEP THIS VALUE TO 4
      -- FOR IMPLEMENTATION, CHANGE THIS VALUE TO 400,000
      -- 4      @ 4 ns
      -- 400000 @ 4 ms
      g_MAX => 100000000
    )
    port map (
      clk => CLK100MHZ,
      rst => BTNC,
      ce  => clk_1sec
    );
    
  driver_seg_4 : entity work.driver_7seg_4digits
      port map (
          clk      => CLK100MHZ,
          rst      => BTNC,
          data3(3) => '0',
          data3(2) => '0',
          data3(1) => '0',
          data3(0) => '0',
          
          data2(3) => sig_100sec_vector(3),
          data2(2) => sig_100sec_vector(2),
          data2(1) => sig_100sec_vector(1),
          data2(0) => sig_100sec_vector(0),
          
          data1(3) => sig_10sec_vector(3),
          data1(2) => sig_10sec_vector(2),
          data1(1) => sig_10sec_vector(1),
          data1(0) => sig_10sec_vector(0),
          -- MAP OTHER DATA INPUTS TO ON-BOARD SWITCHES 11:4 HERE


          data0(3) => sig_1sec_vector(3),
          data0(2) => sig_1sec_vector(2),
          data0(1) => sig_1sec_vector(1),
          data0(0) => sig_1sec_vector(0),

          seg(6) => CA,
          seg(5) => CB,
          seg(4) => CC,
          seg(3) => CD,
          seg(2) => CE,
          seg(1) => CF,
          seg(0) => CG,
          
          -- MAP DISPLAY SEGMENTS B:G HERE


          -- DECIMAL POINT
          dp_vect => "0111",
          dp      => DP,

          -- DIGITS
          dig(3 downto 0) => AN(3 downto 0)
      );

  timer : process (clk_1sec) is

 
  begin
  
  if (BTNC = '1') then
    sigstate <= SETUP_STATE;
    
        sig_1sec <= "0010";
         sig_10sec <= "0010";
         sig_100sec <= "0011";
  end if;
  
  case sigstate is
  
  when SETUP_STATE =>
  when SETUP_ROUND => 
  when SETUP_ROUND_TIME =>
  when SETUP_BRAKE_TIME =>
  when RUN =>
   
  
  
  end case;
  
  
       if (rising_edge(clk_1sec)) then
        sig_1sec <= sig_1sec - 1;
           if(sig_1sec < "0001") then
            sig_1sec <= "1001";
             sig_10sec <= sig_10sec - 1;
              if(sig_10sec < "0001") then
                sig_10sec <= "1001";
                sig_100sec <= sig_100sec - 1;
                  if(sig_100sec < "0001") then
                   sig_100sec <= "1001";
                  end if;     
              end if;     
           end if;         

       end if; 
  end process timer;
  -- Disconnect the top four digits of the 7-segment display
  AN(7 downto 4) <= b"1111";

  sig_1sec_vector <= std_logic_vector(sig_1sec);
  sig_10sec_vector <= std_logic_vector(sig_10sec);
  sig_100sec_vector <= std_logic_vector(sig_100sec);
end architecture behavioral;