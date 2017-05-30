goal(state(_,_,_,has)).
init(state(atdoor,onfloor,atwindow,hasnot)).

move(state(Pos1,onfloor,Pos1,Has),climb,state(Pos1,onbox,Pos1,Has)).
move(state(middle,onbox,middle,hasnot),grab,state(middle,onbox,middle,has)).
move(state(L1,onfloor,L1,Has),push(L1,L2),state(L2,onfloor,L2,Has)).
move(state(L1,onfloor,Pos,Has),walk(L1,L2),state(L2,onfloor,Pos,Has)).

solve(State1) :- goal(State1).
solve(State1) :- move(State1,_,State2), solve(State2).

solve(State1,[]) :- goal(State1), print(State1), nl.
solve(State1,LA) :- move(State1,A,State2), append([A],L,LA), print(State1), nl, solve(State2, L).
