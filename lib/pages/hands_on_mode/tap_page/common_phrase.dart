import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_try/model/words.dart';
import 'package:major_try/pages/hands_on_mode/tap_page/noun_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/words_data.dart';
import 'pronoun_page.dart';

class PhrasePage extends StatefulWidget {
  const PhrasePage({Key? key}) : super(key: key);

  @override
  State<PhrasePage> createState() => _PhrasePageState();
}

class _PhrasePageState extends State<PhrasePage> {
  final tappedWords = TextEditingController();

  List<Words> common = CommonPhrase().commonPhrase;
  List<Words> matra = MatraData().matraList;
  List<Words> list = CommonPhrase().commonPhrase;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tap Words to generate text"),
        actions: [const Icon(Icons.add_box).px24()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Tap Words",
            //   style: context.textTheme.headline1,
            // ),
            // Text(
            //   " to generate Text !",
            //   style: context.textTheme.headline2,
            // ),
            SizedBox(
              height: height / 32,
            ),
            TextFormField(
              controller: tappedWords,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Tap Words'),
            ),
            SizedBox(
              height: height / 32,
            ),

            Expanded(
              child: AnimationLimiter(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, childAspectRatio: 9 / 2),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: ScaleAnimation(
                                child: FadeInAnimation(
                                    delay: const Duration(milliseconds: 100),
                                    child: listItem(list[index]))));
                      })),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            PronounPage(tappedWords: tappedWords))));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color.fromARGB(255, 89, 21, 101),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              child: const Text('Next !'),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(Words words) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      // onLongPress: (() {
      //   list = matra;
      //   setState(() {});
      //   tappedWords.text = "${tappedWords.text} ${words.word}";
      // }),
      onTap: () {
        // adding the newly tapped words to the previous words.
        if (list == matra) {
          tappedWords.text = "${tappedWords.text}${words.word}";
          list = common;
        } else {
          tappedWords.text = "${tappedWords.text} ${words.word}";
        }

        // setState(() {});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => PronounPage(tappedWords: tappedWords))));
      },
      child: Card(
          // elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              words.word,
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
