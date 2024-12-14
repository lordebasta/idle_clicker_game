import 'package:flutter/material.dart';

class TextWithTooltip extends StatelessWidget {
  final String text;
  final String tooltip;
  const TextWithTooltip({super.key, required this.text, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Text(text),
    );
  }
}
