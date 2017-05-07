:- dynamic nutrition/5.
:- dynamic person/6.

numbers([1,2,3,4,5,6,7,8,9,10]).
prego(1, 300).
prego(2, 300).
prego(3, 500).
%% food([Type], MaxAmount, Food, Calories, Carbs(g), Protein(g), Fat(g))
food(1, 4, [br], "Egg(s)", 196, 0.83, 13.61, 14.84).
food(2, 8, [br], "Slice(s) of Bacon", 43, 0.1, 3, 3.3).
food(3, 4, [br], "Slice(s) of Whole Wheat Toast - Dry", 69, 12, 3.6, 0.9).
food(4, 3, [br], "Cup(s) of Oatmeal - No Sugar", 158, 27, 6, 3.2).
food(5, 2, [br, sn], "Apple(s)", 95, 25, 0.5, 0.3).
food(6, 2, [br, sn], "Banana(s)", 105, 27, 1.3, 0.4).
food(7, 2, [br, sn], "Grapefruit Hal(f/ves) - No Sugar", 26, 6.5, 0.45, 0.1).
food(8, 2, [br], "Cup(s) each of HoneyNut Cheerioes and 2% Milk", 227, 39, 8, 5).
food(9, 5, [br], "Breakfast Sausage(s)", 71, 3.1, 9, 2.7).
food(10, 1, [br], "Waffle House Waffle with 1 pack Butter ans 1 oz Syrup", 456, 45, 6, 15).
% food(21, 8, [br, ln, dn], "Half Breast(s) of Baked Chicken - Boneless
% Skinless", 164, 0, 24.82, 6.48). food(22, 8, [br, ln, dn], "Half Cup(s)
% of Sauteed Spinach", 23, 3.8, 3, 0.3). food(23, 20, [br, ln, dn],
% "Spear(s), of Grilled Asparsgus", 2.857, 0.429, 0.286, 0).
food(11, 8, [br, ln, dn, jew], "Latka(s)", 99, 10, 2.2, 5).
food(12, 2, [br, ln, dn, jew], "Hal(f/ves) a Potato Knish", 230, 29, 5, 11).
%food(13, 1,[ln, dn, jew], "Pastrami Reuben", 635, 56, 40, 28). food(14, 1, [ln,
% dn, jew], "Corned Beef Reuben", 600.9, 60.1, 40.2, 22.1). food(15, 1,
% [ln, dn, mx], "Beef Chimichanga", 425, 43, 20, 20). food(16, 1, [ln,
% dn, mx], "Beef & Cheese Chimichanga", 443, 39, 20, 23). food(17, 1,
% [ln, dn, mx], "Beef & Cheese Burrito", 632, 64, 41, 25). food(18, 2,
% [ln, dn, mx], "Half Skillet(s) of Chicken Fajitas", 330, 23, 21, 11).
% food(19, 1, [ln, dn], "Chicken Caesar Salad", 260, 16, 14, 18).
% food(20, 1, [ln, dn], "Cobb Salad", 584, 16, 35, 44).

%% person(ID, Name, Weight(lb), Height(in), Age, Trimester)
person(1, ashley, 120, 64, 21, 2).

%% nutrition(ID, [TotalCalories, BreakfastCal, Snk1Cal, LunchCal,
%% Snk2Cal,DinnerCal, Snk3Cal], [TotalCarbs, BreakfastCarbs, Snk1Carbs,
%% LunchCarbs, Snk2Carbs, DinnerCarbs, Snk3Carbs], [TotalProtein,
%% BreakfastPr, Snk1Pr, LunchPr, Snk2Pr, DinnerPr, Snk3Pr], [TotalFat,
%% BreakfastFat, Snk1Fat, LunchFat, Snk2Fat, DinnerFat, Snk3Fat]).


calc_daily_calories(Calories, [Calories, B, Sn1, L, Sn2, D, Sn3]) :-
	  B is 0.2 * Calories,
	  Sn1 is 0.06666 * Calories,
	  L is 0.3 * Calories,
	  Sn2 is 0.06666 * Calories,
	  D is 0.3 * Calories,
	  Sn3 is 0.06666 * Calories.

calc_daily_carbs(Calories, [Total, B, Sn1, L, Sn2, D, Sn3]) :-
	Carbs is Calories / 4,
	Total is Carbs * 0.451666,
	B is Carbs * 0.06,
	Sn1 is Carbs * 0.026666,
	L is Carbs * 0.135,
	Sn2 is Carbs * 0.04,
	D is Carbs * 0.15,
	Sn3 is Carbs * 0.04.

calc_daily_protein(Calories, [Total, B, Sn1, L, Sn2, D, Sn3]) :-
	Protein is Calories / 4,
	Total is Protein * 0.2166666,
	B is Protein * 0.06,
	Sn1 is Protein * 0.016666,
	L is Protein * 0.06,
	Sn2 is Protein * 0.01,
	D is Protein * 0.06,
	Sn3 is Protein * 0.01.


calc_daily_fat(Calories, [Total, B, Sn1, L, Sn2, D, Sn3]) :-
	Fat is Calories / 9,
	Total is Fat * 0.3316665,
	B is Fat * 0.08,
	Sn1 is Fat * 0.23333,
	L is Fat * 0.105,
	Sn2 is Fat * 0.016666,
	D is Fat * 0.09,
	Sn3 is Fat * 0.16666.

create_nutrition(ID) :-
	person(ID, _, Weight, Height, Age, Trimester),
	bmr(Weight, Height, Age, Trimester, Calories),
	calc_daily_calories(Calories, C),
	calc_daily_carbs(Calories, Cb),
	calc_daily_protein(Calories, P),
	calc_daily_fat(Calories, F),
	assert(nutrition(ID, C, Cb, P, F)).

