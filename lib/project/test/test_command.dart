import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/helper.dart';

class TestCommand extends Command {
  TestCommand() {
    argParser.addOption(
      'feature',
      abbr: 'f',
      help: 'Test with spesific feature',
    );
  }

  @override
  String get name => 'test';

  @override
  String get description =>
      'Run Flutter unit tests for the current project & all modules.';

  @override
  String get category => Constants.project;

  @override
  void run() {
    final String? feature = argResults?['feature'];

    if (feature != null && !feature.contains('/')) {
      String workingDirectory = join(current);
      switch (feature) {
        case 'core':
          workingDirectory = join(current, 'core');
          break;
        case 'assets':
          workingDirectory = join(current, 'assets');
          break;
        case 'asset':
          workingDirectory = join(current, 'assets');
          break;
        default:
          workingDirectory = join(current, 'features', feature);
      }
      FlutterHelper.start('test', workingDirectory: workingDirectory);
    } else if (feature != null && feature.contains('/')) {
      FlutterHelper.start('test', workingDirectory: feature);
    } else {
      MelosHelper.run('melos run test');
    }

    StatusHelper.success('gits_cli test');
  }
}
