import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_games.dart';
import 'package:score_games/models/game.dart';

class AlertAddGame {
  String name;


  AlertAddGame();

  addGame(String name, String img, BlocGames blocGame) {
    Game gameNew = new Game();
    gameNew.name = name;
    blocGame.addGame(gameNew);
  }

  void showDialogAddGame(BuildContext context, BlocGames blocGame) {
    showDialog(context:context,
      builder: (BuildContext buildContext) {
        return SimpleDialog(
            contentPadding: EdgeInsets.all(15),
            title: Text("Création d'une partie"),
            children: <Widget>[
              new TextField(
                decoration: InputDecoration(
                  labelText: "Nom de la partie: ",
                ),
                onChanged: (String data) {
                  name = data;
                },
                onSubmitted: (String data) {
                  addGame(data, '', blocGame);
                  Navigator.pop(buildContext);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(buildContext),
                    child: Text(
                      'Annuler',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      addGame(name, '', blocGame);
                      Navigator.pop(buildContext);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ]);
      }
    );
  }

}