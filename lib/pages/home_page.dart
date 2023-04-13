import 'package:flutter/material.dart';
import 'package:major_try/utils/routes.dart';

import '../widgets/choose_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChoosePage(
        mylist: [
          'Choose the option',
          'you want to use:',
          'GO',
          'hands on.',
          'GO',
          'hands free.',
          MyRoutes.handsRoute,
          MyRoutes.handsRoute,
          'assets/images/hand.png',
          'assets/images/eye.png',
        ],
      ),
    );
  }
}




// FOR TABLET MODE
//BOX(height:250, width:275,)
//fontsize=30
//sizedbox=100