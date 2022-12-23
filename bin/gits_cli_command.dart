import 'dart:io';

import 'package:gits_cli/build_app/build_command.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/generate/firebase/firebase_command.dart';
import 'package:gits_cli/generate/generate.dart';
import 'package:gits_cli/project/analyze/analyze_command.dart';
import 'package:gits_cli/project/drive/drive_command.dart';
import 'package:gits_cli/project/project.dart';
import 'package:gits_cli/project/test/coverage_command.dart';
import 'package:gits_cli/project/test_drive/test_drive_command.dart';
import 'package:gits_cli/project/upgrade/upgrade_command.dart';
import 'package:gits_cli/tools/changelog/changelog_command.dart';
import 'package:gits_cli/tools/doctor/doctor_command.dart';
import 'package:gits_cli/tools/init/init_command.dart';

void main(List<String> arguments) {
  final runner =
      CommandRunner('gits', 'Get it simple command flutter with Gits CLI')
        //* Generate
        ..addCommand(LocalizationCommand())
        ..addCommand(ConfigCommand())
        ..addCommand(FirebaseCommand())
        //* Project
        ..addCommand(GetCommand())
        ..addCommand(RunCommand())
        ..addCommand(CleanCommand())
        ..addCommand(FormatCommand())
        ..addCommand(TestCommand())
        ..addCommand(UpgradeCommand())
        ..addCommand(CoverageCommand())
        ..addCommand(AnalyzeCommand())
        ..addCommand(DriveCommand())
        ..addCommand(TestDriveCommand())
        //* Build
        ..addCommand(BuildCommand())
        //* Tools
        ..addCommand(ChangelogCommand())
        ..addCommand(DoctorCommand())
        ..addCommand(InitCommand());

  runner.argParser.addFlag(
    'version',
    abbr: 'v',
    help: 'Reports the version of this tool.',
    negatable: false,
  );

  try {
    final results = runner.argParser.parse(arguments);
    if (results.wasParsed('version')) {
      print('Gits CLI 1.0.0');
      exit(0);
    }
  } catch (e) {
    printerr(e.toString());
  }

  runner.run(arguments).onError((error, stackTrace) {
    print(error);
    print(stackTrace);
    exit(1);
  });
}
