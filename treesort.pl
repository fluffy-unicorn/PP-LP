istree(nil).
istree(t(L,_,R)) :- istree(L), istree(R).

min(nil,inf).
min(t(nil,N,nil),N).
min(t(L,N,R),ML)  :- min(L,ML), min(R,MR), ML < N, ML < MR.
min(t(L,N,R),N)   :- min(L,ML), min(R,MR), N < ML, N < MR.
min(t(L,N,R),MR)  :- min(L,ML), min(R,MR), MR < ML, MR < N.

max(nil,0).
max(t(nil,N,nil),N).
max(t(L,N,R),ML)  :- max(L,ML), max(R,MR), ML > N, ML > MR.
max(t(L,N,R),N)   :- max(L,ML), max(R,MR), N > ML, N > MR.
max(t(L,N,R),MR)  :- max(L,ML), max(R,MR), MR > ML, MR > N.

issorted(t(nil,_,nil)).
issorted(t(nil,N,R)) :- !, min(R,M), M >= N.
issorted(t(L,N,nil)) :- !, max(L,M), M =< N.
issorted(t(L,N,R)) :- issorted(t(L,N,nil)), issorted(t(nil,N,R)).

find(t(L,N,R),N,t(L,N,R)).
find(t(L,_,_),N,FL) :- find(L,N,FL).
find(t(_,_,R),N,FR) :- find(R,N,FR).

insert(nil,N,(t(nil,N,nil))).
insert(t(L,M,R),N,t(S,M,R)) :- N < M, insert(L,N,S).
insert(t(L,M,R),N,t(L,M,S)) :- N >= M, insert(R,N,S).

listtree([],nil).
listtree([X],t(nil,X,nil)).
listtree([X|Xs],T2) :- listtree(Xs, T), insert(T,X,T2).

