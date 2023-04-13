import 'package:flutter/material.dart';
import 'package:major_try/widgets/player.dart';
import 'package:velocity_x/velocity_x.dart';

class OutputPage extends StatelessWidget {
  final String sentence;
  const OutputPage({super.key, required this.sentence});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "        Aawaj Synthesizer",
          style: TextStyle(
              color: context.primaryColor, fontWeight: FontWeight.w500),
        ),
        iconTheme: IconThemeData(color: context.primaryColor),
        elevation: 1,
        backgroundColor: context.canvasColor,
      ),
      body: MyPlayer(sentence),
    );
  }
}
