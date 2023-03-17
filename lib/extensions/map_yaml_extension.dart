import 'package:gits_cli/helper/helper.dart';

extension MapYamlExtension on Map {
  String get projectName => this['project_name'] ?? 'gits';
  int get concurrent =>
      this['concurrent'] ?? GitsModularHelper.defaultConcurrent;
}
