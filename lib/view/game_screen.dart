import 'dart:async';
import 'package:clicker/generated/l10n.dart';
import 'package:clicker/view/hall_of_fame_screen.dart';
import 'package:flutter/material.dart';
import '../model/game_manager.dart';

class GameScreen extends StatelessWidget {
  final gameManager = GameManager();

  GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Clicker"),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: gameManager.loadGameListFromLocalData(),
            builder: (context, snapshot) {
              if (snapshot.hasData || snapshot.hasError) {
                return _GameScreenContent(
                  gameManager: gameManager,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}

class _GameScreenContent extends StatefulWidget {
  final GameManager gameManager;
  const _GameScreenContent({Key? key, required this.gameManager})
      : super(key: key);

  @override
  _GameScreenContentState createState() => _GameScreenContentState();
}

class _GameScreenContentState extends State<_GameScreenContent> {
  final _nameController = TextEditingController();
  String _currentName = "";

  _addCountOne() {
    setState(() {
      widget.gameManager.currentGame?.userScored();
    });
  }

  _start() {
    setState(() {
      widget.gameManager.startNewGame(userName: _currentName);
      Timer(Duration(seconds: GameManager.gamesDuration), _stopGame);
    });
  }

  _stopGame() {
    setState(() {
      widget.gameManager.stopCurrentGame();
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
        games: widget.gameManager.bestGameList,
      );
    }));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bestGame = widget.gameManager.bestGame;
    final currentGame = widget.gameManager.currentGame;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!widget.gameManager.isGameIsProgress)
          TextField(
            decoration:
                InputDecoration(hintText: S.of(context).enterYourNickname),
            controller: _nameController,
            autocorrect: false,
            onChanged: _currentUserNameChanged,
          ),
        if (bestGame != null)
          Text(S.current.point_record(bestGame.playerName, bestGame.score)),
        if (currentGame != null) Text(S.current.click_count(currentGame.score)),
        if (widget.gameManager.isGameIsProgress)
          IconButton(onPressed: _addCountOne, icon: const Icon(Icons.plus_one)),
        if (!widget.gameManager.isGameIsProgress)
          ElevatedButton(
              onPressed: () => _showHallOfFame(context),
              child: Text(S.of(context).hallOfFame)),
        const Spacer(),
        if (!widget.gameManager.isGameIsProgress)
          ElevatedButton(
              onPressed: _start, child: Text(S.of(context).game_start_button)),
      ],
    );
  }
}
