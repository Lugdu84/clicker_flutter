import 'dart:async';
import 'package:clicker/generated/l10n.dart';
import 'package:clicker/view/hall_of_fame_screen.dart';
import 'package:flutter/material.dart';
import '../model/game_manager.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final gameManager = GameManager();
  final _nameController = TextEditingController();
  String _currentName = "";

  _addCountOne() {
    setState(() {
      gameManager.currentGame?.userScored();
    });
  }

  _start() {
    setState(() {
      gameManager.startNewGame(userName: _currentName);
      Timer(Duration(seconds: GameManager.gamesDuration), _stopGame);
    });
  }

  _stopGame() {
    setState(() {
      gameManager.stopCurrentGame();
    });
  }

  _currentUserNameChanged(String newUserName) {
    setState(() {
      _currentName = newUserName;
    });
  }

  _showHallOfFame(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HallOfFameScreen(
        games: gameManager.bestGameList,
      );
    }));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Widget _separatedList(BuildContext context, int index) {
  //   return const Divider(thickness: 1);
  // }

  // Widget _generatedList(BuildContext context, int index) {
  //   final game = _results[index];
  //   return ListTile(
  //     title: Text(S.of(context).nomeDuJoueurGamename(game.name)),
  //     subtitle: Text(S.current.score_pamescore_points(game.score)),
  //     trailing: const Icon(Icons.military_tech),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final bestGame = gameManager.bestGame;
    final currentGame = gameManager.currentGame;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Clicker"),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!gameManager.isGameIsProgress)
                TextField(
                  decoration: InputDecoration(
                      hintText: S.of(context).enterYourNickname),
                  controller: _nameController,
                  autocorrect: false,
                  onChanged: _currentUserNameChanged,
                ),
              if (bestGame != null)
                Text(S.current
                    .point_record(bestGame.playerName, bestGame.score)),
              if (currentGame != null)
                Text(S.current.click_count(currentGame.score)),
              if (gameManager.isGameIsProgress)
                IconButton(
                    onPressed: _addCountOne, icon: const Icon(Icons.plus_one)),
              if (!gameManager.isGameIsProgress)
                ElevatedButton(
                    onPressed: () => _showHallOfFame(context),
                    child: Text(S.of(context).hallOfFame)),
              const Spacer(),
              if (!gameManager.isGameIsProgress)
                ElevatedButton(
                    onPressed: _start,
                    child: Text(S.of(context).game_start_button)),
            ],
          ),
        ));
  }
}
