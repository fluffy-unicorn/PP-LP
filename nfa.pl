% An NFA is a triple of the form:
% nfa(Init, Transitions, Accepting), where:
% - Init is a state,
% - Transitions a list of triples of the form trans(State,Label,State)
% - Accepting a list of accepting states.


% example n1 recognizes the language a+ . b+
%
example(n1, nfa(0,[trans(0,a,0), trans(0,a,1),trans(1,b,1),trans(1,b,2)], [2]) ).

% example n2 recognizes words that contain aaa or bbb
%
example(n2, nfa(0,
 [trans(0,a,0),trans(0,a,1),trans(1,a,2),trans(2,a,5),trans(5,a,5),
  trans(0,b,0),trans(0,b,3),trans(3,b,4),trans(4,b,5),trans(5,b,5)],
 [5])).
		

% Question 1: alphabet/2
example(s1, nfa(0,[trans(0,a,0)], 0)).

% appendNonDuplicate/3 only append to list when the value is not a member of the list
appendNonDuplicate(A,B,C) :- not(member(B,A)), !, append([B],A,C). 
appendNonDuplicate(A,_,A).

% alphabet/3 in case of a single transition, the list consists of the character in that transition
%            otherwise append the character of the first transition to the list of characters of the remaining list of transitions.
alphabet(nfa(_,[trans(_,S,_)],_),[S]) :- !.
alphabet(nfa(_,[trans(_,H,_)|T],_),L) :-  alphabet(nfa(_,T,_),LA), appendNonDuplicate(LA, H, L).

% Question 2: testNFA/2

% posTrans/4 indicate whether a transition from state Init with symbol S to state End is possible
posTrans(nfa(_,[trans(Init,S,End)|_],_), Init, S, End).
posTrans(nfa(_,[_|T],_),Init, S, End) :- posTrans(nfa(_,T,_),Init,S,End).  

% Goal/2 Indicates that the state S is in the list of final states F.
goal(S, F) :- member(S,F).

% testNFA/2 in case of a single character, the word is accepted by the NFA if a transition is possible with that character from the Init state to a final state.
%           otherwise the word is accepted when a transition can be made to a state from which it is known that the resulting word is accepted.
testNFA([S],nfa(Init,Trans,Final))    :- posTrans(nfa(Init,Trans,Final), Init, S, E), goal(E, Final).
testNFA([S|W], nfa(Init,Trans,Final)) :- posTrans(nfa(Init,Trans,Final), Init, S, E), testNFA(W, nfa(E,Trans,Final)).

% Operators for regular expressions

:- op(650,xfy,+).
:- op(640,xfy,^).
:- op(630,xf,*).

exampleRE(e1,(a+a^a)^(a^a^a)*).
exampleRE(e2,(a^a+b)*).

% Question 3: count/2
count(A,0)    :- atom(A).
count(A^B, R) :- count(A,Ra), count(B,Rb), R is Ra + Rb + 1.
count(A+B, R) :- count(A,Ra), count(B,Rb), R is Ra + Rb + 1.
count(A*, R)  :- count(A,Ra), R is Ra + 1.

exampleRE(t1, [a,a,b,a,a,a,a,b]  , (a^a+b)*).
exampleRE(t2, [a,a,b,a,a,a,a,a,b], (a^a+b)*).
exampleRE(t3, [a,a,a,a,a]        , (a+a^a)^(a^a^a)*).
exampleRE(t4, [a,a,a,a,a,a]      , (a+a^a)^(a^a^a)*).
exampleRE(t5, [a,b,a,b,b,c,b,c]  , ((a^b)* ^b^c)*).
exampleRE(t6, [a,b,a,b,b,c]      , (a^b)* ^b^c).
exampleRE(t7, [a,b,a,b,b]        , (a^b)* ^b).
exampleRE(t8, [a,b,b]            , (a^b)* ^b).
exampleRE(t9, [b]                , (a^b)* ^b).
exampleRE(t10,[a,b,b,b,b,a,c]    , a^b* ^b^a^c).
exampleRE(t11,[a,b,a,b,a,b]      , (a^b)*).

% Question 4: testRE/2
splitNonEmpty(A, A1, A2) :- append(A1, A2, A), not(A1 == []).
testRE([A],A) :- atom(A).
testRE([],_*).
testRE(W,A+_) :- testRE(W,A).
testRE(W,_+B) :- testRE(W,B).
testRE(W,A^B) :- append(Wa, Wb, W), testRE(Wa, A), testRE(Wb, B).
testRE(W, A*) :- splitNonEmpty(W, Wa, Wb), testRE(Wa, A), testRE(Wb, A*).

