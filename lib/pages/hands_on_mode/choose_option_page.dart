import 'package:flutter/material.dart';

import '../../utils/routes.dart';
import '../../widgets/choose_page.dart';

class HandsOn extends StatelessWidget {
  const HandsOn({Key? key}) : super(key: key);
  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChoosePage(
        firstText: 'Choose the way',
        secondText: 'you want to give input:',
        thirdText: 'Tap-Tap',
        fourthText: 'GO !',
        fifthText: 'Type',
        sixthText: 'and GO!',
        oneRoute: MyRoutes.tapRoute,
        twoRoute: MyRoutes.typeRoute,
        firstimage: 'assets/images/tap-tap.png',
        secondimage: 'assets/images/type.png',
      ),
    );
  }
}
