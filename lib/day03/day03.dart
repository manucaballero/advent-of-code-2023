import 'package:advent_of_code_2023/utils/utils.dart';
import 'dart:math';

int partA() {
  int response = 0;
  List<String> lines = obtainFileLines('lib/day03/input.txt');
  List<String> currentNumber = [];
  bool isPartNumber = false;

  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];
    
    for (int j = 0; j < line.length; j++) {
      //J == 0 para el caso en el que el numero de la anterior linea acaba en la ultima pos de la linea
      if (j == 0 ||
          (line[j].codeUnitAt(0) < 48 || line[j].codeUnitAt(0) > 57)) {
        response += sumNumber(currentNumber, isPartNumber);
        currentNumber = [];
        isPartNumber = false;
      }

      if (line[j].codeUnitAt(0) >= 48 && line[j].codeUnitAt(0) <= 57) {
        currentNumber.add(line[j]);

        //Comprobamos fila superior
        if (i != 0) {
          String aboveLine = lines[i - 1];
          //Comprobar fila superior diagonal izq
          if (j != 0 && isSymbol(aboveLine[j - 1])) isPartNumber = true;
        
          //Comprobar fila superior diagonal dcha
          if (j < line.length - 1 && isSymbol(aboveLine[j + 1])) isPartNumber = true;
        
          //Comprobar fila superior encima
          if (isSymbol(aboveLine[j])) isPartNumber = true;
        }

        //Comprobar fila actual izq
        if (j != 0 && isSymbol(line[j - 1])) isPartNumber = true;
       
        //Comprobar fila actual dcha
        if (j < line.length - 1 && isSymbol(line[j + 1])) isPartNumber = true;

        //Comprobamos fila inferior
        if (i != lines.length - 1) {
          String belowLine = lines[i + 1];
          
          //Comprobar fila inferior diagonal izq
          if (j != 0 && isSymbol(belowLine[j - 1])) isPartNumber = true;
        
          //Comprobar fila inferior diagonal derecha
          if (j < line.length - 1 && isSymbol(belowLine[j + 1])) isPartNumber = true;
        
          //Comprobar fila inferior debajo
          if (isSymbol(belowLine[j])) isPartNumber = true;
        }
      }
    }
  }

  return response;
}

