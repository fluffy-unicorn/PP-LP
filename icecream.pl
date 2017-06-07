:-use_module(library(clpfd)).         

% Convert a list of indices to a list of atoms 
toNames([Ai,Bi,Ci,Di], L, [An,Bn,Cn,Dn]) :- nth0(Ai,L,An), nth0(Bi,L,Bn), nth0(Ci,L,Cn), nth0(Di,L,Dn).

% Definition of the various stands etc.
stands([alice, garry, sally, tom]).
towns([boulder, granite, marsh, rockland]).
flavours([chocolate, coffee, peanut, peppermint]).
days([tuesday, wednesday, thursday, friday]).

% Prints a matrix in pretty format
printMatrix([A],[B],[C],[D]) :- 
    atom_length(A,La), Sa is 11 - La, print(A), tab(Sa), 
    print(B), atom_length(B,Lb), Sb is 11 - Lb, tab(Sb),
    print(C), atom_length(C,Lc), Sc is 11 - Lc, tab(Sc), 
    print(D), nl, !.
printMatrix([H1|T1],[H2|T2],[H3|T3],[H4|T4]) :- printMatrix([H1],[H2],[H3],[H4]), printMatrix(T1,T2,T3,T4).

% Prints the solution of the icecream problem
solution :-
    solution(Days, Stands, Towns, Flavours), printMatrix(Days, Stands, Towns, Flavours).

% Gives the solution of the icecream problem in the appropiate lists.
solution(Days, Stands, Towns, Flavours) :-
    StandIdx = [_,_,_,_],
    TownIdx = [_,_,_,_],
    FlavourIdx = [_,_,_,_],
    StandIdx ins 0..3,
    TownIdx ins 0..3,
    FlavourIdx ins 0..3,
    all_different(StandIdx),
    all_different(TownIdx),
    all_different(FlavourIdx),

    days(Days), 
    stands(S), 
    towns(T), 
    flavours(F), 
    toNames(StandIdx, S, Stands), 
    toNames(TownIdx, T, Towns), 
    toNames(FlavourIdx, F, Flavours),


    nth0(D0,Stands,garry),
    nth0(D1,Towns,granite),
    nth0(D2,Flavours,chocolate),
    D0 #= D1-1,
    D1 #= D2-1,
    nth0(DS,Stands,sally),
    nth0(DR,Towns,rockland),
    DS #\= DR, 
    nth0(DP,Stands,tom),
    nth0(DP,Flavours,peanut),
    nth0(DT,Days,tuesday),
    DP #\= DT,
    nth0(D3,Towns, marsh),
    nth0(D4,Stands, sally),
    D3 #= D4-1,
    nth0(DW,Days,wednesday),
    nth0(DW,Flavours,coffee),
    nth0(DA,Stands,alice),
    DW #\= DA,

    label(StandIdx),
    label(TownIdx),
    label(FlavourIdx).
