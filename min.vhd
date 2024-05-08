library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity min is
port(clk,clr,clk_s:in std_logic;
	set:in std_logic;
	pb:in std_logic;--pause begin signal
	alarm:in std_logic;
	min_ring:out std_logic;
	qin1,qin0:in std_logic_vector(3 downto 0);
	qout1,qout0:out std_logic_vector(3 downto 0);
	cout:out std_logic);
end entity;

architecture func of min is
	signal cnt1,cnt0:std_logic_vector(3 downto 0);--represent normal mode qout1 qout0 
	signal carry0:std_logic;--carry1 represent set mode cout , carry0 represent normal mode cout 
	signal temp1:std_logic;--
begin
	process(clk,set,clr,pb,alarm,clk_s)
	begin
		if (clr='1') then
			cnt0<="0000";
			cnt1<="0000";
			temp1<='0';
		elsif (set='1' and clr='0' and alarm='0') then
			cnt0<=qin0;
			cnt1<=qin1;
			carry0<='0';
		elsif (clk'event and clk='1') then
			if ((set='0' and clr='0' and pb='0') or (set='1' and clr='0' and alarm='1' and pb='0')) then --normal count mode
				if (cnt0=9) then
					cnt0<="0000";
					if (cnt1=5) then
						cnt1<="0000";
						carry0<='1'; --give higher clock3
					else 
						cnt1<=cnt1+1;
						carry0<='0';
					end if;
				else
					cnt0<=cnt0+1;
					carry0<='0';
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
			if(cnt0=qin0 and cnt1=qin1) then
				temp1<='1';
			else
				temp1<='0';
			end if;
		end if;
		cout<=carry0;
		min_ring<=temp1;
	end process;
end func;
