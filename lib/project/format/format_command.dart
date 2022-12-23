import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/melos_helper.dart';
import 'package:gits_cli/helper/status_helper.dart';

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
    StatusHelper.success('gits format');
  }
}
