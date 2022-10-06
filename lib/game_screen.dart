import 'dart:async';
import 'package:clicker/generated/l10n.dart';
import 'package:clicker/model/game_result.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _clickCount = 0;
  int? _bestScore;
  String _bestPlayerName = "";
  bool _isCounting = false;
  String _currentPlayerName = "";
  final List<GameResult> _results = [];

  final _nameController = TextEditingController();

  _addCountOne() {
    setState(() {
      _clickCount++;
    });
  }

  _start() {
    setState(() {
      _isCounting = true;
      _clickCount = 0;
      Timer(const Duration(seconds: 10), _stopGame);
    });
  }

  _stopGame() {
    setState(() {
      _isCounting = false;
      _results.add(GameResult(name: _currentPlayerName, score: _clickCount));
      _results.sort((a, b) => b.score.compareTo(a.score));

      if (_bestScore == null || _clickCount > _bestScore!) {
        _bestPlayerName = _currentPlayerName;
        _bestScore = _clickCount;
      }
    });
  }

  _currentUserNameChanged(String newUserName) {
    setState(() {
      _currentPlayerName = newUserName;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _separatedList(BuildContext context, int index) {
    return const Divider(thickness: 1);
  }

  Widget _generatedList(BuildContext context, int index) {
    final game = _results[index];
    return ListTile(
      title: Text("Nome du joueur : ${game.name}"),
      subtitle: Text("Score : ${game.score}"),
      trailing: const Icon(Icons.military_tech),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Clicker"),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_isCounting)
                TextField(
                  controller: _nameController,
                  autocorrect: false,
                  onChanged: _currentUserNameChanged,
                ),
              if (_bestScore != null)
                Text(S.current.point_record(_bestPlayerName, _bestScore!)),
              Text(S.current.click_count(_clickCount)),
              if (_isCounting)
                IconButton(
                    onPressed: _addCountOne, icon: const Icon(Icons.plus_one)),
              Expanded(
                child: ListView.separated(
                    itemBuilder: _generatedList,
                    separatorBuilder: _separatedList,
                    itemCount: _results.length),
              ),
              if (!_isCounting)
                ElevatedButton(
                    onPressed: _start,
                    child: Text(S.of(context).game_start_button)),
            ],
          ),
        ));
  }
}
