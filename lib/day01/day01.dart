import 'package:advent_of_code_2023/utils/utils.dart';

int partA() {
  int response = 0;
  List<String> lines = obtainFileLines('lib/day01/input.txt');

  for (String line in lines) {
    List<String> digits = [];

    for (int i = 0; i < line.length; i++) {
      if (line[i].codeUnitAt(0) >= 48 && line[i].codeUnitAt(0) <= 57) {
        digits.add(line[i]);
      }
    }

    response += obtainSum(digits);
  }

  return response;
}

int partB() {
  int response = 0;
  List<String> lines = obtainFileLines('lib/day01/input.txt');
  Map<String, int> numbersAsText = {
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9
  };

  for (String line in lines) {
    List<String> digits = [];

    for (int i = 0; i < line.length; i++) {
      
      if (line[i].codeUnitAt(0) >= 48 && line[i].codeUnitAt(0) <= 57) {

        digits.add(line[i]);
      } else {
      
        for (String number in numbersAsText.keys) {
      
          bool isFound = line.substring(i, line.length).startsWith(number);
          if (isFound) {
      
            digits.add(numbersAsText[number].toString());
          }
        }
      }
    }

    response += obtainSum(digits);
  }

  return response;
}

int obtainSum(List<String> digits) {
  
  String firstDigit = digits[0];
  String lastDigit = digits[digits.length - 1];
  String combinedDigits = firstDigit + lastDigit;

  return int.parse(combinedDigits);
}
