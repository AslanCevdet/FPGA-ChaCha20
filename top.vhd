library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.mypkg_2.all;

entity top is

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

end top;

architecture Behavioral of top is

  signal a, b, c, d : std_logic_vector(31 downto 0);
  
  signal result : QuarterRoundOutput;
  
  signal Qff_test_out : ResultMatrix;
  
  signal chacha_test_state : StateMatrix := (
    x"879531e0", x"c5ecf37d", x"516461b1", x"c9a62f8a",
    x"44c20ef3", x"3390af7f", x"d9fc690b", x"2a5f714c",
    x"53372767", x"b00a5631", x"974c541a", x"359e9963",
    x"5c971061", x"3d631689", x"2098d9d6", x"91dbd320"
  
  );
  
  
  
  
begin

	Qff_test_out <= QRound_FF(chacha_test_state, 2, 7, 8, 13);

	a <= in_a;
	b <= in_b;
	c <= in_c;
	d <= in_d;

  result <= QuarterRound(a, b, c, d);
  
  out_a <= result.a_out;
  out_b <= result.b_out;
  out_c <= result.c_out;
  out_d <= result.d_out;
  
  
end Behavioral;