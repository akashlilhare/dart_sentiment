import 'package:remove_emoji/remove_emoji.dart';
import 'lang/emoji/emoji.dart';
import 'lang/english/english.dart';
import 'lang/french/french.dart';
import 'lang/german/german.dart';
import 'lang/italian/italian.dart';

/// Language code
enum LanguageCode { english, italian, french, german }

/// Sentiment class
class Sentiment {
  /// Analysis function
  ///
  /// syntax:
  ///
  /// ```dart
  ///   analysis(String text,{bool emoji = false, LanguageCode languageCode = LanguageCode.english})
  ///```
  ///<br />
  /// return `Map<String, dynamic>`
  ///
  ///<br />
  /// example:
  /// ```dart
  ///   final sentiment = Sentiment();
  ///   print(sentiment.analysis("The cake she made was terrible 😐", emoji: true));
  ///   // {score: -5, comparative: -0.7142857142857143, tokens: [the, cake, she, made, was, terrible, 😐], positive: [], negative: [[terrible, -3], [😐, -2]]}
  ///   print(sentiment.analysis("I love cats, but I am allergic to them.",));
  ///   //{score: 1, comparative: 0.1111111111111111, tokens: [i, love, cats, but, i, am, allergic, to, them], positive: [[love, 3]], negative: [[allergic, -2]]}
  ///```

  List<String> filterText(String text, bool emoji) {
    List<String> duList = emoji
        ? text
            .toLowerCase()
            .replaceAll('\n', ' ')
            .replaceAll('s\s+', ' ')
            .replaceAll(RegExp(r'[.,\/#!?$%\^&\*;:{}=_`\"~()]'), '')
            .trim()
            .split(' ')
        : text
            .toLowerCase()
            .replaceAll('\n', ' ')
            .replaceAll('s\s+', ' ')
            .replaceAll(RegExp(r'[.,\/#!?$%\^&\*;:{}=_`\"~()]'), '')
            .removemoji
            .trim()
            .split(' ');

    Set<String> duSet = {};
    for (var element in duList) {
      duSet.add(element);
    }

    List<String> analysedList = [];
    for (var element in duSet) {
      analysedList.add(element);
    }

    return analysedList;
  }

  Map<String, dynamic> analysis(String text,
      {bool emoji = false, LanguageCode languageCode = LanguageCode.english}) {
    try {
      if (text.isEmpty) throw ('err');
      Map<dynamic, int> sentiments = {};
      if (emoji) sentiments.addAll(emojis);

      switch (languageCode) {

        /// english
        case LanguageCode.english:
          sentiments.addAll(en);
          break;

      /// italian
        case LanguageCode.italian:
          sentiments.addAll(it);
          break;

      /// french
        case LanguageCode.french:
          sentiments.addAll(fr);
          break;

        /// german
        case LanguageCode.german:
          sentiments.addAll(de);
          break;
        default:
          throw ('err');
      }

      var score = 0;
      var goodwords = [], badwords = [];
      var wordlist = filterText(text, emoji);
      for (var i = 0; i < wordlist.length; i++) {
        sentiments.forEach((key, value) {
          if (key == wordlist[i]) {
            score += value;
            if (value < 0) {
              badwords.add([key, value]);
            } else {
              goodwords.add([key, value]);
            }
          }
        });
      }
      var result = {
        'score': score,
        'comparative': wordlist.isNotEmpty ? score / wordlist.length : 0,
        'tokens': wordlist,
        'positive': goodwords,
        'negative': badwords
      };
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
