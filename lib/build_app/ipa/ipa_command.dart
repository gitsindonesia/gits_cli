import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/extensions/extensions.dart';
import 'package:gits_cli/helper/helper.dart';

class IpaCommand extends Command {
  IpaCommand() {
    argParser.addFlagDebug();
    argParser.addFlagProfile();
    argParser.addFlagRelease();

    argParser.addOptionFlavor(defaultsTo: Constants.prod);
    argParser.addOptionTarget();
    argParser.addOptionGitsYaml();
    argParser.addOptionExportMethod();
    argParser.addOptionExportOptionsPlist();
    argParser.addOptionBuildNumber();
    argParser.addOptionBuildName();
    argParser.addFlagObfuscate();
    argParser.addOptionSplitDebugInfo();
  }

  @override
  String get name => 'ipa';

  @override
  String get description => 'Archive ios ipa with flavor.';

  @override
  void run() {
    MelosHelper.format();
    final argTarget = argResults.getOptionTarget();
    final argFlavor = argResults.getOptionFlavor(defaultTo: Constants.prod);
    final argGitsYaml = argResults.getOptionGitsYaml();
    final argExportMethod = argResults.getOptionExportMethod();
    final argExportOptionsPlist = argResults.getOptionExportOptionsPlist();
    final argBuildNumber = argResults.getOptionBuildNumber();
    final argBuildName = argResults.getOptionBuildName();
    final argObfuscate = argResults.getFlagObfuscate();
    final argSplitDebugInfo = argResults.getOptionSplitDebugInfo();

    YamlHelper.validateGitsYaml(argGitsYaml);

    'gits_cli l10n --gits-yaml "$argGitsYaml"'.run;

    final flavor = FlavorHelper.byFlavor(argFlavor, argGitsYaml);

    FirebaseHelper.run(argFlavor, argGitsYaml);

    List<String> dartDefines = [];
    flavor.forEach((key, value) {
      dartDefines.add('${Constants.dartDefine} "$key=$value"');
    });
    final mode = argResults.getMode();
    FlutterHelper.run(
      'build ipa -t $argTarget ${dartDefines.join(' ')} $mode $argExportMethod $argExportOptionsPlist $argBuildNumber $argBuildName $argObfuscate $argSplitDebugInfo',
      showLog: true,
    );

    StatusHelper.success('build ipa');
  }
}
