library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity squareRootFind is
    Generic(NUM_DPT        : INTEGER := 16);
    Port ( 	CLK            : in   STD_LOGIC;
	        START          : in   STD_LOGIC;
			NUM            : in   STD_LOGIC_VECTOR (NUM_DPT-1 downto 0);
			DONE           : out  STD_LOGIC;
			SQR_ROOTED_NUM : out  STD_LOGIC_VECTOR (NUM_DPT/2 downto 0));
end squareRootFind;

architecture Behavioral of squareRootFind is
-- PORT SIGNALS
signal sqrtNumQ      : STD_LOGIC_VECTOR(NUM_DPT/2 downto 0) := (others=>'0');
signal numQ          : STD_LOGIC_VECTOR(NUM_DPT-1 downto 0) := (others=>'0');
signal valQ          : STD_LOGIC_VECTOR(NUM_DPT-1 downto 0) := (others=>'0');
signal doneQ         : STD_LOGIC := '0';
-- INTERNAL SIGNALS
signal bitCntQ       : INTEGER RANGE 0 TO NUM_DPT-1 := 0;
signal processingQ   : STD_LOGIC := '0';
signal toggle        : STD_LOGIC := '0';

begin

DONE <= doneQ;

process(CLK)
begin
   if(rising_edge(CLK)) then
	   doneQ <= '0';
	   if(START = '1' and processingQ = '0') then
			numQ <= NUM;
			processingQ <= '1';
			sqrtNumQ <= (others=> '0');
			sqrtNumQ(NUM_DPT/2-1) <= '1';
			bitCntQ <= NUM_DPT/2-1;
		end if;
		if(processingQ = '1') then
		   if(toggle = '0')then
				valQ <= conv_std_logic_vector(conv_integer(sqrtNumQ)*conv_integer(sqrtNumQ), NUM_DPT);
				toggle <= '1';
			else
			   toggle <= '0';
			   if(valQ = numQ) then
					doneQ <= '1';
					processingQ <= '0';
					SQR_ROOTED_NUM <= sqrtNumQ;
				else
				   if(conv_integer(valQ) > conv_integer(numQ)) then
						sqrtNumQ(bitCntQ) <= '0';
						if(bitCntQ = 0) then
							doneQ <= '1';
							processingQ <= '0';
							SQR_ROOTED_NUM <= sqrtNumQ;
						else
						   bitCntQ <= bitCntQ - 1;
						   sqrtNumQ(bitCntQ - 1) <= '1';
						end if;
					else
						if(bitCntQ < 0) then
							doneQ <= '1';
							processingQ <= '0';
							SQR_ROOTED_NUM <= sqrtNumQ;
						else
							bitCntQ <= bitCntQ - 1;
							sqrtNumQ(bitCntQ) <= '1';
						end if;
					end if;
				end if;
			end if;
		end if;
	end if;
end process;

end Behavioral;

