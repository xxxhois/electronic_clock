library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity display is
port(set_min,set_hour,clk_10hz:in std_logic;
	 hour_in: in std_logic_vector(7 downto 0);
	 min_in: in std_logic_vector(7 downto 0);
	 sec_in: in std_logic_vector(10 downto 0);
	 hour_out: out std_logic_vector(7 downto 0);
	 min_out: out std_logic_vector(7 downto 0);
	 sec_out: out std_logic_vector(10 downto 0)
	 );
end entity;

architecture func of display is
	--signal shine:std_logic;
	variable hour: std_logic_vector(7 downto 0);
	variable min: std_logic_vector(7 downto 0);
	variable sec: std_logic_vector(10 downto 0);
begin
	process(set_min,set_hour,clk_10hz,)
	begin
		hour:=hour_in;
		min:=min_in;
		sec:=sec_in;
		if (set_min='1' or set_hour='1') then
			if (clk_10hz'event and clk_10hz='0') then
				hour<="00000000";
				min<="00000000";
				sec<="00000000000";
			elsif (clk_10hz'event and clk_10hz='1') then
				hour<=hour;
				min<=min;
				sec<=sec;
			end if;
		elsif (set_min='0' and set_hour='0') then
			hour<=hour;
			min<=min;
			sec<=sec;
		end if;
	end process;
	hour_out<=hour;
	min_out<=min;
	sec_out<=sec;
end func;
