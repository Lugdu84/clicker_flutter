import 'package:clicker/interfaces/games_local_data_manager.dart';

import 'game.dart';

class GameManager {
  List<Game> _previousGames = [];
  Game? _currentGame;
  static const gamesDuration = 10;
  final GamesLocalDataManager _localDataManager = GamesLocalDataManager();

  Future<List<Game>> loadGameListFromLocalData() async {
    _previousGames = await _localDataManager.getGamesList();
    return _previousGames;
  }

  Game? get currentGame => _currentGame;
  Game? get bestGame {
    if (_previousGames.isEmpty) {
      return null;
    } else {
      return _previousGames.reduce(
          (value, element) => value.score > element.score ? value : element);
    }
  }

  List<Game> get bestGameList {
    final sortedList = List<Game>.from(_previousGames);
    sortedList.sort();
    return sortedList;
  }

  bool get isGameIsProgress {
    final game = _currentGame;
    return game != null && game.isInProgress;
  }

  startNewGame({required String userName}) {
    final newGame = Game(playerName: userName);
    newGame.start();
    _currentGame = newGame;
  }

  stopCurrentGame() {
    final game = _currentGame;
    if (game != null) {
      game.stop();
      _previousGames.add(game);
      _localDataManager.addNewGame(game);
    }
  }
}
