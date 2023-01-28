import 'package:major_try/model/words.dart';

class PronounData {
  final List<Words> _pronounList = <Words>[
    Words(word: 'म'),
    Words(word: 'मेरो'),
    Words(word: 'हामी'),
    Words(word: 'हाम्रो'),
    Words(word: 'तँ'),
    Words(word: 'तेरो'),
    Words(word: 'तिमी'),
    Words(word: 'तिम्रो'),
    Words(word: 'तपाईँ'),
    Words(word: 'हजुर'),
    Words(word: 'ऊ'),
    Words(word: 'उस्को'),
    Words(word: 'उनी'),
    Words(word: 'उहाँ'),
    Words(word: 'राम'),
    Words(word: 'सिता'),
    Words(word: 'सम्पन्न'),
    Words(word: 'निशा'),
  ];

  List<Words> get pronounList => _pronounList;
}

class NounData {
  final List<Words> _nounList = <Words>[
    Words(word: 'खाना'),
    Words(word: 'रोटी'),
    Words(word: 'पानी'),
    Words(word: 'हाथ'),
    Words(word: 'खुट्टा'),
    Words(word: 'मुख'),
    Words(word: 'निद्रा'),
    Words(word: 'भोक'),
    Words(word: 'तिर्खा'),
    Words(word: 'चर्पी'),
    Words(word: 'स्कुल'),
    Words(word: 'घर'),
    Words(word: 'कोठा'),
    Words(word: 'कता'),
    Words(word: 'किन'),
    Words(word: 'कलेज'),
    Words(word: 'पसल')
  ];

  List<Words> get nounList => _nounList;
}

class VerbData {
  final List<Words> _verbList = <Words>[
    Words(word: 'खानु'),
    Words(word: 'खान्छु'),
    Words(word: 'खानेछु'),
    Words(word: 'जानु'),
    Words(word: 'जान्छु'),
    Words(word: 'जानेछु'),
    Words(word: 'लानु'),
    Words(word: 'लान्छु'),
    Words(word: 'लानेछु'),
    Words(word: 'धुनु'),
    Words(word: 'धुन्छु'),
    Words(word: 'धुनेछु'),
    Words(word: 'पढ्नु'),
    Words(word: 'पढ्छु'),
    Words(word: 'पढ्नेछु'),
    Words(word: 'गर्नु'),
    Words(word: 'गर्छु'),
    Words(word: 'गर्नेछु'),
  ];

  List<Words> get verbList => _verbList;
}

class MatraData {
  final List<Words> _matraList = <Words>[
    Words(word: 'लाई'),
    Words(word: 'रो'),
    Words(word: 'री'),
    Words(word: 'को'),
    Words(word: 'की'),
    Words(word: 'हरु'),
    Words(word: 'द्वरा'),
    Words(word: 'बाट'),
    Words(word: 'सँग'),
  ];

  List<Words> get matraList => _matraList;
}

class NipatData {
  final List<Words> _nipatList = <Words>[
    Words(word: 'हो'),
    Words(word: 'छ'),
    Words(word: 'नि'),
    Words(word: 'पो'),
    Words(word: 'त'),
    Words(word: 'है'),
  ];

  List<Words> get nipatList => _nipatList;
}

class CommonPhrase {
  final List<Words> _commonPhrase = <Words>[
    Words(word: 'नमस्ते'),
    Words(word: 'के छ हाल खबर?'),
    Words(word: 'सन्चै छौ?'),
    Words(word: 'मेरो नाम सम्पन्न हो'),
  ];

  List<Words> get commonPhrase => _commonPhrase;
}
