# Dart Sentiment

#### AFINN-based sentiment analysis for dart

Sentiment is a dart package that uses
the  [AFINN-165](http://www2.imm.dtu.dk/pubdb/views/publication_details.php?id=6010)  wordlist
and  [Emoji Sentiment Ranking](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0144296)
to perform  [sentiment analysis](http://en.wikipedia.org/wiki/Sentiment_analysis)  on arbitrary
blocks of input text. Sentiment provides several things:

- Provide Language suport for English, Italian, French and German
- Provide suport for various emojis
- On the basis of analysis of text, provide an integer value in the range -n to +n

## Installation

Add this line to your pubspec.yaml and run `flutter pub get` command to activate the package

```  
dependencies:  
	dart_sentiment: latest_version
 ```  

## Example

```dart  
import 'package:dart_sentiment/dart_sentiment.dart';  
  
void main() {  
  final sentiment = Sentiment();  
  
  print(sentiment.analysis("The cake she made was terrible 😐"));  
  
  print(sentiment.analysis("The cake she made was terrible 😐", emoji: true));  
  
  print(sentiment.analysis("I love cats, but I am allergic to them.",));  
  
  print(sentiment.analysis("J'adore les chats, mais j'y suis allergique.",  
  languageCode: LanguageCode.french));  
  
  print(sentiment.analysis("Le gâteau qu'elle a fait était horrible 😐",  
  emoji: true, languageCode: LanguageCode.french));  
}

```  
### Function defination
Param | Description
-------- | -----  
`String text` | Input phrase to analyze
`bool emoji = false` | Input emoji is present in the phrase to analyze
`LanguageCode languageCode = LanguageCode.english` |Language to use for sentiment analysis. ` LanguageCode { english, italian, french, german }`

## How it works

### [](https://github.com/thisandagain/sentiment#afinn)AFINN

AFINN is a list of words rated for valence with an integer between minus five (negative) and plus
five (positive). Sentiment analysis is performed by cross-checking the string tokens (words, emojis)
with the AFINN list and getting their respective scores. The comparative score is
simply:  `sum of each token / number of tokens`. So for example let's take the following:

`I love cats, but I am allergic to them.`

That string results in the following:

```dart  
{
	score: 1,  
	comparative: 0.1111111111111111,  
	tokens: [  
		"i",  
		"love",  
		"cats",  
		"but",  
		"i",  
		"am",  
		"allergic",  
		"to",  
		"them"  
	],  
	positive: [[love, 3]],  
	negative: [[allergic, 2]]  
}  
```  

- Returned Objects
    - **Score**: Score calculated by adding the sentiment values of recognized words.
    - **Comparative**: Comparative score of the input string.
    - **Calculation**: An array of words that have a negative or positive valence with their
      respective AFINN score.
    - **Token**: All the tokens like words or emojis found in the input string.
    - **Words**: List of words from input string that were found in AFINN list.
    - **Positive**: List of positive words in input string that were found in AFINN list.
    - **Negative**: List of negative words in input string that were found in AFINN list.

In this case, love has a value of 3, allergic has a value of -2, and the remaining tokens are
neutral with a value of 0. Because the string has 9 tokens the resulting comparative score looks
like:  `(3 + -2) / 9 = 0.111111111`

This approach leaves you with a mid-point of 0 and the upper and lower bounds are constrained to
positive and negative 5 respectively. For example, let's imagine an incredibly "positive" string
with 200 tokens and where each token has an AFINN score of 5. Our resulting comparative score would
look like this:

```  
(max positive score * number of tokens) / number of tokens  
(5 * 200) / 200 = 5  
```