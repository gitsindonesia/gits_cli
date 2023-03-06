import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/helper.dart';

extension ArgResultsExtension on ArgResults? {
  String getOptionTarget() => this?['target'] ?? 'lib/main.dart';
  String getOptionGitsYaml() {
    final path = join(current, 'pubspec.yaml');
    if (exists(path)) {
      final pathGitsCli = YamlHelper.loadFileYaml(path)['gits_cli'];
      if (pathGitsCli != null) {
        return pathGitsCli;
      }
    }
    return this?['gits-yaml'] ?? join(current, 'gits.yaml');
  }

  String getOptionFlavor({required String defaultTo}) =>
      this?['flavor'] ?? defaultTo;
  String getOptionExportMethod() => this?['export-method'] != null
      ? '--export-method "${this!['export-method']}"'
      : '';
  String? getOptionExportOptionsPlist() => this?['export-options-plist'] != null
      ? '--export-options-plist "${this!['export-options-plist']}"'
      : '';
  String getOptionBuildNumber() => this?['build-number'] != null
      ? '--build-number=${this!['build-number']}'
      : '';
  String getOptionBuildName() =>
      this?['build-name'] != null ? '--build-name=${this!['build-name']}' : '';

  bool getFlagDebug() => this?['debug'];
  bool getFlagProfile() => this?['profile'];
  bool getFlagRelease() => this?['release'];
  String getFlagCodesign() =>
      this?['codesign'] ? '--codesign' : '--no-codesign';
  bool getFlagQa() => this?['qa'];

  String getMode() {
    String mode = '--release';
    if (getFlagDebug()) {
      mode = '--debug';
    } else if (getFlagProfile()) {
      mode = '--profile';
    }
    return mode;
  }

  String getFlagObfuscate() => this?['obfuscate'] ? '--obfuscate' : '';
  String getOptionSplitDebugInfo() =>
      this?['split-debug-info'] != null && this?['obfuscate']
          ? '--split-debug-info=${this!['split-debug-info']}'
          : '';

  String getOptionUseApp() => this?['use-app'] != null
      ? '--use-application-binary="${this?['use-app']}"'
      : '';
  String getOptionDriver() =>
      this?['driver'] != null ? '--driver="${this?['driver']}"' : '';
  String getOptionScreenshot() => this?['screenshot'] != null
      ? '--screenshot="${this?['screenshot']}"'
      : '';
}
