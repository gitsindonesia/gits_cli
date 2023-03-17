import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/extensions/extensions.dart';
import 'package:gits_cli/helper/helper.dart';

class AnalyzeCommand extends Command {
  AnalyzeCommand() {
    argParser.addOptionGitsYaml();
  }

  @override
  String get name => 'analyze';

  @override
  String get description => 'Analyze code in all packages.';

  @override
  String get category => Constants.project;

  @override
  void run() async {
    final argGitsYaml = argResults.getOptionGitsYaml();

    YamlHelper.validateGitsYaml(argGitsYaml);
    final yaml = YamlHelper.loadFileYaml(argGitsYaml);

    await GitsModularHelper.analyze(concurrent: yaml.concurrent);
    StatusHelper.success('gits_cli analyze');
  }
}
