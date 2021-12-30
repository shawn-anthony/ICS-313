%Shawn Anthony
%ICS 313
%Homework 5
%Biagioni
%Fall 2021

%Initialization
val(1).
val(2).
val(3).
val(4).

% Main predicate function which calls other predicates, first finding a
% valid sudoku solution and then printing it out like the instructions
% mentioned was optional. No other optional output was implemented. 
sudoku4x4(A1, A2, A3, A4, B1, B2, B3, B4, C1, C2, C3, C4, D1, D2, D3, D4) :-
    sudoku(A1, A2, A3, A4, B1, B2, B3, B4, C1, C2, C3, C4, D1, D2, D3, D4),
    nl,
    prettyprint(A1, A2, A3, A4), 
    prettyprint(B1, B2, B3, B4),
    prettyprint(C1, C2, C3, C4), 
    prettyprint(D1, D2, D3, D4).

% Used to verify no duplicate values in the provided four values, which
% is then used to pass each set of four to signify a valid sudoku board
assertValid(A, B, C, D) :- val(A), val(B), val(C), val(D), A\=B, A\=C, A\=D, B\=C, B\=D, C\=D.

% Sudoku predicate, which uses assertValid predicate to check each of
% the sets of four values to verify that we have a valid board, can 
% easily be adapted to work with 9x9 sudoku as well, it would just 
% require quite a few more lines of code to handle all the possibilities 
sudoku(A1, A2, A3, A4, B1, B2, B3, B4, C1, C2, C3, C4, D1, D2, D3, D4) :-
    %Rows
    assertValid(A1, A2, A3, A4),
    assertValid(B1, B2, B3, B4),
    assertValid(C1, C2, C3, C4),
    assertValid(D1, D2, D3, D4),
    %Columns
    assertValid(A1, B1, C1, D1),
    assertValid(A2, B2, C2, D2),
    assertValid(A3, B3, C3, D3),
    assertValid(A4, B4, C4, D4),
    %Blocks
    assertValid(A1, A2, B1, B2),
    assertValid(A3, A4, B3, B4),
    assertValid(C1, C2, D1, D2),
    assertValid(C3, C4, D3, D4).

% Prettier printing functions to output values in a readable grid as
% would be expected from a sudoku grid.
prettyprint(A, B, C, D) :- write(A), write(' '), write(B), write(' '), write(C), write(' '), write(D), nl.


% UNUSED!!!! Basic output functions for each individual number,
% these were required for output in swi-prolog in order to get a
% readable output as swi-prolog condensed the values returned to the
% console, but this was not needed in gprolog. Leaving this here
% for posterity in case we build upon this in a subsequent homework 

%Row A
printA1(A) :- write('A1 = '), write(A), nl.
printA2(A) :- write('A2 = '), write(A), nl.
printA3(A) :- write('A3 = '), write(A), nl.
printA4(A) :- write('A4 = '), write(A), nl.
%Row B
printB1(B) :- write('B1 = '), write(B), nl.
printB2(B) :- write('B2 = '), write(B), nl.
printB3(B) :- write('B3 = '), write(B), nl.
printB4(B) :- write('B4 = '), write(B), nl.

%Row C
printC1(C) :- write('C1 = '), write(C), nl.
printC2(C) :- write('C2 = '), write(C), nl.
printC3(C) :- write('C3 = '), write(C), nl.
printC4(C) :- write('C4 = '), write(C), nl.

%Row D
printD1(D) :- write('D1 = '), write(D), nl.
printD2(D) :- write('D2 = '), write(D), nl.
printD3(D) :- write('D3 = '), write(D), nl.
printD4(D) :- write('D4 = '), write(D), nl.















