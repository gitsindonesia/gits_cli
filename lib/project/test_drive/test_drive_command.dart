import 'package:gits_cli_command/constants.dart';
import 'package:gits_cli_command/dependency_manager.dart';
import 'package:gits_cli_command/helper/helper.dart';

class TestDriveCommand extends Command {
  TestDriveCommand() {
    argParser.addFlag(
      'android',
      defaultsTo: true,
      negatable: false,
      help: 'Run the test drive on Android',
    );
    argParser.addFlag(
      'ios',
      defaultsTo: false,
      negatable: false,
      help: 'Run the test drive on Ios',
    );
  }

  @override
  String get name => 'test-drive';

  @override
  String get description =>
      'Run all integration tests for the project on an attached device or emulator.';

  @override
  String get category => Constants.project;

  @override
  void run() {
    final bool isOnIos = argResults?['ios'] ?? false;

    final path = join(current, 'test_driver', 'test_driver.yaml');
    if (!exists(path)) {
      StatusHelper.failed('test_driver.yaml not found');
    }

    final yaml = YamlHelper.loadFileYaml(path);
    final workingDir = yaml['working_dir'] as String;
    final apk = join(current, workingDir, yaml['apk']);
    final ipa = join(current, workingDir, yaml['ipa']);
    final target = join(current, workingDir, yaml['target']);
    final screenshot = yaml['screenshot'] != null
        ? '--screenshot="${join(current, workingDir, yaml['screenshot'])}"'
        : '';
    final scenario = (yaml['scenario'] as List)
        .map((e) => join(current, workingDir, e))
        .toList();

    final useApp = isOnIos ? ipa : apk;

    for (var element in scenario) {
      'gits_cli drive -t "$target" -a "$useApp" -d "$element" $screenshot'.run;
    }

    StatusHelper.success('test-drive');
  }
}
