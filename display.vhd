library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity display is
port(set_min,set_hour,clk:in std_logic;
	shine_out:out std_logic);
end entity;

architecture func of display is
	signal shine:std_logic;
begin
	process(set_min,set_hour,clk)
	begin
		if (set_min='1' or set_hour='1') then
			if (clk'event and clk='0') then
				if (shine='1') then
					shine<='0';
				else
					shine<='1';
				end if;
				shine_out<=shine;
			end if;
		elsif (set_min='0' and set_hour='0') then
			shine_out<='0';
		end if;
	end process;
end func;
