import 'package:gits_cli_command/constants.dart';
import 'package:gits_cli_command/dependency_manager.dart';
import 'package:gits_cli_command/extensions/extensions.dart';
import 'package:gits_cli_command/helper/helper.dart';

class DriveCommand extends Command {
  DriveCommand() {
    argParser.addFlagDebug(defaultsTo: true);
    argParser.addFlagProfile();
    argParser.addFlagRelease(defaultsTo: false);

    argParser.addOptionFlavor(defaultsTo: Constants.dev);
    argParser.addOptionTarget();
    argParser.addOptionGitsYaml();
    argParser.addOptionUseApp();
    argParser.addOptionDriver();
    argParser.addOptionScreenshot();
  }

  @override
  String get name => 'drive';

  @override
  String get description =>
      'Run integration tests for the project on an attached device or emulator.';

  @override
  String get category => Constants.project;

  @override
  void run() {
    final argTarget = argResults.getOptionTarget();
    final argFlavor = argResults.getOptionFlavor(defaultTo: Constants.dev);
    final argGitsYaml = argResults.getOptionGitsYaml();
    final argUseApp = argResults.getOptionUseApp();
    final argDriver = argResults.getOptionDriver();
    final argScreenshot = argResults.getOptionScreenshot();

    YamlHelper.validateGitsYaml(argGitsYaml);

    if (argUseApp.isEmpty) {
      MelosHelper.format();
      'gits_cli l10n --gits-yaml "$argGitsYaml"'.run;
    }

    final flavor = FlavorHelper.byFlavor(argFlavor, argGitsYaml);

    FirebaseHelper.run(argFlavor, argGitsYaml);

    List<String> dartDefines = [];
    flavor.forEach((key, value) {
      dartDefines.add('${Constants.dartDefine} "$key=$value"');
    });
    String mode = argResults.getMode();

    FlutterHelper.run(
      'driver -t "$argTarget" $argDriver ${dartDefines.join(' ')} $argUseApp $argScreenshot --no-pub $mode',
      showLog: true,
    );

    StatusHelper.success('drive');
  }
}
