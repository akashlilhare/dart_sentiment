

# Dart Sentiment

![Flutter Community: dart_sentiment](https://fluttercommunity.dev/_github/header/dart_sentiment)


![pub package](https://img.shields.io/pub/v/dart_sentiment.svg)      ![](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)


#### AFINN-based sentiment analysis for dart

Dart Sentiment is a dart package that uses  
the  [AFINN-165](https://github.com/fnielsen/afinn/blob/master/afinn/data/AFINN-en-165.txt)  
wordlist  
and  [Emoji Sentiment Ranking](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0144296)  
to perform  [sentiment analysis](https://en.wikipedia.org/wiki/Sentiment_analysis)  on arbitrary  
blocks of input text. Dart Sentiment provides several things:
- Provide Language support for English, Italian, French and German.
- Provide support for various emojis.
- Based on analysis of text, provide an integer value in the range -n to +n (see details below)

## Installation
add following dependency to your `pubspec.yaml`
```yaml  
  
dependencies:    
   dart_sentiment: <latest-version>  
   
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

### AFINN

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

``` (max positive score * number of tokens) / number of tokens (5 * 200) / 200 = 5 ```

## Contribute

If you have any suggestions, improvements or issues, feel free to contribute to this project. You  
can either submit a new issue or propose a pull request. Direct your pull requests into the dev  
branch.

## License

Dart Sentiment is released under  
the  [MIT License](https://github.com/akashlilhare/dart_sentiment/blob/main/LICENSE)

## Credit

Dart Sentiment inspired by the Javascript  
package [sentiment](https://www.npmjs.com/package/sentiment)

## About me

I am India based flutter developer

[![pub package](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/akash-lilhare-739a80192)   [![](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:akashlilhare14@gmail.com) [![twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/akash__lilhare) [![website](https://img.shields.io/badge/website-000000?style=for-the-badge&logo=About.me&logoColor=white)](https://akash-lilhare.netlify.app)