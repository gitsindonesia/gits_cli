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
  void run() {
    final argGitsYaml = argResults.getOptionGitsYaml();

    YamlHelper.validateGitsYaml(argGitsYaml);

    'gits l10n --gits-yaml "$argGitsYaml"'.run;
    MelosHelper.run('melos bootstrap');
    StatusHelper.success('gits get');
  }
}
