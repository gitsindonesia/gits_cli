import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/extensions/extensions.dart';
import 'package:gits_cli/helper/helper.dart';

class UpgradeCommand extends Command {
  UpgradeCommand() {
    argParser.addOptionGitsYaml();
    argParser.addFlag(
      'all',
      abbr: 'a',
      help: 'Upgrade all project package\'s dependencies to latest versions...',
      negatable: false,
    );
    argParser.addFlag(
      'dependency',
      abbr: 'd',
      help:
          'Upgrade all dependency_manager package\'s dependencies to latest versions...',
      negatable: false,
    );
    argParser.addFlag(
      'gits_cli',
      abbr: 'g',
      help:
          'Upgrade all gits_library package\'s dependencies to latest versions... (default)',
      negatable: false,
    );
  }

  @override
  String get name => 'upgrade';

  @override
  String get description =>
      'Upgrade the current package\'s dependencies to latest versions..';

  @override
  String get category => Constants.project;

  @override
  void run() async {
    if (argResults?.wasParsed('all') ?? false) {
      final argGitsYaml = argResults.getOptionGitsYaml();

      YamlHelper.validateGitsYaml(argGitsYaml);
      final yaml = YamlHelper.loadFileYaml(argGitsYaml);

      await GitsModularHelper.upgrade(concurrent: yaml.concurrent);
      return;
    }
    var directory = 'gits_library';
    if (argResults?.wasParsed('dependency') ?? false) {
      directory = 'dependency_manager';
    }
    final path = join(current, 'core', 'packages', directory);
    if (!exists(path)) {
      StatusHelper.failed(
          'You don\'t have directory "$directory" in project, make sure to have "$directory" first');
    }
    FlutterHelper.start('packages upgrade', workingDirectory: path);
    FlutterHelper.start('packages get', workingDirectory: path);

    StatusHelper.success();
  }
}
