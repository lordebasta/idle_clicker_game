import 'package:flutter/material.dart';
import 'package:idle_clicker_game/elements/my_button.dart';
import 'package:idle_clicker_game/my_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  var f = NumberFormat.compact();

  String getProgressItaly(int current) {
    double percentile = current / StateModel.toiletsInItaly * 100;
    return percentile.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(
      builder: (context, state, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sono passati ${state.timePassed.inDays} giorni',
            ),
            const Header(text: 'Cessi'),
            Text(
              'Hai intasato ${f.format(state.nDefeatedToilets)} cessi. Hai conquistato il ${getProgressItaly(state.nDefeatedToilets)}% dell\'Italia',
            ),
            Text(
              'Hai ${f.format(state.food)} cibo.',
            ),
            Text(
              'Hai ${state.fame} punti fama.',
            ),
            const Divider(),
            Text(
              'Hai ${state.nFollowers} soldati con te.',
            ),
            MyButton(
              enabled: false,
              onPressed: () {
                state.hireFollowers(1);
              },
              text:
                  'Assolda un nuovo soldato (costo: ${StateModel.followerCost} punti fama)',
            )
          ],
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  final String text;
  const Header({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            height: 0.5,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
