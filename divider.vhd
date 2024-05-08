library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity divider is
port(clk_1k:in std_logic; --1kHz signal
	clk:out std_logic); --1Hz signal
end entity;

architecture func of divider is
signal count:integer range 0 to 999;
begin
	process(clk_1k)
	begin
		if (clk_1k'event and clk_1k='0') then
			if count=999 then
				count<=0;
			else
				count<=count+1;
			end if;
			if (count<500) then
				clk<='0';
			else
				clk<='1';
			end if;
		end if;
	end process;
end func;
