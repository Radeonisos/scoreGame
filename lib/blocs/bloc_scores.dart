import 'dart:async';
import 'package:score_games/bddClient.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/models/score.dart';
import 'bloc.dart';

class BlocScores extends Bloc {

  final _streamController = StreamController<List<Score>>();
  
  Sink<List<Score>> get sink => _streamController.sink;
  Stream<List<Score>> get stream => _streamController.stream;

  getAllScores(int id) async {
    final scores = await DataBaseClient().allScoreFromPlayer(id);


    for(int i=1; i<20 ;i++){
      Score score = new Score();
      score.id = 1;
      score.point = "${i}";
      score.player = id;

      scores.add(score);
    }

    print(scores.length);
    sink.add(scores);
  }

  BlocScores(int id) {
    getAllScores(id);
  }

  
  @override
  dispose() {
    return _streamController.close();
  }


}