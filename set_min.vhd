library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity set_min is
port(set,clr,qd:in std_logic;
	qout0,qout1:out std_logic_vector(3 downto 0));
end entity;

architecture func of set_min is
	signal set1,set0:std_logic_vector(3 downto 0);--represent set mode qout1 qout0
begin
	process(clr,qd,set)
	begin
		if (clr='1') then
		set1<="0000";
		set0<="0000";
		qout1<=set1;
		qout0<=set0;
		elsif (set='1') then
			if (qd'event and qd='0') then
				if (set0=9 and set1=5) then
					set0<="0000";
					set1<="0000";
				elsif (set0=9) then
					set0<="0000";
					set1<=set1+1;
				else
					set0<=set0+1;
				end if;
			end if;
			qout1<=set1;
			qout0<=set0;
		end if;
	end process;
end func;
