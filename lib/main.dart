import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idle_clicker_game/my_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => StateModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainClass(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainClass extends StatefulWidget {
  const MainClass({super.key, required this.title});
  final String title;

  @override
  State<MainClass> createState() => _MainClassState();
}

class _MainClassState extends State<MainClass> {
  Timer? timer;

  void _incrementCounter() {
    Provider.of<StateModel>(context, listen: false).nDefeatedToilets += 1;
  }

  void runGameLoop() {
    context.read<StateModel>().runGameLoop();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => runGameLoop(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: HomePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {context.read<StateModel>().destroyToilets(1)},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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
            Text(
              'You have destroyed ${f.format(state.nDefeatedToilets)} toilets.',
            ),
            Text(
              'You have gained ${state.fame} fame points.',
            ),
            const Divider(),
            Text(
              'You have ${state.nFollowers} followers.',
            ),
            MyButton(
                enabled: false,
                onPressed: () {
                  state.hireFollowers(1);
                },
                text:
                    'Hire a new follower (cost: ${StateModel.followerCost} fame points)')
          ],
        );
      },
    );
  }
}

class MyButton extends StatelessWidget {
  final bool enabled;
  final Function onPressed;
  final String text;

  const MyButton(
      {super.key,
      required this.enabled,
      required this.onPressed,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      child: Text(text),
    );
  }
}
