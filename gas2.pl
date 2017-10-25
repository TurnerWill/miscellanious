% ##############################################################################################
% William Turner student id: 8081280169195537
% Logic puzzle solver.
% 
% 1) Ask for solutions:
%   solve(Ballantines, Energo, Gas_n_go, Fuel_stop, Vexon)
% 
% referencing:
% Rainhard Findling
% @ https://geekoverdose.wordpress.com/2015/10/31/solving-logic-puzzles-in-prolog-puzzle-1-of-3/
% 10/2015
% referenced for general design and syntactic, semantic overviews
% in introductory Prolog
% ##############################################################################################

all_members([H],L2) :- member(H,L2).
all_members([H|T],L2) :- member(H,L2), all_members(T, L2).
 
or([H]) :- H,!.
or([H|_]) :- H,!.
or([_|T]) :- or(T).

solve(Ballantines, Energo, Gas_n_go, Fuel_stop, Vexon) :-
	% all stations
	Ballantines = [Ballantines_price, Ballantines_town],
	Energo = [Energo_price, Energo_town],
	Gas_n_go = [Gas_n_go_price, Gas_n_go_town],
	Fuel_stop = [Fuel_stop_price, Fuel_stop_town],
	Vexon = [Vexon_price, Vexon_town],
	% grouping
	All = [Ballantines, Energo, Gas_n_go, Fuel_stop, Vexon],
	% insure all values exist once
	all_members([107, 111, 115, 119, 123], [Ballantines_price, Energo_price, Gas_n_go_price, Fuel_stop_price, Vexon_price]),
	all_members([irvine, lewis, santa_rosa, tecopa, zamora], [Ballantines_town, Energo_town, Gas_n_go_town, Fuel_stop_town, Vexon_town]),
	% clue 1) Fuel_stop charges somewhat less than Vexon
	Fuel_stop_price < Vexon_price,
	% clue 2) the business in irvine charges somewhat more than santa_rosa
	member([C2irvine_price, irvine], All),
	member([C2santa_price, santa_rosa], All),
	C2irvine_price > C2santa_price,
	% clue 3) Gas_n_go does not charge 123
	Gas_n_go_price \= 123,
	% clue 4) the station in lewis charges 8 less than zamora
	member([C4lewis_price, lewis], All),
	member([C4zamora_price, zamora], All),
	C4zamora_price - C4lewis_price =:= 8,
	% clue 5) Fuel_stop charges 8 less than santa_rosa
	member([C5santa_price, santa_rosa], All),
	C5santa_price - Fuel_stop_price =:= 8,
	% clue 6) the business in lewis is either Vexon or Energo
	or([Vexon_town = lewis, Energo_town = lewis]),
	% Fuel_stop charges 4 less than Ballantines
	Ballantines_price - Fuel_stop_price =:= 4.

