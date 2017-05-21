father(X,Y) :- husband(X,Z), mother(Z,Y).
child(X,Y) :- father(Y,X).
child(X,Y) :- mother(Y,X).
grandparent(X,Y) :- child(Y,Z), child(Z,X).
sister(X,Y) :- child(X,P), female(X), child(Y,P), not(X=Y).
brother(X,Y) :- child(X,P), male(X), child(Y,P), not(X=Y).
aunt(X,Y) :- sister(X,P), child(Y,P).
sibling(X,Y) :- child(X,P), child(Y,P), not(X=Y).
cousin(X,Y) :- child(X,P), child(Y,Q), sibling(P,Q), not(X=Y).
nephew(X,Y) :- male(X), child(X,P), sibling(P,Y).

ancestor(X,Y) :- child(Y,X).
ancestor(X,Y) :- child(Y,Z), ancestor(X,Z).
