import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:score_games/models/game.dart';
import 'package:score_games/models/player.dart';
import 'package:score_games/models/score.dart';

class DataBaseClient {

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await create();
      return _database;
    }
  }

  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String database_directory = join(directory.path, 'database.db');
    var bdd = await openDatabase(database_directory, version: 1, onCreate: _onCreate);
    return bdd;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE game (
    id INTEGER PRIMARY KEY, 
    name TEXT NOT NULL,
    image TEXT )
    '''
    );

    await db.execute('''
     CREATE TABLE player (
     id INTEGER PRIMARY KEY,
     name TEXT NOT NULL,
     game INTEGER )
     '''
    );

    await db.execute('''
     CREATE TABLE score (
     id INTEGER PRIMARY KEY,
     point TEXT NOT NULL,
     player INTEGER )
     '''
    );
  }


  /* ECRITURE DES DONNEES */

  Future<Game> upsertGame(Game game) async {
    Database maDatabase = await database;
    (game.id == null)
        ? game.id = await maDatabase.insert('game', game.toMap())
        : await maDatabase.update('game', game.toMap(), where: 'id = ?', whereArgs: [game.id]);
    return game;
  }

  Future<Player> upsertPlayer(Player player) async {
    Database maDatabase = await database;
    (player.id == null)
        ? player.id = await maDatabase.insert('player', player.toMap())
        : await maDatabase.update('player', player.toMap(), where: 'id = ?', whereArgs: [player.id]);
    return player;
  }

  Future<Score> upsertScore(Score score) async {
    Database maDatabase = await database;
    (score.id == null)
        ? score.id = await maDatabase.insert('score', score.toMap())
        : await maDatabase.update('score', score.toMap(), where: 'id = ?', whereArgs: [score.id]);
    return score;
  }

  Future<int> deleteGame(int id) async {
    Database maDatabase = await database;
    List<Player> players = await allPlayersFromGame(id);
    players.forEach((p){
      deletePlayer(p.id);
    });
    return await maDatabase.delete('game', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletePlayer(int id) async {
    Database maDatabase = await database;
    await maDatabase.delete('score', where: 'player = ?', whereArgs: [id]);
    return await maDatabase.delete('player', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteScore(int id) async {
    Database maDatabase = await database;
    return await maDatabase.delete('score', where: 'id = ?', whereArgs: [id]);
  }


  /* LECTURE DES DONNEES */
  Future<List<Game>> allGames() async {
    Database maDatabase = await database;
    List<Map<String, dynamic>> result = await maDatabase.rawQuery('SELECT * FROM game');
    List<Game> games =[];
    result.forEach((map) {
      Game game = new Game();
      game.fromMap(map);
      games.add(game);
    });
    return games;
  }

  Future<List<Player>> allPlayersFromGame(int game) async {
    Database maDatabase = await database;
    List<Map<String, dynamic>> result = await maDatabase.query('player', where: 'game = ?', whereArgs: [game]);
    List<Player> players = [];
    result.forEach((map) {
      Player player = new Player();
      player.fromMap(map);
      players.add(player);
    });
    return players;
  }

  Future<List<Score>> allScoreFromPlayer(int player) async {
    Database maDatabase = await database;
    List<Map<String, dynamic>> result = await maDatabase.query('score', where: 'player = ?', whereArgs: [player]);
    List<Score> scores = [];
    result.forEach((map) {
      Score score = new Score();
      score.fromMap(map);
      scores.add(score);
    });
    return scores;
  }

}