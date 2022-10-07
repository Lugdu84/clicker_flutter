import 'package:clicker/model/game_result.dart';
import 'package:flutter/material.dart';
import 'package:clicker/generated/l10n.dart';

class HallOfFameView extends StatelessWidget {
  final List<GameResult> results;

  const HallOfFameView({required this.results, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _separatedList(BuildContext context, int index) {
      return const Divider(thickness: 1);
    }

    Widget _generatedList(BuildContext context, int index) {
      final game = results[index];
      return ListTile(
        title: Text(S.of(context).nomeDuJoueurGamename(game.name)),
        subtitle: Text(S.current.score_pamescore_points(game.score)),
        trailing: const Icon(Icons.military_tech),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hall of Fame"),
      ),
      body: ListView.separated(
          itemBuilder: _generatedList,
          separatorBuilder: _separatedList,
          itemCount: results.length),
    );
  }
}
