import 'package:flutter/material.dart';
import 'package:major_try/widgets/player.dart';

class OutputPage extends StatelessWidget {
  final String sentence;
  const OutputPage({super.key, required this.sentence});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is Output Page"),
      ),
      body: MyPlayer(sentence),
    );
  }
}
