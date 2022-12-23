import 'package:gits_cli_command/constants.dart';
import 'package:gits_cli_command/dependency_manager.dart';
import 'package:gits_cli_command/extensions/extensions.dart';
import 'package:gits_cli_command/helper/helper.dart';

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

    'gits_cli l10n --gits-yaml "$argGitsYaml"'.run;
    MelosHelper.run('melos bootstrap');
    StatusHelper.success('gits_cli get');
  }
}
