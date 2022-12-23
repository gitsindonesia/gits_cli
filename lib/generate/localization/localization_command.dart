import 'package:gits_cli_command/constants.dart';
import 'package:gits_cli_command/dependency_manager.dart';
import 'package:gits_cli_command/extensions/extensions.dart';
import 'package:gits_cli_command/helper/arb_helper.dart';
import 'package:gits_cli_command/helper/helper.dart';

class LocalizationCommand extends Command {
  LocalizationCommand() {
    argParser.addOptionGitsYaml();
  }

  @override
  String get name => 'l10n';

  @override
  String get description => 'Generate localizations for the current project.';

  @override
  String get category => Constants.generate;

  @override
  void run() {
    final argGitsYaml = argResults.getOptionGitsYaml();

    YamlHelper.validateGitsYaml(argGitsYaml);

    final gitsYamlHelper = LocalizationHelper(argGitsYaml);

    final dir = find(
      '*',
      recursive: false,
      workingDirectory: gitsYamlHelper.arbDir,
      types: [Find.directory],
    );

    dir.forEach((pathDir) {
      final dirName = pathDir.split(separator).last;
      final pathArbDefault = join(gitsYamlHelper.arbDir, '$dirName.arb');

      final filesArb = find(
        '*.arb',
        workingDirectory: pathDir,
        recursive: true,
        types: [Find.file],
      );

      String merged = '{"@@locale": "$dirName"}';

      if (gitsYamlHelper.replace && exists(pathArbDefault)) {
        merged = readFile(pathArbDefault);
      }

      filesArb.forEach((pathArb) {
        final arb = readFile(pathArb);
        final sorted = sortARB(arb);
        pathArb.write(sorted);

        merged = mergeARBs(merged, sorted);
      });

      pathArbDefault.write(merged);
    });

    FlutterHelper.run(
        'gen-l10n --arb-dir="${gitsYamlHelper.arbDir}" --template-arb-file="${gitsYamlHelper.templateArbFile}" --output-localization-file="${gitsYamlHelper.outputLocalizationFile}" --output-class="${gitsYamlHelper.outputClass}" --output-dir="${gitsYamlHelper.outputDir}" --no-synthetic-package');

    StatusHelper.success('generate l10n to ${gitsYamlHelper.outputDir}');
  }
}
