import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_games.dart';
import 'package:score_games/blocs/bloc_players.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/models/player.dart';

class AlertAddPlayer {
  String name;
  int gameId;

  AlertAddPlayer(this.gameId);

  addPlayer(String name, BlocPlayers blocPlayers) {
    Player player = new Player();
    player.name = name;
    player.game = gameId;
    blocPlayers.addPlayer(player);
  }

  void showDialogAddGame(BuildContext context, BlocPlayers blocPlayers) {
    showDialog(context:context,
      builder: (BuildContext buildContext) {
        return SimpleDialog(
            contentPadding: EdgeInsets.all(15),
            title: Text("Ajout d'un joueur"),
            children: <Widget>[
              new TextField(
                decoration: InputDecoration(
                  labelText: "Nom: ",
                ),
                onChanged: (String data) {
                  name = data;
                },
                onSubmitted: (String data) {
                  addPlayer(data, blocPlayers);
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
                      addPlayer(name, blocPlayers);
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