import 'package:gits_cli/build_app/prebuild_ios/prebuild_ios_command.dart';
import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';

class PreBuildCommand extends Command {
  PreBuildCommand() {
    addSubcommand(PreBuildIosCommand());
  }

  @override
  String get name => 'prebuild';

  @override
  String get description => 'Prepare setup ios before build';

  @override
  String get category => Constants.build;
}
