import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    Key? key,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);

  final String firstText, secondText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          firstText,
          style: context.textTheme.displayLarge,
          textAlign: TextAlign.justify,
        ),
        Text(
          secondText,
          style: context.textTheme.displayMedium,
        ),
      ],
    ).px32();
  }
}
