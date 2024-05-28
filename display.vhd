library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity display is
    port(
        set_min, set_hour, clk_10hz : in std_logic;
        hour_in_1 : in std_logic_vector(3 downto 0);
        hour_in_0 : in std_logic_vector(3 downto 0);
        min_in_1 : in std_logic_vector(3 downto 0);
        min_in_0 : in std_logic_vector(3 downto 0);
        sec_in_1 : in std_logic_vector(3 downto 0);
        sec_in_0 : in std_logic_vector(6 downto 0);
        hour_out : out std_logic_vector(7 downto 0);
        min_out : out std_logic_vector(7 downto 0);
        sec_out : out std_logic_vector(10 downto 0)
    );
end entity;

architecture func of display is
    signal hour : std_logic_vector(7 downto 0);
    signal min : std_logic_vector(7 downto 0);
    signal sec : std_logic_vector(10 downto 0);
    signal state : std_logic_vector(1 downto 0);
    signal toggle : std_logic := '0';
begin
    process(set_min, set_hour, clk_10hz)
    begin
		state <= set_min & set_hour;
        if (clk_10hz'event and clk_10hz='1') then
            toggle <= not toggle;           

            case state is
                when "11" =>  -- set_min='1', set_hour='1', clk_10hz='1'
                    if hour = "11111111" then
                        hour <= hour_in_1 & hour_in_0;
                        min <= min_in_1 & min_in_0;
                        sec <= sec_in_1 & sec_in_0;
                    else
                        hour <= "11111111";
                        min <= "11111111";
                        sec <= "11110000000";
                    end if;
                when "01" =>  -- set_min='0', set_hour='1', clk_10hz='1'
                    if hour = "11111111" then
                        hour <= hour_in_1 & hour_in_0;
                        min <= min_in_1 & min_in_0;
                        sec <= sec_in_1 & sec_in_0;
                    else
                        hour <= "11111111";
                        min <= "11111111";
                        sec <= "11110000000";
                    end if;
                when "10" =>  -- set_min='1', set_hour='0', clk_10hz='1'
                    if hour = "11111111" then
                        hour <= hour_in_1 & hour_in_0;
                        min <= min_in_1 & min_in_0;
                        sec <= sec_in_1 & sec_in_0;
                    else
                        hour <= "11111111";
                        min <= "11111111";
                        sec <= "11110000000";
                    end if;
                when others =>  -- set_min='0', set_hour='0' or clk_10hz='0'
                    hour <= hour_in_1 & hour_in_0;
                    min <= min_in_1 & min_in_0;
                    sec <= sec_in_1 & sec_in_0;
            end case;
		end if;
		   
    end process;

    process(hour, min, sec)
    begin
            hour_out <= hour;
            min_out <= min;
            sec_out <= sec;
    end process;
end func;