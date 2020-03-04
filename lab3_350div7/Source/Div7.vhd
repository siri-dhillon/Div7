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

-- level 0 outputs
	signal SA1_B0,SA2_G0,SA3_B2,SA4_B0,SA5_B1,SA6_B2 : std_logic;
	signal CA1_B1,CA2_G1,CA3_G2,CA4_B1,CA5_B2,CA6_G2 : std_logic;
-- level 1 outputs
	signal SB0_,SB1_G0,SB2_G1,: std_logic;
	signal CB0_G0,CB1_G1,CB2_G2 : std_logic;
-- level 2 outputs
	signal SB0_,SB1_G0,SB2_G1,: std_logic;
	signal CB0_G0,CB1_G1,CB2_G2 : std_logic;
-- level 2 outputs
	signal SG0_,SG1_D0,SG2_D1,: std_logic;
	signal CG0_D0,CG1_D1,CG2_W0 : std_logic;
-- level 3 outputs
	signal SD0_,SD1_T0: std_logic;
	signal CD0_T0,CD1_W0 : std_logic;
-- level 4 outputs
	signal ST0_: std_logic;
	signal CT0_W0 : std_logic;

--output 
	signal output: std_logic_vector(5 downto 0);
Begin

-- Insert your design here -------------------------------------------------------------------------------------

--level 0
								--s1=carry S0= sum  
	FA_A1: entity work.FullAdder(rtl) port map (A =>, B =>, C =>, 			S1=>CA1_B1, S0=> SA1_B0);
	FA_A2: entity work.FullAdder(rtl) port map (A =>, B =>, C =>, 			S1=>CA2_G1, S0=> SA2_G0);
	FA_A3: entity work.FullAdder(rtl) port map (A =>, B =>, C =>, 			S1=>CA3_G2, S0=> SA3_B2);
	FA_A4: entity work.FullAdder(rtl) port map (A =>, B =>, C =>, 			S1=>CA4_B1, S0=> SA4_B0);
	FA_A5: entity work.FullAdder(rtl) port map (A =>, B =>, C =>, 			S1=>CA5_B2, S0=> SA5_B1);
	FA_A6: entity work.FullAdder(rtl) port map (A =>, B =>, C =>, 			S1=>CA6_G2, S0=> SA6_B2);
--level 1								--s1=carry S0= sum 
	HA_B0: entity work.FullAdder(rtl) port map (A =>SA1_B0, B =>SA4_B0, C =>0, 	S1=>CB0_G0, S0=>output(0));
	FA_B1: entity work.FullAdder(rtl) port map (A =>SA5_B1, B =>CA1_B1, C =>CA4_B1, S1=>CB1_G1, S0=> SB1_G0);
	FA_B2: entity work.FullAdder(rtl) port map (A =>SA3_B2, B =>CA5_B2, C =>SA6_B2, S1=>CB2_G2, S0=> SB2_G1);

--level 2
	FA_G0: entity work.FullAdder(rtl) port map (A =>SA2_G0, B =>SB1_G0, C =>CB0_G0, S1=>CG0_D0 , S0=>output(1));
	FA_G1: entity work.FullAdder(rtl) port map (A =>CA2_G1, B =>SB2_G1, C =>CB1_G1, S1=>CG1_D1 , S0=>SG1_D0);
	FA_G2: entity work.FullAdder(rtl) port map (A =>CA3_G2, B =>CA6_G2, C =>CB2_G2, S1=>CG2_W0 , S0=>SG2_D1);
--level 3
	HA_D0: entity work.FullAdder(rtl) port map (A =>SG1_D0, B =>CG0_D0, C =>0, 	S1=> CD0_T0, S0=>output(2));
	HA_D1: entity work.FullAdder(rtl) port map (A =>SG2_D1, B =>CG1_D1, C =>0, 	S1=> CD1_W0, S0=> SD1_T0);
--level 4
	HA_T0: entity work.FullAdder(rtl) port map (A =>CD0_T0, B =>SD1_T0, C =>0, 	S1=>CT0_W0, S0=>output(3));
--level 5
	HA_W0: entity work.FullAdder(rtl) port map (A =>CT0_W0, B =>CD1_W0, C =>CG2_W0, S1=>output(5), S0=>output(4));
	
End Architecture structural;


