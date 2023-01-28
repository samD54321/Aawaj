import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_try/model/words.dart';
import 'package:major_try/pages/output_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/words_data.dart';

class NipatPage extends StatefulWidget {
  final TextEditingController tappedWords;
  const NipatPage({Key? key, required this.tappedWords}) : super(key: key);

  @override
  State<NipatPage> createState() => _NipatPageState();
}

class _NipatPageState extends State<NipatPage> {
  final tappedWords = TextEditingController();

  List<Words> verb = NipatData().nipatList;
  List<Words> matra = MatraData().matraList;
  List<Words> list = NipatData().nipatList;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tap-Tap Go!"),
        actions: [const Icon(Icons.add_box).px24()],
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            OutputPage(sentence: widget.tappedWords.text))));
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color.fromARGB(255, 89, 21, 101),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              child: const Text('Speak !'),
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
      //   widget.tappedWords.text = "${widget.tappedWords.text} ${words.word}";
      // }),
      onTap: () {
        // adding the newly tapped words to the previous words.
        if (list == matra) {
          widget.tappedWords.text = "${widget.tappedWords.text}${words.word}";
          list = verb;
        } else {
          widget.tappedWords.text = "${widget.tappedWords.text} ${words.word}";
        }

        // setState(() {});
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: ((context) => OutputPage(
        //             sentence: widget.tappedWords.text.substring(1)))));
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
