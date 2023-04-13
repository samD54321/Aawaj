import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../api/transliteration_api.dart';
import '../../../data/words_data.dart';
import 'pronoun_page.dart';

class PhrasePage extends StatefulWidget {
  const PhrasePage({Key? key}) : super(key: key);

  @override
  State<PhrasePage> createState() => _PhrasePageState();
}

class _PhrasePageState extends State<PhrasePage> {
  final tappedWords = TextEditingController();

  List<String> common = commonPhrase;
  List<String> matra = matraList;
  // List<String> list = commonPhrase;

  // final field used for transliteration
  final formKey = GlobalKey<FormState>();
  final controllerWord = TextEditingController();
  final controllerInt = TextEditingController();
  String? selectedWord;

  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //reference our box
    final myBox = Hive.box("hive_box");
    List list = myBox.values.toList();

    // write data
    void addData(String myPhrase) {
      myBox.add(myPhrase);
    }

    //delete data
    void removeData(int key) {
      myBox.deleteAt(key);
    }

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Aawaj",
            style: TextStyle(
                color: context.primaryColor, fontWeight: FontWeight.w500),
          ),
        ),
        iconTheme: IconThemeData(color: context.primaryColor),
        elevation: 1,
        backgroundColor: context.canvasColor,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Enter your phrase"),
                    content: Form(
                      key: formKey,
                      child: TypeAheadField<String?>(
                        hideOnError: true,
                        hideKeyboard: false,
                        hideSuggestionsOnKeyboardHide: false,
                        textFieldConfiguration: TextFieldConfiguration(
                          style: TextStyle(color: context.primaryColor),
                          autocorrect: false,
                          controller: controllerWord,
                          autofocus: true,
                          focusNode: myFocusNode,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: context.primaryColor),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: context.primaryColor),
                            ),
                          ),
                        ),
                        suggestionsCallback: TranslitAPI.getWordSuggestions,
                        itemBuilder: (context, String? suggestion) {
                          final word = suggestion!;

                          return ListTile(
                            textColor: context.cardColor,
                            title: Text(
                              word,
                              style: TextStyle(color: context.primaryColor),
                            ),
                          );
                        },
                        noItemsFoundBuilder: (context) => const SizedBox(
                          height: 60,
                          child: Center(
                            child: Text(
                              'No words detected',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        onSuggestionSelected: (String? suggestion) {
                          var lis = controllerWord.text.split(' ');

                          var nayaList =
                              lis.getRange(0, lis.length - 1).join(" ");

                          controllerWord.text = "$nayaList ${suggestion!} ";

                          Future.delayed(const Duration(milliseconds: 1), () {
                            myFocusNode.requestFocus();
                          });
                        },
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(context.primaryColor),
                        ),
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(context.primaryColor),
                        ),
                        child: const Text("Save"),
                        onPressed: () {
                          addData(controllerWord.text);
                          Navigator.of(context).pop();

                          setState(() {});
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Ionicons.add_circle_outline,
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Enter the index (e.g: 3)"),
                    content: TextFormField(
                      controller: controllerInt,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an integer';
                        }
                        return null;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(context.primaryColor),
                        ),
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(context.primaryColor),
                        ),
                        child: const Text("Delete"),
                        onPressed: () {
                          removeData(int.parse(controllerInt.text) - 1);
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Ionicons.trash_outline,
            ),
          )
        ],
      ),

      //body starts here.
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height / 32,
            ),
            TextFormField(
              controller: tappedWords,
              keyboardType: TextInputType.text,
              style: TextStyle(color: context.primaryColor),
              decoration: InputDecoration(
                hintText: 'Tap Words',
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
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: context.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: Text(
                'Next !',
                style: TextStyle(
                  color: context.canvasColor,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(String word) {
    return InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        // adding the newly tapped words to the previous words.
        tappedWords.text = "${tappedWords.text} $word";

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => PronounPage(tappedWords: tappedWords)),
          ),
        );
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
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}
