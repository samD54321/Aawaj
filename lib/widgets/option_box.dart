import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OptionBox extends StatelessWidget {
  const OptionBox({
    Key? key,
    required this.route,
    required this.image,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final String route, image, text1, text2;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Container(
            height: height / 5.39,
            width: width / 2.69,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
              ),
              color: context.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        SizedBox(
          height: height / 46.6,
        ),
        Text(text1,
            style: context.textTheme.headline3
                ?.copyWith(color: context.cardColor)),
        Text(
          text2,
          style: context.textTheme.headline4,
        ),
      ],
    );
  }
}
