program roulette;

{
	Name		: Vamshidhar Reddy Gondi
	UIN			: 660396123
	Course		: CSC 540 A Graduate Research Seminar
	Assignment	: HW3
}

const
	num_wheel 	= 37;  			{ # Defining the Numbers on Roulette Wheel 0 - 36 # }
	distinct_num 	= 13;  			{ # Find the Question 'B' value #  }

			{ # Variable Declartion # }
var
	num_spins, i 			: qword;
	count_twice    			: int64;
	count_thrice			: int64;
	prev_spinval			: integer;
	preprev_spinval			: integer;
	distinct_numfound		: boolean;
	num_evenoddspins		: int64;
	num_evenspins			: int64;
	num_oddspins			: int64;
	current_spinval			: integer;
	distinct_numfoundonspin         : int64;

begin
	i	                := 0;
	count_twice	       	:= 0;
	count_thrice		:= 0;
	prev_spinval		:= 75;
	preprev_spinval		:= 75;
	distinct_numfound	:= False;
	num_evenoddspins	:= 1;
	num_evenspins		:= 1;
	num_oddspins		:= 1;

	write('Enter The Number Of Spins : ');
	readln(num_spins); 		 						{ # Number of spins for user input # }

	randomize;										{ # Generating Random Number # }

	while (i < num_spins) do  						{ # Runs till number of spins provided by user # }
	begin
		i := i + 1;  								{ # Incrementing Loop Counter # }
		current_spinval := random(num_wheel);  		{ # Generating random numbers between 0 - 36 # }

		if (current_spinval = prev_spinval) then  	{ # Consecutive matches in a row for spin values # }
		begin
			count_twice := count_twice + 1;  		{ # increases counter value for question 'A' part 1 # }
			if (current_spinval = distinct_num) AND (distinct_numFound = False) then  { # equals for number in Question 'B' # }
			begin
				distinct_numfoundonspin := i;  			{ # records the spin numbers in Question 'B' # }
				distinct_numfound := True;  			{ # indicates program to stops when finds distinct number of time in Question 'B' # }
			end;
			if (prev_spinval = preprev_spinval) then 	{ # matches the number from 1st spin to second spin in Question 'A' # }
				count_thrice := count_thrice + 1;		{ # increases counter value for question 'A' part 2 # }
		end; 											{ # ends the matching for spins in a row # }
						{ # find run of even/odd in a row # }
        if (current_spinval = 0) then 					{ # compares spin value to '0' to reset counter for evens # }
		    num_evenoddspins := 1;
		if (i > 1) AND (current_spinval <> 0) AND (current_spinval MOD 2 = 0) AND (prev_spinval MOD 2 = 0) then
		begin  											{ # Matches for consecutive even spins in arrow. Starting at spin 2 to avoid counting preset 'prev_spinval's # }
                {aviods matching for '0'}
			num_evenoddspins := num_evenoddspins + 1;	{ # increases counter in question 'C' part 1 # }
			if (num_evenoddspins > num_evenspins) then
				num_evenspins := num_evenoddspins;  	{ # tracks the number of longest runs for even values # }
		end;
		if (current_spinval MOD 2 = 0) AND (prev_spinval MOD 2 = 1) then  { # resets consecutive even counter # }
			num_evenoddspins := 1;
		if (current_spinval MOD 2 = 1) AND (prev_spinval MOD 2 = 1) then  { # checks number of runs for odd spins in a row # }
		begin
			num_evenoddspins := num_evenoddspins + 1;					  { # increases question 'c' part 2 counter # }
			if (num_evenoddspins > num_oddspins) then
				num_oddspins := num_evenoddspins;  						  { # tracks the number of longest run for odd values # }
		end;
		if (current_spinval MOD 2 = 1) AND (prev_spinval MOD 2 = 0) then  { # resets consecutive odd counter # }
			num_evenoddspins := 1;
							{ # end: checks how many times it runs for even/odd in a row # }

		preprev_spinval := prev_spinval;
		prev_spinval 	:= current_spinval;
	end; 													{ # while spin loop # }

							{ # Output Section # }
	writeln;
	writeln('Question A');
	writeln;
	writeln('On Average, a Number Comes Up Two Times In a Row: ', 100*(count_twice/num_spins):6:3, '%');  		{ # calculates avg for any given number twice in a row # }
	writeln;
	writeln('On Average, a Number Comes Up Three times in a Row: ', 100*(count_thrice/num_spins):6:3, '%');  	{ # calculates avg for any given number thrice in a row # }
	writeln;
	writeln('Question B');
	writeln;
	if (distinct_numfound = False) then
		writeln('The Particular Number ', distinct_num, ' didnot appear twice in a row: ')
	else
		writeln('The Particular Number ', distinct_num, ' came up twice in a row: ', distinct_numfoundonSpin);
	writeln;
	writeln('Question C');
	writeln;
	writeln('The longest run of evens in a row in our simulation is: ', num_evenspins);
	writeln;
	writeln('The longest run of odds in a row in our simulation is: ', num_oddspins);
	writeln;

	write('Click ENTER to Exit the game.');
	readln;
end.
