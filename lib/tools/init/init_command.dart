import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/status_helper.dart';

class InitCommand extends Command {
  @override
  String get name => 'init';

  @override
  String get description => 'Init a new project from starter kit';

  @override
  String get category => Constants.tools;

  @override
  void run() {
    if (!exists(join(current, 'pubspec.yaml'))) {
      StatusHelper.failed(
          'You don\'t have "pubspec.yaml" in root apps, make sure to select project flutter');
    }

    if (exists(join(current, 'gits.yaml'))) {
      StatusHelper.warning('you already have gits.yaml in your project root');
    } else {
      join(current, 'gits.yaml').write('''flavor:
  dev:
    FLAVOR: dev
    APP_NAME: Kit Dev
    ANDROID_APPLICATION_ID: id.gits.flutter_starter_kit.dev
    IOS_APPLICATION_ID: id.gits.flutterStarterKit.dev
    BASE_URL: https://reqres.in/api
  stag:
    FLAVOR: stag
    APP_NAME: Kit Stag
    ANDROID_APPLICATION_ID: id.gits.flutter_starter_kit.stag
    IOS_APPLICATION_ID: id.gits.flutterStarterKit.stag
    BASE_URL: https://reqres.in/api
  prod:
    FLAVOR: prod
    APP_NAME: Kit
    ANDROID_APPLICATION_ID: id.gits.flutter_starter_kit
    IOS_APPLICATION_ID: id.gits.flutterStarterKit
    BASE_URL: https://reqres.in/api

localization:
  arb_dir: assets/assets/l10n
  template_arb_file: id.arb
  output_localization_file: s.dart
  output_class: S
  output_dir: core/lib/src/l10n
  replace: false
  
firebase:
  google_service_dev_dir: firebase/dev
  google_service_stag_dir: firebase/stag
  google_service_prod_dir: firebase/prod
  output_android_dir: android/app
  output_ios_dir: ios

assets:
  pubspec_dir: assets
  assets_dir: assets/assets
  output_dir: assets/lib
  create_library_file: true
  
coverage:
  lcov_dir: coverage/lcov.info
  output_html_dir: coverage/html
  remove:
    - "*/mock/*"
    - "*.freezed.*"
    - "*.g.*"
    - "*/l10n/*"
    - "*_state.dart"
    - "*_event.dart"
    - "**/locator.dart"
    - "**/environtment.dart"
    - "core/lib/src/test/*"
    - "core/lib/src/constants/*"
    - "core/lib/src/themes/*"
    - "lib/routes/routes.dart"
    - "lib/generated_plugin_registrant.dart"
''');

      StatusHelper.generated(join(current, 'gits.yaml'));
    }
  }
}
