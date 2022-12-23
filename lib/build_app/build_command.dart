import 'package:gits_cli/build_app/apk/apk_command.dart';
import 'package:gits_cli/build_app/appbundle/appbundle_command.dart';
import 'package:gits_cli/build_app/ios/ios_command.dart';
import 'package:gits_cli/build_app/ipa/ipa_command.dart';
import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';

class BuildCommand extends Command {
  BuildCommand() {
    addSubcommand(ApkCommand());
    addSubcommand(AppbundleCommand());
    addSubcommand(IpaCommand());
    addSubcommand(IosCommand());
  }

  @override
  String get name => 'build';

  @override
  String get description => 'Build an app to android or ios';

  @override
  String get category => Constants.build;
}
