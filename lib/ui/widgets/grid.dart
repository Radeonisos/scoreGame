import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_games.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/ui/widgets/card_game.dart';

class Grid extends StatelessWidget {

  List<Game> games;

  BlocGames bloc;

  Grid(this.games, this.bloc);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    final numberCardByRow = orientation == Orientation.portrait ? 2 : 4;

    return new GridView.builder(
        itemCount: games.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numberCardByRow),
        itemBuilder: (context, i){
          return  CardGame(games[i],bloc);
        });
  }
}