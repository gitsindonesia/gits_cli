import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/extensions/extensions.dart';
import 'package:gits_cli/helper/helper.dart';

class ApkCommand extends Command {
  ApkCommand() {
    argParser.addFlagDebug();
    argParser.addFlagProfile();
    argParser.addFlagRelease();

    argParser.addOptionFlavor(defaultsTo: Constants.stag);
    argParser.addOptionTarget();
    argParser.addOptionGitsYaml();
    argParser.addOptionBuildNumber();
    argParser.addOptionBuildName();
    argParser.addFlagObfuscate();
    argParser.addOptionSplitDebugInfo();
  }

  @override
  String get name => 'apk';

  @override
  String get description => 'Build android apk with flavor.';

  @override
  void run() {
    MelosHelper.format();
    final argTarget = argResults.getOptionTarget();
    final argFlavor = argResults.getOptionFlavor(defaultTo: Constants.stag);
    final argGitsYaml = argResults.getOptionGitsYaml();
    final argBuildNumber = argResults.getOptionBuildNumber();
    final argBuildName = argResults.getOptionBuildName();
    final argObfuscate = argResults.getFlagObfuscate();
    final argSplitDebugInfo = argResults.getOptionSplitDebugInfo();

    YamlHelper.validateGitsYaml(argGitsYaml);

    'gits l10n --gits-yaml "$argGitsYaml"'.run;

    final flavor = FlavorHelper.byFlavor(argFlavor, argGitsYaml);

    FirebaseHelper.run(argFlavor, argGitsYaml);

    List<String> dartDefines = [];
    flavor.forEach((key, value) {
      dartDefines.add('${Constants.dartDefine} "$key=$value"');
    });
    final mode = argResults.getMode();
    FlutterHelper.run(
      'build apk -t $argTarget ${dartDefines.join(' ')} $mode $argBuildNumber $argBuildName $argObfuscate $argSplitDebugInfo',
      showLog: true,
    );

    StatusHelper.success('build apk');
  }
}
