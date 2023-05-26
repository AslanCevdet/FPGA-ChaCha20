library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



-- Works


package mypkg_2 is

	type StateMatrix is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
	type ResultMatrix is array (0 to 3) of STD_LOGIC_VECTOR(31 downto 0);
	

  type QuarterRoundOutput is record
    a_out : std_logic_vector(31 downto 0);
    b_out : std_logic_vector(31 downto 0);
    c_out : std_logic_vector(31 downto 0);
    d_out : std_logic_vector(31 downto 0);
  end record;

  function QuarterRound (
    a : std_logic_vector(31 downto 0);
    b : std_logic_vector(31 downto 0);
    c : std_logic_vector(31 downto 0);
    d : std_logic_vector(31 downto 0)
  ) return QuarterRoundOutput;
  
  
  function EndianSwap (
    input : std_logic_vector(31 downto 0)
  ) return std_logic_vector;
  
  
  function QRound_FF (
	chacha_state : StateMatrix;
	x : integer  ;
	y : integer  ;
	z : integer  ;
	w : integer 
) return ResultMatrix;
  
  
  
  
end mypkg_2;




package body mypkg_2 is

-- Quarter round function
  function QuarterRound (
    a : std_logic_vector(31 downto 0);
    b : std_logic_vector(31 downto 0);
    c : std_logic_vector(31 downto 0);
    d : std_logic_vector(31 downto 0)
  ) return QuarterRoundOutput is
  
    variable result : QuarterRoundOutput;
    variable temp_a, temp_b, temp_c, temp_d : unsigned(31 downto 0);
	
  begin
    temp_a := unsigned(a); temp_b := unsigned(b);
    temp_c := unsigned(c); temp_d := unsigned(d);

    temp_a := temp_a + temp_b; temp_d := temp_d xor temp_a; temp_d := rotate_left(temp_d, 16);
    temp_c := temp_c + temp_d; temp_b := temp_b xor temp_c; temp_b := rotate_left(temp_b, 12);
    temp_a := temp_a + temp_b; temp_d := temp_d xor temp_a; temp_d := rotate_left(temp_d, 8);
    temp_c := temp_c + temp_d; temp_b := temp_b xor temp_c; temp_b := rotate_left(temp_b, 7);

    result.a_out := std_logic_vector(temp_a);
    result.b_out := std_logic_vector(temp_b);
    result.c_out := std_logic_vector(temp_c);
    result.d_out := std_logic_vector(temp_d);

    return result;
  end QuarterRound;
  
-- Little endian to big endian swap function (not tested yet)
  
  function EndianSwap (
    input : std_logic_vector(31 downto 0)
  ) return std_logic_vector is
  
    variable output : std_logic_vector(31 downto 0);
  begin
    output(31 downto 24) := input(7 downto 0);
    output(23 downto 16) := input(15 downto 8);
    output(15 downto 8) := input(23 downto 16);
    output(7 downto 0) := input(31 downto 24);
    return output;
  end EndianSwap;
  
 -----------------

 
function QRound_FF (
	chacha_state : StateMatrix;
	x : integer  ;
	y : integer  ;
	z : integer  ;
	w : integer 
) return ResultMatrix is

	variable output : ResultMatrix;
	variable q_round_out : QuarterRoundOutput; 

	begin
	
	q_round_out := QuarterRound(chacha_state(x), chacha_state(y), chacha_state(z), chacha_state(w));
	
	output(0) := q_round_out.a_out;
	output(1) := q_round_out.b_out;
	output(2) := q_round_out.c_out;
	output(3) := q_round_out.d_out;
	
	return output;
	
	end QRound_FF;
  

  
end mypkg_2;



