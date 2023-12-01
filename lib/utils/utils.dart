import 'dart:io';

List<String> obtainFileLines(String path) {
  try {
    final file = File(path);
    final fileData = file.readAsStringSync();

    final lines = fileData.split('\n');

    return lines;

  } catch (e) {
    
    print('Error reading file data: $e');
    return [];
  }
}
