library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity lights is
port(led:in std_logic_vector(3 downto 0);
	light:out std_logic_vector(6 downto 0));
end lights;

architecture func of lights is
begin
	process(led)
	begin
		case led is
			when "0000" =>light<="0111111";
			when "0001" =>light<="0000110";
			when "0010" =>light<="1011011";
			when "0011" =>light<="1001111";
			when "0100" =>light<="1100110";
			when "0101" =>light<="1101101";
			when "0110" =>light<="1111101";
			when "0111" =>light<="0000111";
			when "1000" =>light<="1111111";
			when "1001" =>light<="1101111";
			when others =>light<="0000000";--other situations:don't shine
		end case;
	end process;
end func;
