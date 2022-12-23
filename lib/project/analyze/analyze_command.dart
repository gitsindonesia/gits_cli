import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/melos_helper.dart';
import 'package:gits_cli/helper/status_helper.dart';

class AnalyzeCommand extends Command {
  @override
  String get name => 'analyze';

  @override
  String get description => 'Analyze code in all packages.';

  @override
  String get category => Constants.project;

  @override
  void run() {
    MelosHelper.run('melos run analyze');
    StatusHelper.success('gits analyze');
  }
}
