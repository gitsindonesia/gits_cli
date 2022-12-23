import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/melos_helper.dart';
import 'package:gits_cli/helper/status_helper.dart';

class TestCommand extends Command {
  @override
  String get name => 'test';

  @override
  String get description =>
      'Run Flutter unit tests for the current project & all modules.';

  @override
  String get category => Constants.project;

  @override
  void run() {
    MelosHelper.run('melos run test');
    StatusHelper.success('gits test');
  }
}
