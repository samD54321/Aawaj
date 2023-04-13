import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:major_try/widgets/heading_text.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../api/transliteration_api.dart';
import '../../output_page.dart';

class TypePage extends StatefulWidget {
  const TypePage({Key? key}) : super(key: key);

  @override
  State<TypePage> createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  final formKey = GlobalKey<FormState>();
  final controllerWord = TextEditingController();
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
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Aawaj",
          style: TextStyle(
              color: context.primaryColor, fontWeight: FontWeight.w500),
        ),
        iconTheme: IconThemeData(color: context.primaryColor),
        elevation: 1,
        backgroundColor: context.canvasColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: height / 8,
            ),
            const HeadingText(
                firstText: "Type Words", secondText: " to Speak !"),
            SizedBox(
              height: height / 32,
            ),
            Form(
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
                      borderSide: BorderSide(color: context.primaryColor),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: context.primaryColor),
                    ),
                    prefixIcon: const Icon(Icons.keyboard_alt_outlined),
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
                  // print(suggestion);
                  var lis = controllerWord.text.split(' ');

                  var nayaList = lis.getRange(0, lis.length - 1).join(" ");

                  controllerWord.text = "$nayaList ${suggestion!} ";

                  Future.delayed(const Duration(milliseconds: 1), () {
                    myFocusNode.requestFocus();
                  });
                },
              ),
            ).px16(),
            SizedBox(
              height: height / 2,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            OutputPage(sentence: controllerWord.text))));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor),
              child: const Text(
                "Speak",
                style: TextStyle(fontSize: 25),
              ).py16(),
            ).px24(),
          ],
        ),
      ),
    );
  }
}
