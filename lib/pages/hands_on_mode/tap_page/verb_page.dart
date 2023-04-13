import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/words_data.dart';
import '../../output_page.dart';
import 'nipat_page.dart';

class VerbPage extends StatefulWidget {
  final TextEditingController tappedWords;
  const VerbPage({
    Key? key,
    required this.tappedWords,
  }) : super(key: key);

  @override
  State<VerbPage> createState() => _VerbPageState();
}

class _VerbPageState extends State<VerbPage> {
  List<String> noun = verbList;
  List<String> matra = matraList;
  List<String> list = verbList;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tap-Tap Go!"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height / 32,
            ),
            TextFormField(
              controller: widget.tappedWords,
              keyboardType: TextInputType.none,
              style: TextStyle(color: context.primaryColor),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: context.primaryColor),
                ),
              ),
            ),
            SizedBox(
              height: height / 32,
            ),
            Expanded(
              child: AnimationLimiter(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 3 / 2),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration: const Duration(milliseconds: 300),
                            child: ScaleAnimation(
                                child: FadeInAnimation(
                                    delay: const Duration(milliseconds: 100),
                                    child: listItem(list[index]))));
                      })),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => OutputPage(
                                sentence: widget.tappedWords.text))));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 50),
                      backgroundColor: const Color.fromARGB(255, 89, 21, 101),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  child: const Text('Speak !'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                NipatPage(tappedWords: widget.tappedWords))));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 50),
                      backgroundColor: const Color.fromARGB(255, 89, 21, 101),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  child: const Text('Next !'),
                ),
              ],
            ).py8(),
          ],
        ),
      ),
    );
  }

  Widget listItem(String word) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onLongPress: (() {
        list = matra;
        setState(() {});
        widget.tappedWords.text = "${widget.tappedWords.text} $word";
      }),
      onTap: () {
        // adding the newly tapped words to the previous words.
        if (list == matra) {
          widget.tappedWords.text = "${widget.tappedWords.text}$word";
          list = noun;
        } else {
          widget.tappedWords.text = "${widget.tappedWords.text} $word";
        }

        // setState(() {});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    NipatPage(tappedWords: widget.tappedWords))));
      },
      child: Card(
          // elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              word,
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
