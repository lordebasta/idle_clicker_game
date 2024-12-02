import 'package:flutter/material.dart';

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
