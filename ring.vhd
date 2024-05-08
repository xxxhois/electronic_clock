library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ring is
port(min_ring1,hour_ring1:in std_logic;
	clk,clr:in std_logic;
	hour:in std_logic;
	qout:out std_logic);
end entity;
architecture func of ring is
signal temp:std_logic_vector(5 downto 0);
begin
	process(clr,clk,min_ring1,hour_ring1,hour)
	begin
		if(clr='1') then
			qout<='0';
			temp<="000000";
		elsif (clk'event and clk='1') then
			if (min_ring1='1' or hour='1') then
				temp<=temp+1;--ring 4s
				if (temp>4) then
					qout<='0';
				else
					qout<='1';
				end if;
				if (temp=59) then
					temp<="000000";
				else
					temp<=temp+1;
				end if;
			else 
				qout<='0';
				temp<="000000";
			end if;
		end if;
	end process;
end func;

