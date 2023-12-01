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
    
    String firstDigit = digits[0];
    String lastDigit = digits[digits.length - 1];
    String combinedDigits = firstDigit + lastDigit;
    
    response += int.parse(combinedDigits);
  }

  return response;
}
