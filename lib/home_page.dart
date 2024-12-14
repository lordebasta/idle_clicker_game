import 'package:flutter/material.dart';
import 'package:idle_clicker_game/elements/my_button.dart';
import 'package:idle_clicker_game/elements/text_with_tooltip.dart';
import 'package:idle_clicker_game/my_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  String prettifyDouble(double number) {
    var f = NumberFormat.compact();
    int casted = number.round();
    return f.format(casted);
  }

  String getProgressItaly(double current) {
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
            TextWithTooltip(
              text: 'Sono passati ${state.timePassed.inDays} giorni',
              tooltip:
                  'Tempo passato dall\'inizio della guerra. Un secondo di gioco è un\'ora in gioco',
            ),
            const Header(text: 'Cessi'),
            TextWithTooltip(
              text:
                  'Hai intasato ${prettifyDouble(state.nDefeatedToilets)} cessi. Hai conquistato il ${getProgressItaly(state.nDefeatedToilets)}% dell\'Italia',
              tooltip: '',
            ),
            TextWithTooltip(
              text: 'Hai ${prettifyDouble(state.food as double)} cibo.',
              tooltip:
                  'Il cibo ti serve per continuare la guerra. Per intasare un cesso hai bisogno di uno di cibo.',
            ),
            TextWithTooltip(
              text: 'Hai ${state.fame} punti fama.',
              tooltip:
                  'Più avanzi nella guerra, più fama ottieni. 10 cessi intasati sono uno di fama.',
            ),
            const Divider(),
            TextWithTooltip(
              text: 'Hai ${state.nFollowers} soldati con te.',
              tooltip: 'Ogni soldato intasa un cesso ogni due ore.',
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
