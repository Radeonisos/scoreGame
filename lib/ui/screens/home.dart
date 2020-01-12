import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_games.dart';
import 'package:score_games/blocs/bloc_provider.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/ui/widgets/alert_add_game.dart';
import 'package:score_games/ui/widgets/grid.dart';
import 'package:score_games/ui/widgets/my_appbar.dart';
import 'package:score_games/ui/widgets/no_data.dart';

class Home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BlocGames>(context);

    return Scaffold(
      appBar: MyAppBar(
        titleString: "Listes des parties",
      ),
      body: StreamBuilder<List<Game>>(
        stream: bloc.stream,
        builder: (context, snap) {
          if (snap == null) {
            return NoData("Pas de parties");
          } else if (!snap.hasData) {
            return NoData("Pas de parties");
          } else {
            return Grid(snap.data,bloc);
          }
        },
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AlertAddGame().showDialogAddGame(context, bloc);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

}
