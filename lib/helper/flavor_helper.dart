import 'package:gits_cli_command/constants.dart';
import 'package:gits_cli_command/helper/yaml_helper.dart';

abstract class FlavorHelper {
  static Map<dynamic, dynamic> dev(String pathGitsYaml) {
    final yaml = YamlHelper.loadFileYaml(pathGitsYaml);
    final Map<dynamic, dynamic> flavor = yaml['flavor'];
    return flavor[Constants.dev];
  }

  static Map<dynamic, dynamic> stag(String pathGitsYaml) {
    final yaml = YamlHelper.loadFileYaml(pathGitsYaml);
    final Map<dynamic, dynamic> flavor = yaml['flavor'];
    return flavor[Constants.stag];
  }

  static Map<dynamic, dynamic> prod(String pathGitsYaml) {
    final yaml = YamlHelper.loadFileYaml(pathGitsYaml);
    final Map<dynamic, dynamic> flavor = yaml['flavor'];
    return flavor[Constants.prod];
  }

  static Map<dynamic, dynamic> byFlavor(String flavor, String pathGitsYaml) {
    switch (flavor) {
      case Constants.prod:
        return prod(pathGitsYaml);
      case Constants.stag:
        return stag(pathGitsYaml);
      default:
        return dev(pathGitsYaml);
    }
  }
}
