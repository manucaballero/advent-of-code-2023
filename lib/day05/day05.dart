import 'package:advent_of_code_2023/utils/utils.dart';

int partA() {
  List<String> lines = obtainFileLines('lib/day05/input.txt');
  List<int> seeds = lines[0]
      .substring(lines[0].indexOf(":") + 1)
      .trim()
      .split(" ")
      .map((element) => int.parse(element))
      .toList();

  List<List<int>> seedToSoil = [];
  List<List<int>> soilToFertilizer = [];
  List<List<int>> fertilizerToWater = [];
  List<List<int>> waterToLight = [];
  List<List<int>> lightToTemperature = [];
  List<List<int>> temperatureToHumidity = [];
  List<List<int>> humidityToLocation = [];

  int seedToSoilIndex = lines.indexWhere((element) => element.startsWith("seed-to-soil"));
  int soilToFertilizerIndex = lines.indexWhere((element) => element.startsWith("soil-to-fertilizer"));
  int fertilizerToWaterIndex = lines.indexWhere((element) => element.startsWith("fertilizer-to-water"));
  int waterToLightIndex = lines.indexWhere((element) => element.startsWith("water-to-light"));
  int lightToTemperatureIndex = lines.indexWhere((element) => element.startsWith("light-to-temperature"));
  int temperatureToHumidityIndex = lines.indexWhere((element) => element.startsWith("temperature-to-humidity"));
  int humidityToLocationIndex = lines.indexWhere((element) => element.startsWith("humidity-to-location"));

  seedToSoil = obtainMapper(seedToSoilIndex, soilToFertilizerIndex, lines);
  soilToFertilizer = obtainMapper(soilToFertilizerIndex, fertilizerToWaterIndex, lines);
  fertilizerToWater = obtainMapper(fertilizerToWaterIndex, waterToLightIndex, lines);
  waterToLight = obtainMapper(waterToLightIndex, lightToTemperatureIndex, lines);
  lightToTemperature = obtainMapper(lightToTemperatureIndex, temperatureToHumidityIndex, lines);
  temperatureToHumidity = obtainMapper(temperatureToHumidityIndex, humidityToLocationIndex, lines);
  humidityToLocation = obtainMapper(humidityToLocationIndex, lines.length, lines);

  List<int> seedLocations = [];

  for (int seed in seeds) {
    int seedNumber = seed;

    seedNumber = obtainTransformation(seedNumber, seedToSoil);
    seedNumber = obtainTransformation(seedNumber, soilToFertilizer);
    seedNumber = obtainTransformation(seedNumber, fertilizerToWater);
    seedNumber = obtainTransformation(seedNumber, waterToLight);
    seedNumber = obtainTransformation(seedNumber, lightToTemperature);
    seedNumber = obtainTransformation(seedNumber, temperatureToHumidity);
    seedNumber = obtainTransformation(seedNumber, humidityToLocation);

    seedLocations.add(seedNumber);
  }

  return seedLocations.reduce((min, actual) => min < actual ? min : actual);
}

int partB() {
  //TODO Forma de solucionarlo poco optima 5 mins tarda
  List<String> lines = obtainFileLines('lib/day05/input.txt');
  List<int> seeds = lines[0]
      .substring(lines[0].indexOf(":") + 1)
      .trim()
      .split(" ")
      .map((element) => int.parse(element))
      .toList();

  List<int> allSeeds = [];
  for (int i = 0; i < seeds.length; i = i + 2) {
    int startRange = seeds[i];
    int lengthRange = seeds[i + 1];
    for (int j = startRange; j < startRange + lengthRange; j++) {
      allSeeds.add(j);
    }
  }
  List<List<int>> seedToSoil = [];
  List<List<int>> soilToFertilizer = [];
  List<List<int>> fertilizerToWater = [];
  List<List<int>> waterToLight = [];
  List<List<int>> lightToTemperature = [];
  List<List<int>> temperatureToHumidity = [];
  List<List<int>> humidityToLocation = [];

  int seedToSoilIndex = lines.indexWhere((element) => element.startsWith("seed-to-soil"));
  int soilToFertilizerIndex = lines.indexWhere((element) => element.startsWith("soil-to-fertilizer"));
  int fertilizerToWaterIndex = lines.indexWhere((element) => element.startsWith("fertilizer-to-water"));
  int waterToLightIndex = lines.indexWhere((element) => element.startsWith("water-to-light"));
  int lightToTemperatureIndex = lines.indexWhere((element) => element.startsWith("light-to-temperature"));
  int temperatureToHumidityIndex = lines.indexWhere((element) => element.startsWith("temperature-to-humidity"));
  int humidityToLocationIndex = lines.indexWhere((element) => element.startsWith("humidity-to-location"));

  seedToSoil = obtainMapper(seedToSoilIndex, soilToFertilizerIndex, lines);
  soilToFertilizer = obtainMapper(soilToFertilizerIndex, fertilizerToWaterIndex, lines);
  fertilizerToWater = obtainMapper(fertilizerToWaterIndex, waterToLightIndex, lines);
  waterToLight = obtainMapper(waterToLightIndex, lightToTemperatureIndex, lines);
  lightToTemperature = obtainMapper(lightToTemperatureIndex, temperatureToHumidityIndex, lines);
  temperatureToHumidity = obtainMapper(temperatureToHumidityIndex, humidityToLocationIndex, lines);
  humidityToLocation = obtainMapper(humidityToLocationIndex, lines.length, lines);

  List<int> seedLocations = [];

  for (int seed in allSeeds) {
    int seedNumber = seed;

    seedNumber = obtainTransformation(seedNumber, seedToSoil);
    seedNumber = obtainTransformation(seedNumber, soilToFertilizer);
    seedNumber = obtainTransformation(seedNumber, fertilizerToWater);
    seedNumber = obtainTransformation(seedNumber, waterToLight);
    seedNumber = obtainTransformation(seedNumber, lightToTemperature);
    seedNumber = obtainTransformation(seedNumber, temperatureToHumidity);
    seedNumber = obtainTransformation(seedNumber, humidityToLocation);

    seedLocations.add(seedNumber);
  }

  return seedLocations.reduce((min, actual) => min < actual ? min : actual);
}

List<List<int>> obtainMapper(int startIndex, int endIndex, List<String> lines) {
  List<List<int>> mapper = [];
  
  for (int i = startIndex + 1; i < endIndex - 1; i++) {
    List<String> info = lines[i].trim().split(" ");
    int startRange = int.parse(info[1]);
    int endRange = startRange + int.parse(info[2]) - 1;
    int conversorRate = int.parse(info[0]) - startRange;

    mapper.add([startRange, endRange, conversorRate]);
  }

  return mapper;
}

int obtainTransformation(int currentNumber, List<List<int>> mapper) {
  
  int transformedNumber = currentNumber;
  bool isFound = false;
  int counter = 0;
  
  while (!isFound && counter < mapper.length) {
    
    List<int> range = mapper[counter];

    if (currentNumber >= range[0] && currentNumber <= range[1]) {
      
      isFound = true;
      transformedNumber = currentNumber + range[2];
    }

    counter++;
  }

  return transformedNumber;
}
