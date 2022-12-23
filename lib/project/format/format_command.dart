import 'package:gits_cli_command/constants.dart';
import 'package:gits_cli_command/dependency_manager.dart';
import 'package:gits_cli_command/helper/melos_helper.dart';
import 'package:gits_cli_command/helper/status_helper.dart';

class FormatCommand extends Command {
  @override
  String get name => 'format';

  @override
  String get description => 'Format all files .dart.';

  @override
  String get category => Constants.project;

  @override
  void run() {
    MelosHelper.run('melos run format');
    StatusHelper.success('gits_cli format');
  }
}
