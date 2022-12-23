import 'package:gits_cli_command/dependency_manager.dart';
import 'package:gits_cli_command/helper/status_helper.dart';
import 'package:gits_cli_command/helper/yaml_helper.dart';

class LocalizationHelper {
  LocalizationHelper(String pathGitsyaml) {
    final keyLocalization = 'localization';
    final keyArbDir = 'arb_dir';
    final keyTemplateArbFile = 'template_arb_file';
    final keyOutputLocalizationFile = 'output_localization_file';
    final keyOutputClass = 'output_class';
    final keyOutputDir = 'output_dir';
    final keyReplace = 'replace';

    final yaml = YamlHelper.loadFileYaml(pathGitsyaml);
    final Map<dynamic, dynamic> localization = yaml[keyLocalization];

    _abrDir = localization[keyArbDir] ?? '';
    _templateArbFile = localization[keyTemplateArbFile] ?? '';
    _outputLocalizationFile = localization[keyOutputLocalizationFile] ?? '';
    _outputClass = localization[keyOutputClass] ?? '';
    _outputDir = localization[keyOutputDir] ?? '';
    _replace = localization[keyReplace] == true;

    if (!exists(_abrDir)) {
      StatusHelper.failed(
          '''The '$keyArbDir' directory, 'LocalDirectory: '$_abrDir'', does not exist.
Make sure that the correct path was provided.''');
    }

    if (!exists('$_abrDir/$_templateArbFile')) {
      StatusHelper.failed(
          '''The '$keyTemplateArbFile' directory, 'LocalFile: '$_abrDir/$_templateArbFile'', does not exist.
Make sure that the correct path file was provided.''');
    }
  }

  late String _abrDir;
  late String _templateArbFile;
  late String _outputLocalizationFile;
  late String _outputClass;
  late String _outputDir;
  late bool _replace;

  String get arbDir => _abrDir;
  String get templateArbFile => _templateArbFile;
  String get outputLocalizationFile => _outputLocalizationFile;
  String get outputClass => _outputClass;
  String get outputDir => _outputDir;
  bool get replace => _replace;
}
