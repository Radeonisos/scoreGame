import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_scores.dart';
import 'package:score_games/models/score.dart';
import 'package:score_games/ui/widgets/BorderAll.dart';
import 'package:score_games/ui/widgets/text_alternate.dart';

class ListScores extends StatelessWidget {
  List<Score> scores;

  BlocScores bloc;

  // ajout streamBuilder sur cette page pour refresh les widgets correctement

  ListScores(this.scores, this.bloc);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: scores.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Dismissible(
              key: Key('${scores[i].id}'),
              background: Container(
                color: Colors.red,
                alignment: AlignmentDirectional.centerEnd,
                child: Icon(Icons.delete),
              ),
              onDismissed: (direction){
                bloc.deleteScore(scores[i]);
              },
              child: Container(
                height: 30,
                width: 120,
                decoration: BorderAll().myBoxDecoration(),
                child: new Material(
                  child: new InkWell(
                    onTap: () {
                      print(scores[i].id);
                      print(scores[i].point);

                      _showDialog(context, scores[i]);
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
              ));
        });
  }

  void addScore(String point, Score score) {
    score.point = point;
    bloc.addScore(score);
  }

  void _showDialog(BuildContext context, Score score) {
    // flutter defined function
    String point;
    TextEditingController _textFieldController = TextEditingController();
    _textFieldController.text = score.point;
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        // return object of type Dialog
        return SimpleDialog(
          title: new Text("Score:"),
          children: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextField(
              controller: _textFieldController,
              onChanged: (String data) {
                point = data;
              },
              onSubmitted: (String data) {
                addScore(point, score);
                Navigator.pop(buildContext);
              },
            ),
            new SimpleDialogOption(
              child: new Text('OK'),
              onPressed: () {
                addScore(point, score);
                Navigator.pop(context);
              },
            ),
            new SimpleDialogOption(
              child: new Text('Annuler'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            new SimpleDialogOption(
              child: new Text('Supprimer'),
              onPressed: () {
                bloc.deleteScore(score);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
