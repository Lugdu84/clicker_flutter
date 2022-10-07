import 'package:clicker/model/game.dart';
import 'package:flutter/material.dart';
import 'package:clicker/generated/l10n.dart';

class HallOfFameScreen extends StatelessWidget {
  final List<Game> _games;

  const HallOfFameScreen({required games, Key? key})
      : _games = games,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _separatedList(BuildContext context, int index) {
      return const Divider(thickness: 1);
    }

    Widget _generatedList(BuildContext context, int index) {
      final game = _games[index];
      return ListTile(
        title: Text(S.of(context).nomeDuJoueurGamename(game.playerName)),
        subtitle: Text(S.current.score_pamescore_points(game.score)),
        trailing: const Icon(Icons.military_tech),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).hallOfFame),
      ),
      body: ListView.separated(
          itemBuilder: _generatedList,
          separatorBuilder: _separatedList,
          itemCount: _games.length),
    );
  }
}
