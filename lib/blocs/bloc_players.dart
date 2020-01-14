import 'dart:async';
import 'package:score_games/bddClient.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/models/player.dart';
import 'bloc.dart';

class BlocPlayers extends Bloc {

  final _streamController = StreamController<List<Player>>();
  
  Sink<List<Player>> get sink => _streamController.sink;
  Stream<List<Player>> get stream => _streamController.stream;

  addPlayer(Player player) async {
    final players = await DataBaseClient().upsertPlayer(player);
    featchPlayers(player.game);
  }

  featchPlayers(int id) async{
    final players = await DataBaseClient().allPlayersFromGame(id);
    sink.add(players);
  }

  BlocPlayers(int id) {
    featchPlayers(id);
  }

  @override
  dispose() {
    return _streamController.close();
  }


}