import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/extensions/extensions.dart';
import 'package:gits_cli/helper/helper.dart';

class AppbundleCommand extends Command {
  AppbundleCommand() {
    argParser.addFlagDebug();
    argParser.addFlagProfile();
    argParser.addFlagRelease();
    argParser.addFlagQa();

    argParser.addOptionFlavor(defaultsTo: Constants.prod);
    argParser.addOptionTarget();
    argParser.addOptionGitsYaml();
    argParser.addOptionBuildNumber();
    argParser.addOptionBuildName();
    argParser.addFlagObfuscate();
    argParser.addOptionSplitDebugInfo();
  }

  @override
  String get name => 'appbundle';

  @override
  String get description => 'Build android aab with flavor.';

  @override
  void run() async {
    CucumberHelper.removeNdjsonGherkin();
    await GitsModularHelper.format();
    final argTarget = argResults.getOptionTarget();
    final argFlavor = argResults.getOptionFlavor(defaultTo: Constants.prod);
    final argGitsYaml = argResults.getOptionGitsYaml();
    final argBuildNumber = argResults.getOptionBuildNumber();
    final argBuildName = argResults.getOptionBuildName();
    final argObfuscate = argResults.getFlagObfuscate();
    final argSplitDebugInfo = argResults.getOptionSplitDebugInfo();
    final argQa = argResults.getFlagQa();

    YamlHelper.validateGitsYaml(argGitsYaml);

    'gits_cli l10n --gits-yaml "$argGitsYaml"'.run;

    final flavor = FlavorHelper.byFlavor(argFlavor, argGitsYaml);

    FirebaseHelper.run(argFlavor, argGitsYaml);

    List<String> dartDefines = [];
    flavor.forEach((key, value) {
      dartDefines.add('${Constants.dartDefine} "$key=$value"');
    });
    final mode = argResults.getMode();
    if (argQa) {
      FlutterHelper.run(
        'build appbundle -t "lib/main_driver.dart" ${dartDefines.join(' ')} --profile $argBuildNumber $argBuildName $argObfuscate $argSplitDebugInfo',
        showLog: true,
      );
    } else {
      FlutterHelper.run(
        'build appbundle -t $argTarget ${dartDefines.join(' ')} $mode $argBuildNumber $argBuildName $argObfuscate $argSplitDebugInfo',
        showLog: true,
      );
    }

    StatusHelper.success('build appbundle');
  }
}
