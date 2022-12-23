import 'dart:io';

import 'package:gits_cli/dependency_manager.dart';

abstract class FlutterHelper {
  static void run(String argument, {bool showLog = false}) {
    String command = '';
    if (Platform.isWindows) {
      command = 'flutter.bat $argument';
    } else {
      command = 'flutter $argument';
    }
    if (showLog) print(command);
    command.run;
  }

  static void start(
    String argument, {
    bool showLog = false,
    String? workingDirectory,
  }) {
    String command = '';
    if (Platform.isWindows) {
      command = 'flutter.bat $argument';
    } else {
      command = 'flutter $argument';
    }
    if (showLog) print(command);
    command.start(workingDirectory: workingDirectory);
  }
}
