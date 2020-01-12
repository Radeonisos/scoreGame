import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_players.dart';
import 'package:score_games/blocs/bloc_scores.dart';
import 'package:score_games/models/player.dart';
import 'package:score_games/models/score.dart';
import 'package:score_games/ui/widgets/card_game.dart';
import 'package:score_games/ui/widgets/text_alternate.dart';

class ListScores extends StatelessWidget {

  List<Score> scores;

  BlocScores bloc;

  ListScores(this.scores, this.bloc);

  @override
  Widget build(BuildContext context) {

    return new ListView.builder(
        itemCount: scores.length,
        shrinkWrap: true,
        itemBuilder: (context, i){
          return  Container(
            margin: EdgeInsets.only(right: 2),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                TextAlternate(string: scores[i].point, align: TextAlign.center,),
              ],
            )

          );
        });
  }
}