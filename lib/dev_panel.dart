import 'package:flutter/material.dart';
import 'package:idle_clicker_game/my_provider.dart';
import 'package:provider/provider.dart';

class DevPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<StateModel>(builder: (context, state, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VariableShower(
              varName: 'fame',
              variable: state.fame,
            ),
            VariableShower(
              varName: 'fameIncrementCounter',
              variable: state.fameIncrementCounter,
            ),
          ],
        );
      }),
    );
  }
}

class VariableShower extends StatelessWidget {
  String varName;
  var variable;
  VariableShower({
    super.key,
    required this.varName,
    required this.variable,
  });

  @override
  Widget build(BuildContext context) {
    return Text('$varName: ${variable.toString()}');
  }
}
