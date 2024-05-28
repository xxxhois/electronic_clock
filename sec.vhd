library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sec is
port(clk,clr:in std_logic;
	pb:in std_logic;
	qout1,qout0:out std_logic_vector(3 downto 0);
	cout:out std_logic);
end entity;

architecture func of sec is
	signal cnt1,cnt0:std_logic_vector(3 downto 0);
	signal carry0:std_logic;
begin
	process(clk,clr,pb)
	begin
		if (clr='1') then 
			cnt0<="0000";
			cnt1<="0000";
		elsif (clk'event and clk='0') then
			if (clr='0' and pb='0') then 
				if (cnt0=9) then
					cnt0<="0000";
					if (cnt1=5) then
						cnt1<="0000";
						carry0<='1'; 
					else 
						cnt1<=cnt1+1; --shi wei ++
						carry0<='0';
					end if;
				else
					cnt0<=cnt0+1; --ge wei ++
					carry0<='0'; 
				end if;
			end if;
		end if;
	qout0<=cnt0;
	qout1<=cnt1;
	cout<=carry0;
	end process;
end func;
