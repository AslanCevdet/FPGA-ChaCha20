library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.mypkg_2.all;

entity QR_test_tb is
end QR_test_tb;

architecture Behavioral of QR_test_tb is
  component top
  port(
    in_a :in std_logic_vector(31 downto 0);
    in_b :in std_logic_vector(31 downto 0);
    in_c :in std_logic_vector(31 downto 0);
    in_d :in std_logic_vector(31 downto 0);
	 
    out_a: out std_logic_vector(31 downto 0);
    out_b: out std_logic_vector(31 downto 0);
    out_c: out std_logic_vector(31 downto 0);
    out_d: out std_logic_vector(31 downto 0)
  );
  end component;
  
  -- Define the test inputs
  signal test_in_a : std_logic_vector(31 downto 0) := x"11111111";
  signal test_in_b : std_logic_vector(31 downto 0) := x"01020304";
  signal test_in_c : std_logic_vector(31 downto 0) := x"9b8d6f43";
  signal test_in_d : std_logic_vector(31 downto 0) := x"01234567";
  
  -- Define the test outputs
  signal test_out_a : std_logic_vector(31 downto 0);
  signal test_out_b : std_logic_vector(31 downto 0);
  signal test_out_c : std_logic_vector(31 downto 0);
  signal test_out_d : std_logic_vector(31 downto 0);
  
begin
  -- Instantiate the unit under test (UUT)
  UUT: top port map(
    in_a => test_in_a,
    in_b => test_in_b,
    in_c => test_in_c,
    in_d => test_in_d,
	
    out_a => test_out_a,
    out_b => test_out_b,
    out_c => test_out_c,
    out_d => test_out_d
  );

  -- Stimulus process
  stim_proc: process
  begin
    wait for 100 ns;
    -- Here, you can provide additional stimulus
    -- For example, you might change the input signals and then
    -- wait another period of time to see how the outputs change.
    wait;
  end process stim_proc;
  
end Behavioral;
