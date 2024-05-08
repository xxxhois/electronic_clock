library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity hour is
port(clk,clr,clk_s:in std_logic;
	set:in std_logic;
	pb:in std_logic;
	alarm:in std_logic;
	hour_ring:out std_logic;
	qin1,qin0:in std_logic_vector(3 downto 0);
	qout1,qout0:out std_logic_vector(3 downto 0));
end entity;

architecture func of hour is
	signal cnt1,cnt0:std_logic_vector(3 downto 0);--represent normal mode qout1 qout0 
	signal temp2:std_logic;
begin
	process(clk,set,clr,pb,alarm,clk_s)
	begin
		if (clr='1') then
			cnt0<="0000";
			cnt1<="0000";
			temp2<='0';
		elsif (set='1' and clr='0' and alarm='0') then
			cnt0<=qin0;
			cnt1<=qin1;
		elsif (clk'event and clk='1') then
			if ((set='0' and clr='0' and pb='0') or (set='1' and clr='0' and alarm='1' and pb='0')) then --normal count mode
				if (cnt0=3 and cnt1=2) then
					cnt0<="0000";
					cnt1<="0000";
				elsif (cnt0=9) then
					 cnt0<="0000";
					 cnt1<=cnt1+1;
				else
					cnt0<=cnt0+1;
				end if;
			end if;
		end if;
		if (set='1' and alarm='1') then
				qout1<=qin1;
				qout0<=qin0;
		else
			qout1<=cnt1;
			qout0<=cnt0;
		end if;
		if (alarm='1' and set='0') then
			if (cnt1=qin1 and cnt0=qin0) then
				temp2<='1';
			else
				temp2<='0';
			end if;
		end if;
		hour_ring<=temp2;
	end process;
end func;

