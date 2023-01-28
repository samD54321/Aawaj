import 'package:flutter/material.dart';
import 'package:major_try/widgets/option_box.dart';
import 'package:velocity_x/velocity_x.dart';

import 'heading_text.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
    required this.fourthText,
    required this.fifthText,
    required this.sixthText,
    required this.oneRoute,
    required this.twoRoute,
    required this.firstimage,
    required this.secondimage,
  }) : super(key: key);

  final String firstText,
      secondText,
      thirdText,
      fourthText,
      fifthText,
      sixthText,
      oneRoute,
      twoRoute,
      firstimage,
      secondimage;

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
        HeadingText(firstText: firstText, secondText: secondText),
        SizedBox(
          height: height / 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OptionBox(
                route: oneRoute,
                image: firstimage,
                text1: thirdText,
                text2: fourthText),
            SizedBox(
              width: width / 8,
            ),
            OptionBox(
                route: twoRoute,
                image: secondimage,
                text1: fifthText,
                text2: sixthText),
          ],
        ),
      ],
    );
  }
}
