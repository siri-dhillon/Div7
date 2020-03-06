Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity TBDiv7 is
Generic ( N : natural := 18 );
End Entity TBDiv7;

Architecture behavioural of TBDiv7 is
	Constant Period : time := 10 ns;
	Constant StableTime : time := 4 ns;
	Signal clock : std_logic := '0';
	Signal start, done : std_logic := '0';
-- Now declare the internal signals for the architecture
	Signal x : std_logic_vector( N-1 downto 0 );
	Signal IsDivisible, TBIsDivisible1, TBIsDivisible2 : std_logic;
	Type	IntList is array ( 1 to 10 ) of integer;
	Constant TestValue : IntList := ( 0, 20, 569, 100, 70, 12345, 38572, 958472372, 2344, 43535 );   
Begin
	clock <= not clock after Period/2;
DUT:	Entity work.Div7 generic map( N => N )
		port map ( x => x, IsDivisible => IsDivisible );


-- Enter your code for generating stimuli.
Stimulus:
	Process
		variable myvalue: integer := 1;
		variable incrementvalue : integer := 0;

	Begin
		--sets x <= unknown,  clears the start
		x <= '000000000000000000';
		start <='0';
		--wait until rising edge of clock
		wait until rising_edge(clk);
			--casting
			x <=  std_logic_vector(to_unsigned(TestValue(myvalue)+incrementvalue,N));
			
			if (myvalue > 10) then
					--reset
					myvalue := 0;
					incrementvalue := 0;
				else
					if (incrementvalue >= 6) then
						myvalue := myvalue + 1;
						incrementvalue := 0;
					else
						incrementvalue := incrementvalue + 1;
					end if;
				end if;		
			
			
		wait until rising_edge(done);

	End Process Stimulus;

TBDiv7:
	process ( x ) is
		variable y : natural;
	Begin
		y := to_integer( unsigned(x) );
		if (y mod 7) = 0 then
			TBIsDivisible1 <= '1';
		else
			TBIsDivisible1 <= '0';
		end if;

		y := to_integer( unsigned(x) );
		while (y >= 7) loop
			y := y - 7;
		end loop;
		if y = 0 then
			TBIsDivisible2 <= '1';
		else
			TBIsDivisible2 <= '0';
		end if;
	End Process TBDiv7;

-- Enter your code for detecting response errors.
Detector:
	Process
	Begin
		wait until rising_edge(start)
			done <= '0';
			
		wait until rising_edge(clk)
		
			if(IsDivisible'stable(StableTime) and not IsDivisible = 'U') then
				done <= '1';
				assert false report "Value not stable for 4 ns" severity error;
			end if;
	
	End Process Detector;
End Architecture behavioural;

