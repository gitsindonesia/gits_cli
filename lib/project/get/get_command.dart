import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/extensions/extensions.dart';
import 'package:gits_cli/helper/helper.dart';

class GetCommand extends Command {
  GetCommand() {
    argParser.addOptionGitsYaml();
  }
  @override
  String get name => 'get';

  @override
  String get description =>
      'Get packages in a Flutter project, Core & Features.';

  @override
  String get category => Constants.project;

  @override
  void run() async {
    final argGitsYaml = argResults.getOptionGitsYaml();

    YamlHelper.validateGitsYaml(argGitsYaml);

    'gits_cli l10n --gits-yaml "$argGitsYaml"'.run;

    final yaml = YamlHelper.loadFileYaml(argGitsYaml);
    await GitsModularHelper.get(concurrent: yaml.concurrent);
    StatusHelper.success('gits_cli get');
  }
}
