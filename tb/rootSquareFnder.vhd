LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY rootSquareFnder IS
END rootSquareFnder;
 
ARCHITECTURE behavior OF rootSquareFnder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT squareRootFind
    PORT(
         CLK : IN  std_logic;
         START : IN  std_logic;
         NUM : IN  std_logic_vector(15 downto 0);
         DONE : OUT  std_logic;
         SQR_ROOTED_NUM : OUT  std_logic_vector(8 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal START : std_logic := '0';
   signal NUM : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal DONE : std_logic;
   signal SQR_ROOTED_NUM : std_logic_vector(8 downto 0);

   constant CLK_period : time := 10 ns;
 
BEGIN
 
   uut: squareRootFind PORT MAP (
          CLK => CLK,
          START => START,
          NUM => NUM,
          DONE => DONE,
          SQR_ROOTED_NUM => SQR_ROOTED_NUM
        );

   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   stim_proc: process
   begin		
      wait for 100 ns;	

      wait for CLK_period*10;
		NUM <= x"00FA";
		START <= '1';
		wait for CLK_period;
		START <= '0';
		wait for 10 us;
		START <= '1';

      wait;
   end process;

END;
