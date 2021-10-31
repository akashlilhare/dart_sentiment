import 'package:dart_sentiment/dart_sentiment.dart';

void main() {
  final sentiment = Sentiment();
  print(sentiment.analysis(
    'i love dart',
  ));

  print(sentiment.analysis('i hate you piece of shit 💩'));

  print(sentiment.analysis('i hate you piece of shit 💩', emoji: true));

  print(sentiment.analysis('ti odio un pezzo di merda 💩',
      languageCode: LanguageCode.italian));

  print(sentiment.analysis('ti odio un pezzo di merda 💩',
      emoji: true, languageCode: LanguageCode.italian));

  print(sentiment.analysis('je te déteste merde 💩',
      languageCode: LanguageCode.french));

  print(sentiment.analysis('je te déteste merde 💩',
      emoji: true, languageCode: LanguageCode.french));
}
