import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_players.dart';
import 'package:score_games/blocs/bloc_scores.dart';
import 'package:score_games/models/player.dart';
import 'package:score_games/models/score.dart';
import 'package:score_games/ui/widgets/BorderAll.dart';
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
            height: 30,
            decoration: BorderAll().myBoxDecoration(), //       <--- BoxDecoration here
            child:  new Material(
              child: new InkWell(
                onTap: (){
                  _showDialog(context, scores[i].point);
                },
                child: new Container(
                  child: TextAlternate(
                    string: scores[i].point,
                    align: TextAlign.center,
                    size: 22,
                  ),
                ),
              ),
              color: Colors.transparent,
            ),
          );
        });
  }



  void _showDialog(BuildContext context, String text) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Score:"),
          content: new Text(text),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(buildContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

