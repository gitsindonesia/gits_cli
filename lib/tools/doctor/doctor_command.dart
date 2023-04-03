import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/flutter_helper.dart';

class DoctorCommand extends Command {
  @override
  String get name => 'doctor';

  @override
  String get description => 'Show information about the installed tooling.';

  @override
  String get category => Constants.tools;

  @override
  void run() {
    if (which('flutter').found) {
      print('${green('[✓]')} Flutter installed');
      FlutterHelper.run('doctor');
    } else {
      printerr('${red('[x]')} Flutter not installed');
      printerr(
        'You can install flutter in https://docs.flutter.dev/get-started/install',
      );
    }

    if (which('gherkin').found) {
      print('${green('[✓]')} Gherkin installed');
    } else {
      printerr('${red('[x]')} Gherkin not installed');
      printerr(
        'You can install in https://github.com/gitsindonesia/gits_cli/releases/tag/cucumber',
      );
    }

    if (which('lcov').found) {
      print('${green('[✓]')} lcov installed');
    } else {
      printerr('${red('[x]')} lcov not installed');
      printerr(
        'You can follow installation in https://github.com/linux-test-project/lcov',
      );
    }
  }
}
