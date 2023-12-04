import 'package:advent_of_code_2023/utils/utils.dart';
import 'dart:math';

int partA() {
  int response = 0;
  List<String> lines = obtainFileLines('lib/day04/input.txt');

  for (String line in lines) {
   
    int winningNumbers = elfWinningNumbers(line);

    if (winningNumbers > 0) {
      
      int powNumber = pow(2, winningNumbers - 1).toInt();
      response += powNumber;
    }
  }

  return response;
}

int partB() {
  int response = 0;
  List<String> lines = obtainFileLines('lib/day04/input.txt');
  Map<int, int> scratchCards = {};

  int counter = 1;
  for (String line in lines) {
    
    int winningNumbers = elfWinningNumbers(line);
    int currentLineQuantity = scratchCards[counter] ?? 0;
    currentLineQuantity++;
    scratchCards[counter] = currentLineQuantity;
    
    for (int i = 1; i <= winningNumbers; i++) {
    
      int lineId = counter + i;
      int scratchQuantity = scratchCards[lineId] ?? 0;
      scratchCards[lineId] = scratchQuantity + 1 * currentLineQuantity;
    }
    
    counter++;
  }

  scratchCards.forEach((key, value) {
    response += value;
  });

  return response;
}


int elfWinningNumbers(String line) {
  int startIndexWinningNumbers = line.indexOf(":");
  int verticalBarIndex = line.indexOf("|");
  String winningNumbersLine =
      line.substring(startIndexWinningNumbers + 1, verticalBarIndex).trim();
  List<String> winningNumbers = winningNumbersLine.split(" ");

  List<String> elfNumbers =
      line.substring(verticalBarIndex + 1).trim().split(" ");
  elfNumbers = elfNumbers.where((element) => element != '').toList();

  return elfNumbers
      .where((elfNumber) =>
          winningNumbers.any((winningNumber) => winningNumber == elfNumber))
      .toList()
      .length;
}