modifiers(10, 10, 10, 10).

in_order([_|[]]):-!.
in_order([[ID,_,_]|[[ID2, _, _]|Tail]]) :-
	ID < ID2,
	in_order([[ID2, _, _]|Tail]).



bmr(Weight, Height, Age, Trimester, Calories) :-
	prego(Trimester, X),
	Calories is 655.1 + (4.35 * Weight) + (4.7 * Height) - (4.7 * Age) + X.

bs_levels(BloodSugar, _, too_low) :-
	BloodSugar < 85.
bs_levels(BloodSugar, before, good) :-
	BloodSugar =< 100,
	BloodSugar >= 85.
bs_levels(BloodSugar, before, high) :-
	BloodSugar > 100.
bs_levels(BloodSugar, one_hour, good) :-
	BloodSugar =< 140,
	BloodSugar >= 85.
bs_levels(BloodSugar, one_hour, high) :-
	BloodSugar > 140.
bs_levels(BloodSugar, two_hours, good) :-
	BloodSugar =< 120,
	BloodSugar >= 85.
bs_levels(BloodSugar, two_hours, high) :-
	BloodSugar > 120.


build_meal(TotalCalories, TotalCarbs, TotalProtein, TotalFat, _, []) :-
	TotalCalories > -30,
	TotalCalories < 30,
	TotalCarbs > -5,
	TotalCarbs < 5,
	TotalProtein > -5,
	TotalProtein < 5,
	TotalFat > -5,
	TotalFat < 5,!.
build_meal(TotalCalories, TotalCarbs, TotalProtein, TotalFat, Type, [[ID, Food, Num]|Tail]) :-
	food(ID, Max, Types, Food, Calories, Carbs, Protein, Fat),
	member(Type, Types),
	numbers(N),
	member(Num, N),
	Num =< Max,
	TotalCalories2 is TotalCalories - (Num*Calories),
	TotalCalories2 > -30,
	TotalCarbs2 is TotalCarbs - (Num*Carbs),
	TotalCarbs2 > -5,
	TotalProtein2 is TotalProtein - (Num*Protein),
	TotalProtein2 > -5,
	TotalFat2 is TotalFat - (Num*Fat),
	TotalFat2 > -5,
	build_meal(TotalCalories2, TotalCarbs2, TotalProtein2, TotalFat2, Type, Tail),
	\+member([ID, Food, _], Tail),
	in_order([[ID, _, _]|Tail]).


test(X) :-
	create_nutrition(1),!,
	nutrition(1, [_,BC,_,LC|_], [_,BCb,_,LCb|_], [_,BP,_,LP|_], [_,BF,_,LF|_]),!,
	build_meal(BC, BCb, BP, BF, br, X).
%%	build_meal(LC, LCb, LP, LF, ln, Y).

find_next_ID(ID, ID) :-
	\+person(ID, _,_,_,_,_).
find_next_ID(Curr, ID) :-
	person(Curr, _,_,_,_,_),
	Next is Curr+1,
	find_next_ID(Next, ID).
command(1) :-
	find_next_ID(0, ID),
	write('What is your name?\n'),
	read(Name),
	write('What is your quest?\n'),
	read(_),
	write('What is your favorite color?\n'),
	read(_),
	write('What is your pre-pregnancy weight in pounds?\n'),
	read(Weight),
	write('What is your height in inches?\n'),
	read(Height),
	write('What is your age?\n'),
	read(Age),
	write('What Trimester are you in? (1, 2, or 3)\n'),
	read(Trimester),
	assert(person(ID, Name, Weight, Height, Age, Trimester)),
	create_nutrition(ID).

meal_amount(1, [_,B|_], B, br).
meal_amount(2, [_,_,Sn1|_], Sn1, sn).
meal_amount(3, [_,_,_,L|_], L, ln).
meal_amount(4, [_,_,_,_,Sn2|_], Sn2, sn).
meal_amount(5, [_,_,_,_,_,D,_], D, dn).
meal_amount(6, [_,_,_,_,_,_,Sn3], Sn3, sn).
command_2_aux(Name, Type, Meal) :-
	person(ID, Name, _, _, _, _),
	nutrition(ID, C, Cb, P, F),
	meal_amount(Type, C, MealC, MealName),
	meal_amount(Type, Cb, MealCb, MealName),
	meal_amount(Type, P, MealP, MealName),
	meal_amount(Type, F, MealF, MealName),
	build_meal(MealC, MealCb, MealP, MealF, MealName, Meal).
print_meal([]) :- write('\n').
print_meal([[_,Food,Num]|Tail]) :-
	write(Num),
	write(' '),
	write(Food),
	write(' , '),
	print_meal(Tail).
is_person(Name) :-
	person(_, Name,_,_,_,_).
is_person(Name) :-
	\+person(_,Name,_,_,_,_),
	write('I don\'t seem to know you, let\'s make you a profile\n'),
	command(1),!.
command(2) :-
	write('What is your name?\n'),
	read(Name),
	is_person(Name),
	write('Which meal would you like a plan for?\n1 - Breakfast\n2 - Snack 1\n3 - Lunch\n4 - Snack 2\n5 - Dinner\n6 - Snack 3\n'),
	read(Type),!,
	command_2_aux(Name, Type, Meal),
	print_meal(Meal),fail.
command(2) :- go().
command(3).

go() :-
	person(ID, _, _, _, _, _),
	\+nutrition(ID, _,_,_,_),
	create_nutrition(ID),
	go().
go() :-
   write('\nPlease Choose What to Do:\n1 - Enter new profile\n2 - Get Meal Plan\n3 - Quit\n '),
   read(X),
   command(X),
   write('\n').



















