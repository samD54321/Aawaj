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
        mylist: [
          'Choose your',
          'mode of input:',
          'Tap-Tap',
          'GO !',
          'Type',
          'and GO!',
          MyRoutes.tapRoute,
          MyRoutes.typeRoute,
          'assets/images/tap-tap.png',
          'assets/images/type.png',
        ],
      ),
    );
  }
}
