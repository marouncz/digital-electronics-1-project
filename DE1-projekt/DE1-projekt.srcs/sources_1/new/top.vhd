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
           BTNR : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNC : in STD_LOGIC);
           
end top;



----------------------------------------------------------
-- Architecture body for top level
----------------------------------------------------------
architecture behavioral of top is
 signal clk_1sec : std_logic;
 signal clk_100mil : std_logic;
 signal sig_1sec : unsigned (3 downto 0) := (others => '0');
 signal sig_10sec : unsigned (3 downto 0) := (others => '0');
 signal sig_100sec : unsigned (3 downto 0) := (others => '0');
  signal sig_1round : unsigned (3 downto 0) := (others => '0');
 signal sig_10round : unsigned (3 downto 0) := (others => '0');
 signal sig_seconds : integer := 0;
 signal sig_seconds_set : integer := 0;
 signal sig_round : integer := 0;
 signal sig_round_time : integer := 0;
 signal sig_break_time : integer := 0;
 signal sig_state_vector : STD_LOGIC_VECTOR (3 downto 0);
 
 signal sig_1sec_vector : STD_LOGIC_VECTOR (3 downto 0);
 signal sig_10sec_vector : STD_LOGIC_VECTOR (3 downto 0);
 signal sig_100sec_vector : STD_LOGIC_VECTOR (3 downto 0);
 
 signal sig_1round_vector : STD_LOGIC_VECTOR (3 downto 0);
 signal sig_10round_vector : STD_LOGIC_VECTOR (3 downto 0);
 signal setup : STD_LOGIC; 
 

type t_state is (
    SETUP_ROUND,
    SETUP_ROUND_TIME,
    SETUP_BRAKE_TIME,
    RUN_BREAK,
    RUN_ROUND
    );
    
signal sigstate: t_state := SETUP_ROUND; 

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
      rst => BTNR,
      ce  => clk_1sec
    );
    clk_en2 : entity work.clock_enable
    generic map (
      g_MAX => 10000000
    )
    port map (
      clk => CLK100MHZ,
      rst => BTNR,
      ce  => clk_100mil
    );
    
  driver_seg_4 : entity work.driver_7seg_4digits
      port map (
          clk      => CLK100MHZ,
          rst      => BTNR,
          

          
          data6(3) => sig_10sec_vector(3),
          data6(2) => sig_10sec_vector(2),
          data6(1) => sig_10sec_vector(1),
          data6(0) => sig_10sec_vector(0),
          
          data5(3) => sig_1sec_vector(3),
          data5(2) => sig_1sec_vector(2),
          data5(1) => sig_1sec_vector(1),
          data5(0) => sig_1sec_vector(0),
         
          
          data4 => "1111",
          data3 => "1111",
           
          data7(3) => sig_state_vector(3),
          data7(2) => sig_state_vector(2),
          data7(1) => sig_state_vector(1),
          data7(0) => sig_state_vector(0),
           
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
          dp_vect => "11111111",
          dp      => DP,

          -- DIGITS
          dig(7 downto 0) => AN(7 downto 0)
      );
      
  timer : process (clk_1sec) is

 
  begin


  if (rising_edge(clk_1sec)) then
   case sigstate is
  
  when SETUP_ROUND => 

  sig_state_vector <= "1110";
  if (BTNC = '1') then
         sigstate <= SETUP_ROUND_TIME;
         sig_round <= sig_seconds_set;
  end if;
  
  when SETUP_ROUND_TIME =>
    sig_state_vector <= "1011";
    if (BTNC = '1') then
         sigstate <= SETUP_BRAKE_TIME;
         sig_round_time <= sig_seconds_set;
  end if;
  when SETUP_BRAKE_TIME =>
  sig_state_vector <= "1010";
    if (BTNC = '1') then
         sigstate <= RUN_ROUND;
          sig_break_time <= sig_seconds_set;
          sig_state_vector <= "1011";
         -- sig_seconds <= sig_round_time;
  end if;
  when RUN_ROUND =>
    sig_seconds <= sig_seconds -1;
    if sig_seconds = 0 then
    if(sig_round=0) then
        sigstate <= SETUP_ROUND; 
    else
         sigstate <= RUN_BREAK;
         sig_seconds <= sig_break_time;
         sig_state_vector <= "1010";
    end if;     
    end if;
  when RUN_BREAK => 
   sig_seconds <= sig_seconds -1;
    if sig_seconds = 0 then
        sigstate <= RUN_ROUND;
        sig_seconds <= sig_round_time;
        sig_round <= sig_round - 1;
        sig_state_vector <= "1011";
    end if;

 end case;

       end if; 
  end process timer;
  button_timer : process (clk_100mil) is
  begin
  if (rising_edge(clk_100mil)) then
     if (BTNU = '1') then
         sig_seconds_set <= sig_seconds_set +1;
    end if;
    if (BTND = '1' and sig_seconds_set>0) then
         sig_seconds_set <= sig_seconds_set -1;
    end if;
   
  end if;  
  end process button_timer;
  -- Disconnect the top four digits of the 7-segment display

  
  sig_1sec_vector <= std_logic_vector(to_unsigned((sig_seconds_set mod 10), sig_1sec_vector'length)) when sigstate = SETUP_ROUND_TIME else
                     std_logic_vector(to_unsigned((sig_seconds_set mod 10), sig_1sec_vector'length)) when sigstate = SETUP_BRAKE_TIME else
                     std_logic_vector(to_unsigned((sig_seconds mod 10), sig_1sec_vector'length));
    
   sig_10sec_vector <= std_logic_vector(to_unsigned((sig_seconds_set - (sig_seconds_set mod 10) - (sig_seconds_set - (sig_seconds_set mod 100)))/10, sig_10sec_vector'length)) when sigstate = SETUP_ROUND_TIME else
                      std_logic_vector(to_unsigned((sig_seconds_set - (sig_seconds_set mod 10) - (sig_seconds_set - (sig_seconds_set mod 100)))/10, sig_10sec_vector'length)) when sigstate = SETUP_BRAKE_TIME else
          
                      std_logic_vector(to_unsigned((sig_seconds - (sig_seconds mod 10) - (sig_seconds - (sig_seconds mod 100)))/10, sig_10sec_vector'length));    
                      
   sig_100sec_vector <= std_logic_vector(to_unsigned((sig_seconds_set - (sig_seconds_set mod 100))/100, sig_100sec_vector'length)) when sigstate = SETUP_ROUND_TIME else
                        std_logic_vector(to_unsigned((sig_seconds_set - (sig_seconds_set mod 100))/100, sig_100sec_vector'length)) when sigstate = SETUP_BRAKE_TIME else
                        std_logic_vector(to_unsigned((sig_seconds - (sig_seconds mod 100))/100, sig_100sec_vector'length));                                   
  
  sig_1round_vector <= std_logic_vector(to_unsigned((sig_seconds_set mod 10), sig_1sec_vector'length)) when sigstate = SETUP_BRAKE_TIME else
                       std_logic_vector(to_unsigned((sig_round mod 10), sig_1sec_vector'length));
                     
 sig_10round_vector <= std_logic_vector(to_unsigned((sig_seconds_set - (sig_seconds_set mod 10) - (sig_seconds_set - (sig_seconds_set mod 100)))/10, sig_10sec_vector'length)) when sigstate = SETUP_ROUND else
                       std_logic_vector(to_unsigned((sig_round - (sig_round mod 10) - (sig_round - (sig_round mod 100)))/10, sig_10sec_vector'length)); 
   
end architecture behavioral;
