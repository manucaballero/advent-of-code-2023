import 'package:advent_of_code_2023/utils/utils.dart';

int partA() {

  List<String> lines = obtainFileLines('lib/day08/input.txt');
  List<String> instructions = lines[0].split("");
  Map<String, List<String>> nodes = {};

  for (int i = 2; i < lines.length; i++) {
    String node = lines[i].substring(0, lines[i].indexOf("=") - 1).trim();
    String left = lines[i]
        .substring(lines[i].indexOf("(") + 1, lines[i].indexOf(","))
        .trim();
    String right = lines[i]
        .substring(lines[i].indexOf(",") + 1, lines[i].indexOf(")"))
        .trim();

    nodes.putIfAbsent(node, () => [left, right]);
  }

  return solve(instructions, nodes);
}

int solve(List<String> instructions, Map<String, List<String>> nodes) {
  
  int counter = 0;
  bool isEndFound = false;
  String currentNode = 'AAA';

  while (!isEndFound) {
  
    String instruction = instructions[counter % instructions.length];
    List<String> responses = nodes[currentNode] ?? [];
    if (instruction == 'L') {
      currentNode = responses[0];
    } else {
      currentNode = responses[1];
    }

    if (currentNode == 'ZZZ') {
      isEndFound = true;
    }
    counter++;
  }

  return counter;
}
