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
    /*Player player = new Player();
    player.id = 1;
    player.name = "David";
    player.game=id;
    players.add(player);

    Player player2 = new Player();
    player2.id = 2;
    player2.name = "Romain";
    player2.game=id;
    players.add(player2);


    Player player3 = new Player();
    player3.id = 1;
    player3.name = "Rémi";
    player3.game=id;
    players.add(player3);

    Player player4 = new Player();
    player4.id = 1;
    player4.name = "Rémi";
    player4.game=id;
    players.add(player4);


    Player player5 = new Player();
    player5.id = 1;
    player5.name = "Rémi";
    player5.game=id;
    players.add(player5);

    Player player6 = new Player();
    player6.id = 1;
    player6.name = "Rémi";
    player6.game=id;
    players.add(player6);*/

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