import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_games.dart';
import 'package:score_games/blocs/bloc_players.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/ui/screens/game_screen.dart';
import 'package:score_games/ui/screens/home.dart';

import 'bloc_provider.dart';


class BlocRouter {


  MaterialPageRoute gameDetail(Game g) => MaterialPageRoute(builder: (ctx)=> game(g));


  BlocProvider allGames() => BlocProvider<BlocGames>(bloc: BlocGames(), child: Home());

  BlocProvider game(Game game) => BlocProvider<BlocPlayers>(bloc: BlocPlayers(game.id), child: GameScreen(game));




}