import 'package:flutter/material.dart';
import 'package:score_games/blocs/bloc_games.dart';
import 'package:score_games/blocs/bloc_router.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/ui/widgets/text_alternate.dart';

class CardGame extends StatelessWidget {
  Game game;
  BlocGames bloc;

  CardGame(this.game, this.bloc);

  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textFieldController.text = game.name;
    final width = MediaQuery.of(context).size.width / 2.5;
    return Card(
        margin: EdgeInsets.all(10),
        elevation: 0,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(BlocRouter().gameDetail(game));
          },
          child: Column(
            children: <Widget>[
              Card(
                elevation: 7.5,
                child: Container(
                  height: 100,
                  width: width,
                ),
              ),
              Container(
                width: width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.view_carousel),
                      TextAlternate(
                        string: game.name,
                        alternate: 'nom de la partie',
                        size: 15,
                        align: TextAlign.center,
                      ),
                      PopupMenuButton<int>(
                        tooltip: "options de la partie",
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: InkWell(
                                onTap: () {
                                  //edit name
                                  print('onTap');
                                  _displayDialog(context);
                                },
                                child: TextAlternate(
                                  string: "Nom",
                                  align: TextAlign.start,
                                )),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: InkWell(
                                onTap: () {
                                  bloc.deleteGame(game);
                                  Navigator.pop(context);
                                },
                                child: TextAlternate(
                                  string: "Supprimer",
                                  align: TextAlign.start,
                                )),
                          ),
                        ],
                      )
                    ]),
              )
            ],
          ),
        )
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (contextDialog) {
          return AlertDialog(
            title: Text('Nom de la partie'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Nom"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  game.name = _textFieldController.text;
                  bloc.addGame(game);
                  Navigator.of(contextDialog).pop();
                },
              )
            ],
          );
        });
  }
}
