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

deleteAll(T,N,R) :- insert(Tmp,N,T), deleteAll(Tmp,N,R).
deleteAll(T,_,T).

listtree(L,T) :- listtree(L,T,nil).
listtree([],T,T).
listtree([X|Xs],T,T1) :- insert(T1,X,T2), listtree(Xs,T,T2).

treelist(T,L) :- treelist(T,L,[]).
treelist(nil, L, L).
treelist(t(Left,N,Right), L, Ltmp0) :- treelist(Right, Ltmp1, Ltmp0), append([N],Ltmp1,Ltmp2), treelist(Left, L, Ltmp2).

treesort(Lin,Lout) :- listtree(Lin,T), treelist(T,Lout).

testts1(R) :- treesort([1,5,3,6,2,7,4,22],R).
testts2(R) :- treesort([53,32,65,34,31,23,435,23],R).
testts3(R) :- treesort([1,6,4,6,3,4,6,3,2],R).

