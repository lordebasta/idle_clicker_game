import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idle_clicker_game/elements/my_button.dart';
import 'package:idle_clicker_game/home_page.dart';
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
      home: const MainClass(title: 'LA GUERRA - l\'idle game'),
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

  void runGameLoop(int deltaInMs) {
    context.read<StateModel>().runGameLoop(deltaInMs);
  }

  @override
  void initState() {
    super.initState();
    int deltaInMs = 10;
    timer = Timer.periodic(
      Duration(milliseconds: deltaInMs),
      (Timer t) => runGameLoop(deltaInMs),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 8,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    title: Text(widget.title),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HomePage(),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () =>
                        {context.read<StateModel>().destroyToilets(1)},
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ), // This trailing comma makes auto-formatting nicer for build methods.
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
      ],
    );
  }
}
