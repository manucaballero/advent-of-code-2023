import 'package:advent_of_code_2023/utils/utils.dart';

int partA() {
  int response = 1;
  List<String> lines = obtainFileLines('lib/day06/input.txt');
  List<int> times = lines[0]
      .substring(lines[0].indexOf(":") + 1)
      .trim()
      .split(RegExp(r'\s+'))
      .map((e) => int.parse(e))
      .toList();

  List<int> distances = lines[1]
      .substring(lines[1].indexOf(":") + 1)
      .trim()
      .split(RegExp(r'\s+'))
      .map((e) => int.parse(e))
      .toList();

  List<int> waysOfWinningPerRace = findWaysOfWinning(times, distances);

  for (int element in waysOfWinningPerRace) {
    
    response *= element;
  }

  return response;
}

int partB() {
  int response = 1;
  List<String> lines = obtainFileLines('lib/day06/input.txt');
  List<int> times = lines[0]
      .substring(lines[0].indexOf(":") + 1)
      .replaceAll(" ", "")
      .split(RegExp(r'\s+'))
      .map((e) => int.parse(e))
      .toList();

  List<int> distances = lines[1]
      .substring(lines[1].indexOf(":") + 1)
      .replaceAll(" ", "")
      .split(RegExp(r'\s+'))
      .map((e) => int.parse(e))
      .toList();

  List<int> waysOfWinningPerRace = findWaysOfWinning(times, distances);

  for (int element in waysOfWinningPerRace) {
    
    response *= element;
  }

  return response;
}

List<int> findWaysOfWinning(List<int> times, List<int> distances) {
  
  List<int> waysOfWinningPerRace = [];
  for (int i = 0; i < times.length; i++) {
  
    for (int j = 1; j < times[i] - 1; j++) {
  
      int totalDistance = (times[i] - j) * j;
  
      if (totalDistance > distances[i]) {
  
        if (i >= waysOfWinningPerRace.length) {
  
          waysOfWinningPerRace.add(1);
        } else {
  
          waysOfWinningPerRace[i] = waysOfWinningPerRace[i] + 1;
        }
      }
    }
  }
  
  return waysOfWinningPerRace;
}
