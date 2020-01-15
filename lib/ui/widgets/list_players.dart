import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_players.dart';
import 'package:score_games/blocs/bloc_scores.dart';
import 'package:score_games/models/player.dart';
import 'package:score_games/models/score.dart';
import 'package:score_games/ui/widgets/card_game.dart';
import 'package:score_games/ui/widgets/list_scores.dart';
import 'package:score_games/ui/widgets/no_data.dart';
import 'package:score_games/ui/widgets/separator.dart';
import 'package:score_games/ui/widgets/text_alternate.dart';

class ListPlayers extends StatelessWidget {

  List<Player> players;

  BlocPlayers bloc;

  ListPlayers(this.players, this.bloc);


  @override
  Widget build(BuildContext context) {

    return new ListView.builder(
        itemCount: players.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i){
          BlocScores blocScores = new BlocScores(players[i].id);
          return  Container(
            margin: EdgeInsets.only(right: 2),
            width: 120,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                TextAlternate(string: players[i].name, align: TextAlign.center,size: 25,color: Colors.redAccent,),
                StreamBuilder<List<Score>>(
                  stream: blocScores.stream,
                  builder: (context, snap) {
                    if (snap == null) {
                      return NoData("Pas de points");
                    } else if (!snap.hasData) {
                      return NoData("Pas de points");
                    } else {
                      return Expanded(
                          child: ListScores(snap.data,blocScores));
                    }
                  },
                ),
                Separator(),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.blue,
                  tooltip: "Ajout d'un score",
                  onPressed: () {
                    Score s = new Score();
                    s.player = players[i].id;
                    s.point = '+10';
                    blocScores.addScore(s);
                  },
                ),
              ],
            )

          );
        });
  }
}