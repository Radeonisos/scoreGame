import 'dart:async';
import 'package:score_games/bddClient.dart';
import 'package:score_games/models/game.dart';
import 'bloc.dart';

class BlocGames extends Bloc {

  final _streamController = StreamController<List<Game>>();
  
  Sink<List<Game>> get sink => _streamController.sink;
  Stream<List<Game>> get stream => _streamController.stream;

  getAllGame() async {
    final games = await DataBaseClient().allGames();
    sink.add(games);
  }

  BlocGames() {
    getAllGame();
  }

  deleteGame(Game game) async{
    final games = await DataBaseClient().deleteGame(game.id);
    getAllGame();
  }

  addGame(Game game)async{
    final games = await DataBaseClient().upsertGame(game);
    getAllGame();
  }
  
  @override
  dispose() {
    return _streamController.close();
  }


}