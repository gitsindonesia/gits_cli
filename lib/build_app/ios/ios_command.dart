import 'package:gits_cli_command/constants.dart';
import 'package:gits_cli_command/dependency_manager.dart';
import 'package:gits_cli_command/extensions/extensions.dart';
import 'package:gits_cli_command/helper/helper.dart';

class IosCommand extends Command {
  IosCommand() {
    argParser.addFlagDebug();
    argParser.addFlagProfile();
    argParser.addFlagRelease();

    argParser.addOptionFlavor(defaultsTo: Constants.prod);
    argParser.addOptionTarget();
    argParser.addOptionGitsYaml();
    argParser.addOptionBuildNumber();
    argParser.addOptionBuildName();
    argParser.addFlagCodesign();
    argParser.addFlagObfuscate();
    argParser.addOptionSplitDebugInfo();
  }

  @override
  String get name => 'ios';

  @override
  String get description =>
      'Build an iOS application bundle (Mac OS X host only).';

  @override
  void run() {
    MelosHelper.format();
    final argTarget = argResults.getOptionTarget();
    final argFlavor = argResults.getOptionFlavor(defaultTo: Constants.prod);
    final argGitsYaml = argResults.getOptionGitsYaml();
    final argBuildNumber = argResults.getOptionBuildNumber();
    final argBuildName = argResults.getOptionBuildName();
    final argCodesign = argResults.getFlagCodesign();
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
      'build ios -t $argTarget ${dartDefines.join(' ')} $mode $argBuildNumber $argBuildName $argCodesign $argObfuscate $argSplitDebugInfo',
      showLog: true,
    );

    StatusHelper.success('build ios');
  }
}
