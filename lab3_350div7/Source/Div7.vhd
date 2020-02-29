Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity Div7 is
Generic ( N : natural := 6 );
Port ( x : in std_logic_vector( N-1 downto 0 );
	IsDivisible : out std_logic );
End Entity Div7;

-- Assume N = 18 for this design
Architecture structural of Div7 is
Begin

-- Insert your design here -------------------------------------------------------------------------------------

	
End Architecture structural;
