istree(nil).
istree(t(L,_,R)) :- istree(L), istree(R).

min(t(nil,N,_), N).
min(t(L,_,_),N) :- min(L,N).

max(t(_,N,nil), N).
max(t(_,_,R),N) :- max(R,N).

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

delete(t(nil,N,nil), N, nil).
delete(t(nil,N,R), N, R).
delete(t(L,N,nil), N, L).
delete(t(L,N,R), N, t(L, MinR, NewR)) :- min(R, MinR), delete(R, MinR, NewR).
delete(t(L,N,R), M, t(NewL, N, R)) :- max(L, MaxL), M =< MaxL, delete(L,M,NewL).
delete(t(L,N,R), M, t(L, N, NewR)) :- min(R, MinR), M >= MinR, delete(R,M,NewR).
 
deleteAll(T,N,R) :- delete(T,N,Tmp), deleteAll(Tmp, N, R).
deleteAll(T,_,T).

listtree(L,T) :- listtree(L,T,nil).
listtree([],T,T).
listtree([X|Xs],T,T1) :- insert(T1,X,T2), listtree(Xs,T,T2).

treelist(T,L) :- treelist(T,[],L).
treelist(nil, L, L).
treelist(t(Left,N,Right), Ltmp0, L) :- treelist(Left, Ltmp0, Ltmp1), append(Ltmp1,[N],Ltmp2), treelist(Right, Ltmp2, L).

treesort(Lin,Lout) :- listtree(Lin,T), treelist(T,Lout).

testts1(R) :- treesort([1,5,3,6,2,7,4,22],R).
testts2(R) :- treesort([53,32,65,34,31,23,435,23],R).
testts3(R) :- treesort([1,6,4,6,3,4,6,3,2],R).

testdel(R) :- deleteAll(t(t(t(nil, 3, nil), 5, t(nil, 7, nil)), 8, t(t(t(nil, 9, nil), 10, nil), 11, t(nil, 11, nil))), 11, R).

