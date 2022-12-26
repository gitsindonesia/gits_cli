import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/helper.dart';

abstract class MelosHelper {
  static void init() {
    join(current, 'melos.yaml').write('''name: Gits

packages:
  - features/**
  - core/**
  - assets/**
  - .

command:
  bootstrap:
    usePubspecOverrides: true

scripts:
  lint:
    run: melos run analyze && melos run format:exit-if-changed
    description: Run all static analysis checks

  analyze:
    run: |
      melos exec -c 5 --fail-fast -- \\
        flutter analyze . --fatal-infos
    description: |
      Run `flutter analyze` in all packages.
        - Note: you can also rely on your IDEs Dart Analysis / Issues window.
  
  format:
    run: flutter format .
    description: |
      Run `flutter format .` in all packages.

  format:exit-if-changed:
    run: flutter format --set-exit-if-changed .
    description: |
      Run `flutter format --set-exit-if-changed .` in all packages.

  clean:all:
    run: melos exec -c 5 -- \\
        flutter clean && rm -f pubspec.lock
  
  get:
    run: melos exec -c 3 -- \\
        flutter packages get

  test:
    run: melos exec -c 3 -- \\
        flutter test

  build:runner:
    run: melos exec -c 1 -- \\
        flutter pub run build_runner build --delete-conflicting-outputs

  upgrade:major:
    run: |
      melos exec -c 5 -- \\
        flutter pub upgrade --major-versions
    description: |
      Run `flutter pub upgrade --major-versions` in all packages.
        - Note: this is can make break change for all package.
  upgrade:
    run: |
      melos exec -c 5 -- \\
        flutter pub upgrade
    description: |
      Run `flutter pub upgrade' in all packages.
      
  packages:upgrade:
    run: melos exec -c 3 -- 
        flutter packages upgrade && flutter packages get
    description: |
      upgrade packages dependency with ignore pubspec.lock then get all package.
      
  coverage:
    run: melos exec --fail-fast -- 
      flutter test --coverage
    description: |
      flutter test coverage.''');

    StatusHelper.generated(join(current, 'melos.yaml'));
  }

  static void run(String melos) {
    if (!exists(join(current, 'melos.yaml'))) {
      init();
    }
    melos.run;
  }

  static void format() {
    if (!exists(join(current, 'melos.yaml'))) {
      init();
    }
    'melos run format'.run;
  }
}
