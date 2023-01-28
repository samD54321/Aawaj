// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:major_try/model/words.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../../../data/words_data.dart';

// class GridViewPage extends StatefulWidget {
//   const GridViewPage({Key? key}) : super(key: key);

//   @override
//   State<GridViewPage> createState() => _GridViewPageState();
// }

// class _GridViewPageState extends State<GridViewPage> {
//   final tappedWords = TextEditingController();
//   List<Words> list = PronounData().pronounList;
//   List<Words> noun = NounData().nounList;
//   List<Words> verb = VerbData().verbList;
//   List<Words> matra = MatraData().matraList;
//   int count = 0;

//   bool isTablet(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 600;

//   bool isMobile(BuildContext context) =>
//       MediaQuery.of(context).size.width < 600;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Tap-Tap Go!"),
//         actions: [const Icon(Icons.add_box).px24()],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Tap Words",
//               style: context.textTheme.headline1,
//             ),
//             Text(
//               " to genetate Text !",
//               style: context.textTheme.headline2,
//             ),
//             const SizedBox(
//               height: 32,
//             ),
//             TextFormField(
//               controller: tappedWords,
//               keyboardType: TextInputType.text,
//               decoration: const InputDecoration(
//                   border: OutlineInputBorder(), hintText: 'Tap Words'),
//             ),
//             const SizedBox(
//               height: 32,
//             ),
//             if (isMobile(context))
//               Expanded(
//                 child: AnimationLimiter(
//                     child: GridView.builder(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 3, childAspectRatio: 3 / 2),
//                         itemCount: list.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return AnimationConfiguration.staggeredGrid(
//                               columnCount: 2,
//                               position: index,
//                               duration: const Duration(milliseconds: 300),
//                               child: ScaleAnimation(
//                                   child: FadeInAnimation(
//                                       delay: const Duration(milliseconds: 100),
//                                       child: listItem(list[index]))));
//                         })),
//               ),
//             if (isTablet(context))
//               Expanded(
//                 child: AnimationLimiter(
//                     child: GridView.builder(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 6, childAspectRatio: 3 / 2),
//                         itemCount: list.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return AnimationConfiguration.staggeredGrid(
//                               columnCount: 2,
//                               position: index,
//                               duration: const Duration(milliseconds: 1000),
//                               child: ScaleAnimation(
//                                   child: FadeInAnimation(
//                                       delay: const Duration(milliseconds: 50),
//                                       child: listItem(list[index]))));
//                         })),
//               ),
//             // ElevatedButton(
//             //   onPressed: () {},
//             //   style: ElevatedButton.styleFrom(
//             //       minimumSize: const Size(double.infinity, 50),
//             //       primary: Colors.purple,
//             //       padding:
//             //           const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//             //       textStyle: const TextStyle(
//             //           fontSize: 22, fontWeight: FontWeight.bold)),
//             //   child: const Text('Next !'),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget listItem(Words words) {
//     return InkWell(
//       splashColor: Colors.blue.withAlpha(30),
//       onLongPress: (() {
//         list = matra;
//         setState(() {});
//         tappedWords.text = "${tappedWords.text} ${words.word}";
//       }),
//       onTap: () {
//         // adding the newly tapped words to the previous words.
//         if (list == matra) {
//           tappedWords.text = "${tappedWords.text}${words.word}";
//         } else {
//           tappedWords.text = "${tappedWords.text} ${words.word}";
//         }
//         count += 1;
//         switch (count) {
//           case 1:
//             list = noun;
//             break;
//           case 2:
//             list = verb;
//             break;
//           // case 3: new page.
//           default:
//         }
//         setState(() {});
//       },
//       child: Card(
//           // elevation: 10,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           child: Center(
//             child: Text(
//               words.word,
//               style: TextStyle(
//                   fontFamily: GoogleFonts.poppins().fontFamily,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold),
//             ),
//           )),
//     );
//   }
// }
