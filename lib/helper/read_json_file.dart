import 'dart:io';

String readFile(String path) => File(path).readAsStringSync();
