import 'package:flutter/material.dart';
import 'package:major_try/widgets/option_box.dart';

import 'heading_text.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({
    Key? key,
    required this.mylist,
  }) : super(key: key);

  final List<String> mylist;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height / 4,
        ),
        HeadingText(firstText: mylist[0], secondText: mylist[1]),
        SizedBox(
          height: height / 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OptionBox(
                route: mylist[6],
                image: mylist[8],
                text1: mylist[2],
                text2: mylist[3]),
            SizedBox(
              width: width / 8,
            ),
            OptionBox(
                route: mylist[7],
                image: mylist[9],
                text1: mylist[4],
                text2: mylist[5]),
          ],
        ),
      ],
    );
  }
}
