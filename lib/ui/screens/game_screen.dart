import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_players.dart';
import 'package:score_games/blocs/bloc_provider.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/models/player.dart';
import 'package:score_games/ui/widgets/appbar_game.dart';
import 'package:score_games/ui/widgets/list_players.dart';
import 'package:score_games/ui/widgets/no_data.dart';

class GameScreen extends StatelessWidget {

  Game game;

  GameScreen(this.game);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocPlayers>(context);

    return Scaffold(
      appBar: AppBarGame(game: game,blocPlayers: bloc,context: context,),
      backgroundColor: Colors.grey,
      body: StreamBuilder<List<Player>>(
        stream: bloc.stream,
        builder: (context, snap) {
          if (snap == null) {
            return NoData("Pas de parties");
          } else if (!snap.hasData) {
            return NoData("Pas de parties");
          } else {
            return ListPlayers(snap.data,bloc);
          }
        },
      ),
    );
  }

}