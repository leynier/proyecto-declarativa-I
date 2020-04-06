:-[player].

% Get Player First Posible Move
getImpData(( _, Type, Cant), (Type, Cant)) :-
    !.
getImpData((Type, Cant), (Type, Cant)) :-
    !.

buildMove(PlayerId, ((FactId, Type, Cant), Row), Move, no) :-
    Move=(moveTile((FactId, Type, Cant), no), addTilesToRow(PlayerId, Row, Type, Cant)),
    !.

buildMove(PlayerId, ((Type, Cant), Row), Move, Especial) :-
    Move=(moveTile((Type, Cant), Especial), addTilesToRow(PlayerId, Row, Type, Cant)),
    !.

getFirstMove(PlayerId, Move, Especial) :- 
    getAllMoves(PossiblePlays),
    findall(
        (Y, Row),
        (
            member(Y,PossiblePlays),
            member(Row, [1,2,3,4,5]), 
            getImpData(Y, (Type, Cant)),
            getPlayerRow(PlayerId, Row, ActRow),
            player(PlayerId,_,_,_,_,_,_,_,Wall),
            not(member((Row, _, Type), Wall)),
            getNewRow(Row, ActRow, (Type, Cant), _, _)
        ), 
        [RawMove|_]
    ),
    buildMove(PlayerId, RawMove, Move, Especial),
    !.