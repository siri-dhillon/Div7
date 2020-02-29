Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity FullAdder is
Port ( A, B, C : in std_logic;
	S1, S0 : out std_logic );
End Entity FullAdder;

Architecture rtl of FullAdder is
	Signal G, P : std_logic;
Begin
	G <= A and B after 1 ns;
	P <= A xor B after 1 ns;
	S0 <= P xor C after 1 ns;
	S1 <= G or (P and C) after 1 ns;
End Architecture rtl;