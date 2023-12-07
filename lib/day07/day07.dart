import 'package:advent_of_code_2023/utils/utils.dart';

Map<String, int> plays = {
  "5": 7, //Repoker
  "4": 6, //Poker
  "32": 5, //Full
  "23": 5, //Full
  "3": 4, //Trio
  "22": 3, //Dobles
  "2": 2, //Pareja
  "": 1 //Nada
};
Map<String, int> cardStrengths = {
  "A": 13,
  "K": 12,
  "Q": 11,
  "J": 10,
  "T": 9,
  "9": 8,
  "8": 7,
  "7": 6,
  "6": 5,
  "5": 4,
  "4": 3,
  "3": 2,
  "2": 1
};

Map<String, int> cardStrengthsB = {
  "A": 13,
  "K": 12,
  "Q": 11,
  "J": 1,
  "T": 10,
  "9": 9,
  "8": 8,
  "7": 7,
  "6": 6,
  "5": 5,
  "4": 4,
  "3": 3,
  "2": 2
};

int partA() {
  int response = 0;

  List<String> lines = obtainFileLines('lib/day07/input.txt');
  List<Hand> hands = [];
  for (String line in lines) {
  
    int index = line.indexOf(" ");
    String cards = line.substring(0, index);
    int playLevel = obtainPlayLevel(cards);
    int bid = int.parse(line.substring(index + 1));
  
    hands.add(Hand(cards, bid, playLevel));
  }

  hands.sort((a, b) => a.compareHands(b));
  for (int i = 0; i < hands.length; i++) {
    response += hands[i].bid * (i + 1);
  }

  return response;
}

int partB() {
  int response = 0;

  List<String> lines = obtainFileLines('lib/day07/input.txt');
  List<Hand> hands = [];
  for (String line in lines) {
  
    int index = line.indexOf(" ");
    String cards = line.substring(0, index);
    int playLevel = obtainPlayLevelB(cards);
    int bid = int.parse(line.substring(index + 1));

    hands.add(Hand(cards, bid, playLevel));
  }

  hands.sort((a, b) => a.compareHandsB(b));
  for (int i = 0; i < hands.length; i++) {
    response += hands[i].bid * (i + 1);
  }

  return response;
}

int obtainPlayLevel(String cards) {
 
  List<String> alreadyVisited = [];
  List<int> combos = [];
  for (int i = 0; i < cards.length; i++) {
 
    String card = cards[i];

    if (!alreadyVisited.contains(card)) {
 
      alreadyVisited.add(card);
      int counter = 1;

      for (int j = i + 1; j < cards.length; j++) {
 
        if (card == cards[j]) counter++;
      }
      if (counter > 1) combos.add(counter);
    }
  }

  String key = '';
  combos.forEach((element) {
    key = '$key$element';
  });

  return plays[key] ?? 0;
}

int obtainPlayLevelB(String cards) {

  List<String> alreadyVisited = [];
  List<int> combos = [];
  int counterJ = 0;
  for (int i = 0; i < cards.length; i++) {

    String card = cards[i];

    if (card == 'J') {
      counterJ++;

    } else {
      if (!alreadyVisited.contains(card)) {

        alreadyVisited.add(card);
        int counter = 1;

        for (int j = i + 1; j < cards.length; j++) {

          if (card == cards[j]) counter++;
        }
        if (counter > 1) combos.add(counter);
      }
    }
  }
  String key = '';
  combos.forEach((element) {
    key = '$key$element';
  });

  int currentPlayLevel = plays[key] ?? 0;

  for (int i = 0; i < counterJ; i++) {

    if (currentPlayLevel == 1 || currentPlayLevel == 5 || currentPlayLevel == 6) {
      currentPlayLevel++;
    } else if (currentPlayLevel == 2 || currentPlayLevel == 3 || currentPlayLevel == 4) {
      currentPlayLevel += 2;
    }
  }

  return currentPlayLevel;
}

int compareCardStrength(String firstHand, String secondHand) {
  for (int i = 0; i < firstHand.length; i++) {

    if (cardStrengths[firstHand[i]]! > cardStrengths[secondHand[i]]!) {
      return 1;
    }
    if (cardStrengths[firstHand[i]]! < cardStrengths[secondHand[i]]!) {
      return -1;
    }
  }
  return 0;
}

int compareCardStrengthB(String firstHand, String secondHand) {
  for (int i = 0; i < firstHand.length; i++) {
    
    if (cardStrengthsB[firstHand[i]]! > cardStrengthsB[secondHand[i]]!) {
      return 1;
    }
    if (cardStrengthsB[firstHand[i]]! < cardStrengthsB[secondHand[i]]!) {
      return -1;
    }
  }
  return 0;
}

class Hand {
  String cards = '';
  int bid = 0;
  int play = 0;
  Hand(this.cards, this.bid, this.play);

  int compareHands(Hand secondHand) {
    if (play > secondHand.play) {
      return 1;
    } else if (play < secondHand.play) {
      return -1;
    } else {
      return compareCardStrength(cards, secondHand.cards);
    }
  }

  int compareHandsB(Hand secondHand) {
    if (play > secondHand.play) {
      return 1;
    } else if (play < secondHand.play) {
      return -1;
    } else {
      return compareCardStrengthB(cards, secondHand.cards);
    }
  }
}