int partB() {
  Map<String, List<int>> asterisks = {};
  int response = 0;
  List<String> lines = obtainFileLines('lib/day03/input.txt');
  List<String> currentNumber = [];
  bool isPartNumber = false;
  bool hasAsterisk = false;
  String currentAsterisk = '';
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];

    for (int j = 0; j < line.length; j++) {
      //J == 0 para el caso en el que el numero de la anterior linea acaba en la ultima pos de la linea
      if (j == 0 ||
          (line[j].codeUnitAt(0) < 48 || line[j].codeUnitAt(0) > 57)) {
        int totalNumber = sumNumber(currentNumber, isPartNumber);
        if (hasAsterisk) {
          List<int> numbers = asterisks[currentAsterisk] != null
              ? asterisks[currentAsterisk]!
              : [];
          numbers.add(totalNumber);
          asterisks.update(currentAsterisk, (value) => numbers);
        }
        currentNumber = [];
        isPartNumber = false;
        hasAsterisk = false;
        currentAsterisk = '';
      }

      if (line[j].codeUnitAt(0) >= 48 && line[j].codeUnitAt(0) <= 57) {
        currentNumber.add(line[j]);

        //Comprobamos fila superior
        if (i != 0) {
          String aboveLine = lines[i - 1];
          //Comprobar fila superior diagonal izq
          if (j != 0 && isSymbol(aboveLine[j - 1])) {
            isPartNumber = true;
            if (isAsterisk(aboveLine[j - 1])) {
              hasAsterisk = true;
              String key = '${i - 1}${j - 1 < 10 ? '0${j - 1}' : j - 1}';
              asterisks.putIfAbsent(key, () => []);
              currentAsterisk = key;
            }
          }

          //Comprobar fila superior diagonal dcha
          if (j < line.length - 1 && isSymbol(aboveLine[j + 1])) {
            isPartNumber = true;
            if (isAsterisk(aboveLine[j + 1])) {
              hasAsterisk = true;
              String key = '${i - 1}${j + 1 < 10 ? '0${j + 1}' : j + 1}';
              asterisks.putIfAbsent(key, () => []);
              currentAsterisk = key;
            }
          }

          //Comprobar fila superior encima
          if (isSymbol(aboveLine[j])) {
            isPartNumber = true;
            if (isAsterisk(aboveLine[j])) {
              hasAsterisk = true;
              String key = '${i - 1}${j < 10 ? '0$j' : j}';
              asterisks.putIfAbsent(key, () => []);
              currentAsterisk = key;
            }
          }
        }

        //Comprobar fila actual izq
        if (j != 0 && isSymbol(line[j - 1])) {
          isPartNumber = true;
          if (isAsterisk(line[j - 1])) {
            hasAsterisk = true;
            String key = '$i${j - 1 < 10 ? '0${j - 1}' : j - 1}';
            asterisks.putIfAbsent(key, () => []);
            currentAsterisk = key;
          }
        }

        //Comprobar fila actual dcha
        if (j < line.length - 1 && isSymbol(line[j + 1])) {
          isPartNumber = true;
          if (isAsterisk(line[j + 1])) {
            hasAsterisk = true;
            String key = '$i${j + 1 < 10 ? '0${j + 1}' : j + 1}';
            asterisks.putIfAbsent(key, () => []);
            currentAsterisk = key;
          }
        }

        //Comprobamos fila inferior
        if (i != lines.length - 1) {
          String belowLine = lines[i + 1];

          //Comprobar fila inferior diagonal izq
          if (j != 0 && isSymbol(belowLine[j - 1])) {
            isPartNumber = true;
            if (isAsterisk(belowLine[j - 1])) {
              hasAsterisk = true;
              String key = '${i + 1}${j - 1 < 10 ? '0${j - 1}' : j - 1}';
              asterisks.putIfAbsent(key, () => []);
              currentAsterisk = key;
            }
          }

          //Comprobar fila inferior diagonal derecha
          if (j < line.length - 1 && isSymbol(belowLine[j + 1])) {
            isPartNumber = true;
            if (isAsterisk(belowLine[j + 1])) {
              hasAsterisk = true;
              String key = '${i + 1}${j + 1 < 10 ? '0${j + 1}' : j + 1}';
              asterisks.putIfAbsent(key, () => []);
              currentAsterisk = key;
            }
          }

          //Comprobar fila inferior debajo
          if (isSymbol(belowLine[j])) {
            isPartNumber = true;
            if (isAsterisk(belowLine[j])) {
              hasAsterisk = true;
              String key = '${i + 1}${j < 10 ? '0$j' : j}';
              asterisks.putIfAbsent(key, () => []);
              currentAsterisk = key;
            }
          }
        }
      }
    }
  }
  asterisks.forEach((key, value) {
    if (value.length == 2) {
      response += value[0] * value[1];
    }
  });
  return response;
}

int sumNumber(List<String> currentNumber, bool isPartNumber) {
  if (currentNumber.isNotEmpty && isPartNumber) {
    int totalNumber = 0;
  
    for (int k = 0; k < currentNumber.length; k++) {
      int number = int.parse(currentNumber[k]);
      int powNumber = pow(10, currentNumber.length - k - 1).toInt();
      totalNumber += powNumber * number;
    }

    return totalNumber;
  }

  return 0;
}

bool isSymbol(String symbol) {
  return symbol[0].codeUnitAt(0) != 46 &&
      (symbol[0].codeUnitAt(0) < 48 || symbol[0].codeUnitAt(0) > 57);
}

bool isAsterisk(String symbol) {
  return symbol[0].codeUnitAt(0) == 42;
}
