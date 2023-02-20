import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';

extension ArgParserExtension on ArgParser {
  void addOptionTarget() {
    addOption(
      'target',
      abbr: 't',
      help:
          '''The main entry-point file of the application, as run on the device.
If the "--target" option is omitted, but a file name is provided on the command line, then that is
used instead.''',
      defaultsTo: 'lib/main.dart',
    );
  }

  void addOptionGitsYaml() {
    addOption(
      'gits-yaml',
      help: '''Custom path gits.yaml.''',
    );
  }

  void addFlagDebug({bool defaultsTo = false}) {
    addFlag(
      'debug',
      help: 'Build a debug version of your app.',
      defaultsTo: defaultsTo,
      negatable: false,
    );
  }

  void addFlagProfile({bool defaultsTo = false}) {
    addFlag(
      'profile',
      help:
          'Build a version of your app specialized for performance profiling.',
      defaultsTo: defaultsTo,
      negatable: false,
    );
  }

  void addFlagRelease({bool defaultsTo = true}) {
    addFlag(
      'release',
      help: 'Build a release version of your app  (default mode).',
      defaultsTo: defaultsTo,
      negatable: false,
    );
  }

  void addFlagQa({bool defaultsTo = false}) {
    addFlag(
      'qa',
      help:
          'Build a version of your app specialized for QA Integration test with flutter driver extension. will ignore --debug, --profile & --release, build will auto build in --profile',
      defaultsTo: defaultsTo,
      negatable: false,
    );
  }

  void addOptionFlavor({required String defaultsTo}) {
    addOption(
      'flavor',
      abbr: 'f',
      help: 'Select flavor apps.',
      allowed: [Constants.dev, Constants.stag, Constants.prod],
      defaultsTo: defaultsTo,
    );
  }

  void addOptionExportMethod() {
    addOption(
      'export-method',
      help: 'Specify how the IPA will be distributed.',
      allowed: ['ad-hoc', 'app-store', 'development', 'enterprise'],
    );
  }

  void addOptionExportOptionsPlist() {
    addOption(
      'export-options-plist',
      help:
          'Export an IPA with these options. See "xcodebuild -h" for available exportOptionsPlist keys.',
    );
  }

  void addOptionBuildNumber() {
    addOption(
      'build-number',
      help: '''An identifier used as an internal version number.
Each build must have a unique identifier to differentiate it from previous builds.
It is used to determine whether one build is more recent than another, with higher numbers indicating more recent build.
On Android it is used as "versionCode".
On Xcode builds it is used as "CFBundleVersion".''',
    );
  }

  void addOptionBuildName() {
    addOption(
      'build-name',
      help: '''A "x.y.z" string used as the version number shown to users.
For each new version of your app, you will provide a version number to differentiate it from previous versions.
On Android it is used as "versionName".
On Xcode builds it is used as "CFBundleShortVersionString"".''',
    );
  }

  void addFlagCodesign({bool defaultsTo = true}) {
    addFlag(
      'codesign',
      help:
          'Codesign the application bundle (only available on device builds).',
      defaultsTo: defaultsTo,
    );
  }

  void addFlagObfuscate() {
    addFlag(
      'obfuscate',
      help:
          '''In a release build, this flag removes identifiers and replaces them with randomized values for the purposes of source code obfuscation. This flag must always be combined with
"--split-debug-info" option, the mapping between the values and the original identifiers is stored in the symbol map created in the specified directory. For an app built with
this flag, the "flutter symbolize" command with the right program symbol file is required to obtain a human readable stack trace.''',
      defaultsTo: true,
    );
  }

  void addOptionSplitDebugInfo() {
    addOption(
      'split-debug-info',
      help:
          '''In a release build, this flag reduces application size by storing Dart program symbols in a separate file on the host rather than in the application. The value of the flag
should be a directory where program symbol files can be stored for later use. These symbol files contain the information needed to symbolize Dart stack traces. For an app built
with this flag, the "flutter symbolize" command with the right program symbol file is required to obtain a human readable stack trace.
This flag cannot be combined with "--analyze-size".''',
      defaultsTo: './.symbols/',
    );
  }

  void addOptionUseApp() {
    addOption(
      'use-app',
      abbr: 'a',
      help:
          '''Specify a pre-built application binary to use when running. For Android applications, this must be the
path to an APK. For iOS applications, the path to an IPA. Other device types do not yet support
prebuilt application binaries.''',
    );
  }

  void addOptionDriver() {
    addOption(
      'driver',
      abbr: 'd',
      help:
          '''The test file to run on the host (as opposed to the target file to run on the device).
By default, this file has the same base name as the target file, but in the "test_driver/" directory
instead, and with "_test" inserted just before the extension, so e.g. if the target is
"lib/main.dart", the driver will be "test_driver/main_test.dart".''',
    );
  }

  void addOptionScreenshot() {
    addOption(
      'screenshot',
      help: 'Directory location to write screenshots on test failure.',
    );
  }
}
