import 'package:transliteration/response/transliteration_response.dart';
import 'package:transliteration/transliteration.dart';

class TranslitAPI {
  static Future<List<String>> getWordSuggestions(String query) async {
    var text = query.split(' ');
    var word = text[text.length - 1];
    TransliterationResponse? response =
        await Transliteration.transliterate(word, Languages.NEPALI);
    return response!.transliterationSuggestions;

    // final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    // final response = await http.get(url);

    // if (response.statusCode == 200) {
    //   final List users = json.decode(response.body);

    //   return users.map((json) => User.fromJson(json)).where((user) {
    //     final nameLower = user.name.toLowerCase();
    //     final queryLower = query.toLowerCase();

    //     return nameLower.contains(queryLower);
    //   }).toList();
    // } else {
    //   throw Exception();
    // }
  }
}
