import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_players.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/ui/widgets/alert_add_player.dart';


class AppBarGame extends AppBar {
  final Game game;
  final BlocPlayers blocPlayers;
  BuildContext context;

  AppBarGame({@required this.game, @required this.blocPlayers,@required this.context}): super (
      title: Text(game.name),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.person_add),
          onPressed: () {
            AlertAddPlayer(game.id).showDialogAddGame(context, blocPlayers);
          },
        )
        ],
      centerTitle: true
  );
}