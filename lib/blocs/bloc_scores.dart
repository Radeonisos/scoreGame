import 'dart:async';
import 'package:score_games/bddClient.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/models/score.dart';
import 'bloc.dart';

class BlocScores extends Bloc {

  final _streamController = StreamController<List<Score>>.broadcast();
  
  Sink<List<Score>> get sink => _streamController.sink;
  Stream<List<Score>> get stream => _streamController.stream;

  getAllScores(int id) async {
    final scores = await DataBaseClient().allScoreFromPlayer(id);
    sink.add(scores);
  }

  addScore(Score score) async{
    final result = await DataBaseClient().upsertScore(score);
    getAllScores(score.player);
  }

  deleteScore(Score score) async{
    final result = await DataBaseClient().deleteScore(score.id);
    getAllScores(score.player);
  }

  BlocScores(int id) {
    getAllScores(id);
  }

  
  @override
  dispose() {
    return _streamController.close();
  }


}