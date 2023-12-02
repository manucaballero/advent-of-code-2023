import 'package:advent_of_code_2023/utils/utils.dart';

int RED_LIMIT = 12;
int GREEN_LIMIT = 13;
int BLUE_LIMIT = 14;

int partA() {
  int response = 0;
  List<String> lines = obtainFileLines('lib/day02/input.txt');
  for (String line in lines) {
    
    int gameIdIndex = line.indexOf(':');
    int gameNumber = int.parse(line
      .substring(0, gameIdIndex)
      .replaceAll(RegExp(r'[^0-9]'), ''));
    bool legalGame = true;
    List<String> gameRounds = line.substring(gameIdIndex + 1).split(';');

    for (String round in gameRounds) {
    
      List<String> roundColours = round.split(',');
      for (String colour in roundColours) {
        
        int quantity = int.parse(colour.replaceAll(RegExp(r'[^0-9]'), ''));
        
        if (!isLegalQuantity(colour, quantity)) legalGame = false;
      }
    }

    if (legalGame) response += gameNumber;
  }

  return response;
}

bool isLegalQuantity(String colour, int quantity) {
  return (colour.contains('red') && quantity <= RED_LIMIT) ||
      (colour.contains('green') && quantity <= GREEN_LIMIT) ||
      (colour.contains('blue') && quantity <= BLUE_LIMIT);
}
