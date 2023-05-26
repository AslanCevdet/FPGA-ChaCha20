library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Works
package QuarterRoundPkg is

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
  
  
end QuarterRoundPkg;




package body QuarterRoundPkg is

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
  
 ----------- -----------  -----------  -----------  ----------- 
 function QUARTERROUND_FF(x, y, z, w: integer; state: std_logic_vector(15 downto 0)(31 downto 0)) return std_logic_vector(15 downto 0)(31 downto 0) is
  variable newState : std_logic_vector(15 downto 0)(31 downto 0);
begin
  newState := state; -- make a copy of the original state
  newState(x) := QuarterRound(state(x), state(y), state(z), state(w));
  return newState;
end QUARTERROUND_FF;
 -----------  -----------  -----------  ----------- 

procedure Qround(
  signal state: inout std_logic_vector(15 downto 0)(31 downto 0);
  idx1: integer; idx2: integer; idx3: integer; idx4: integer
) is
  variable qr_result : std_logic_vector(31 downto 0);
begin
  qr_result := QuarterRound(state(idx1), state(idx2), state(idx3), state(idx4));
  state(idx1) := qr_result;
end Qround;
  
  -----------  -----------  -----------  -----------


  
  
end QuarterRoundPkg;