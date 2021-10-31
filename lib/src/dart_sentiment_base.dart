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
  /// syntax `analysis(String text,{Map customLang, bool emoji = false, String languageCode})`
  ///
  /// return `Map<String, dynamic>`
  ///
  /// example:
  /// ```dart
  ///  final sentiment = Sentiment();
  ///  print(sentiment.analysis('i hate you piece of shit 💩'));
  /// // {score: -7, comparative: -1.1666666666666667, words: [i, hate, you, piece, of, shit], good words: [], badword: [[hate, -3], [shit, -4]]}
  ///```
  Map<String, dynamic> analysis(String text,
      {bool emoji = false, LanguageCode languageCode = LanguageCode.english}) {
    try {
      if (text.isEmpty) throw ('err');
      // languageCode ??= LanguageCode.english;
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
      var wordlist = emoji
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
        'words': wordlist,
        'good words': goodwords,
        'badword': badwords
      };
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}


