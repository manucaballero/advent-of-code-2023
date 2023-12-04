import 'package:advent_of_code_2023/utils/utils.dart';
import 'dart:math';

int partA() {
  int response = 0;
  List<String> lines = obtainFileLines('lib/day04/input.txt');

  for (String line in lines) {
    
    int startIndexWinningNumbers = line.indexOf(":");
    int verticalBarIndex = line.indexOf("|");

    String winningNumbersLine =
        line.substring(startIndexWinningNumbers + 1, verticalBarIndex).trim();
    List<String> winningNumbers = winningNumbersLine.split(" ");

    List<String> elfNumbers = line.substring(verticalBarIndex + 1).trim().split(" ");
    elfNumbers = elfNumbers.where((element) => element != '').toList();

    int elfWinningNumbers = elfNumbers.where((elfNumber) =>
        winningNumbers.any((winningNumber) => winningNumber == elfNumber))
        .toList().length;

    if(elfWinningNumbers > 0){

      int powNumber = pow(2, elfWinningNumbers - 1).toInt();
      response += powNumber;
    }
   
  }

  return response;
}
