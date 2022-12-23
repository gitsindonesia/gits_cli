import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/extensions/extensions.dart';
import 'package:gits_cli/helper/helper.dart';

class CleanCommand extends Command {
  CleanCommand() {
    argParser.addOptionGitsYaml();
  }

  @override
  String get name => 'clean';

  @override
  String get description =>
      'Delete the l10n, build/ and .dart_tool/ in main, core & features directories.';

  @override
  String get category => Constants.project;

  @override
  void run() {
    final argGitsYaml = argResults.getOptionGitsYaml();

    YamlHelper.validateGitsYaml(argGitsYaml);

    final localizationHelper = LocalizationHelper(argGitsYaml);
    if (exists(join(current, localizationHelper.outputDir))) {
      deleteDir(join(current, localizationHelper.outputDir));
    }
    if (exists(join(current, 'ios', 'Podfile.lock'))) {
      delete(join(current, 'ios', 'Podfile.lock'));
    }

    MelosHelper.run('melos run clean:all');

    StatusHelper.success('gits clean');
  }
}
