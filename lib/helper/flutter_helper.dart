import 'dart:io';

import 'package:gits_cli/dependency_manager.dart';

abstract class FlutterHelper {
  static String getCommandFlutter() {
    if (Platform.isWindows) {
      return 'flutter.bat';
    } else {
      return 'flutter';
    }
  }

  static String getCommandDart() {
    if (Platform.isWindows) {
      return 'dart.bat';
    } else {
      return 'dart';
    }
  }

  static void run(String argument, {bool showLog = false}) {
    String command = '${getCommandFlutter()} $argument';
    if (showLog) print(command);
    command.run;
  }

  static void start(
    String argument, {
    bool showLog = false,
    String? workingDirectory,
    Progress? progress,
  }) {
    String command = '${getCommandFlutter()} $argument';
    if (showLog) print(command);
    command.start(
      workingDirectory: workingDirectory,
      progress: progress,
    );
  }
}
