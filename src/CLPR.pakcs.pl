%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Interface to the CLP(R) solver library of Sicstus/SWI-Prolog
%
% The clauses in this file are added to the compiled CLPR library.

:- use_module(library(clpr)).

'CLPR.prim_CLPR_plus'(Y,X,R) :- {R = X+Y}.

'CLPR.prim_CLPR_minus'(Y,X,R) :- {R = X-Y}.

'CLPR.prim_CLPR_times'(Y,X,R) :- {R = X*Y}.

'CLPR.prim_CLPR_div'(Y,X,R) :- {R = X/Y}.

'CLPR.prim_CLPR_le'(Y,X,'Prelude.True') :- {X < Y}.

'CLPR.prim_CLPR_ge'(Y,X,'Prelude.True') :- {X > Y}.

'CLPR.prim_CLPR_leq'(Y,X,'Prelude.True') :- {X =< Y}.

'CLPR.prim_CLPR_geq'(Y,X,'Prelude.True') :- {X >= Y}.

% transform an integer into a float:
'CLPR.prim_CLPR_i2f'(X,R) :- R is X*1.0.


?- block prim_minimumFor(?,?,?,-,?).
prim_minimumFor(Guard,Fun,X,E0,E) :-
        waitUntilGround('Prelude.(,)'(Guard,Fun),E0,E1),
	exec_minimum(Guard,Fun,X,E1,E).

?- block exec_minimum(?,?,?,-,?).
exec_minimum(Guard,Fun,X,E,E3) :-
        prim_apply(Guard,X,'Prelude.True',E,E1),
        prim_apply(Fun,X,Z,E1,E2),
	minimize(Z), E2=E3.

?- block prim_maximumFor(?,?,?,-,?).
prim_maximumFor(Guard,Fun,X,E0,E) :-
        waitUntilGround('Prelude.(,)'(Guard,Fun),E0,E1),
	exec_maximum(Guard,Fun,X,E1,E).

?- block exec_maximum(?,?,?,-,?).
exec_maximum(Guard,Fun,X,E,E3) :-
        prim_apply(Guard,X,'Prelude.True',E,E1),
        prim_apply(Fun,X,Z,E1,E2),
	maximize(Z), E2=E3.
