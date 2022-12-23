import 'package:gits_cli_command/constants.dart';
import 'package:gits_cli_command/dependency_manager.dart';
import 'package:gits_cli_command/helper/flutter_helper.dart';

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
      FlutterHelper.run('--version');
    } else {
      printerr('${red('[x]')} Flutter not installed');
      printerr(
        'You can install flutter in https://docs.flutter.dev/get-started/install',
      );
    }

    if (which('melos').found) {
      print('${green('[✓]')} Melos installed');
      'melos --version'.run;
    } else {
      printerr('${red('[x]')} Melos not installed');
      printerr(
        'You can install in https://docs.flutter.dev/get-started/install',
      );
    }
  }
}
