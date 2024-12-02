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

  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(
      builder: (context, state, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Header(text: 'Cessi'),
            Text(
              'Hai intasato ${f.format(state.nDefeatedToilets)} cessi.',
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
