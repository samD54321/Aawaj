import 'package:flutter/material.dart';
import 'package:major_try/utils/routes.dart';

import '../widgets/choose_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChoosePage(
        firstText: 'Choose the option',
        secondText: 'you want to use:',
        thirdText: 'GO',
        fourthText: 'hands on.',
        fifthText: 'GO',
        sixthText: 'hands free.',
        oneRoute: MyRoutes.handsRoute,
        twoRoute: MyRoutes.handsRoute,
        firstimage: 'assets/images/hand.png',
        secondimage: 'assets/images/eye.png',
      ),
    );
  }
}




// FOR TABLET MODE
//BOX(height:250, width:275,)
//fontsize=30
//sizedbox=100