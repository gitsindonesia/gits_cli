import 'dart:io';

import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/status_helper.dart';

abstract class YamlHelper {
  static void validateGitsYaml([String? gitsYaml]) {
    if (!exists(join(current, 'gits.yaml')) && gitsYaml == null) {
      StatusHelper.failed(
          'You don\'t have "gits.yaml" in root apps, make sure to "gits init" first');
    } else if (gitsYaml != null && !exists(gitsYaml)) {
      StatusHelper.failed('Not found custom path gits.yaml in "$gitsYaml"');
    }
  }

  static Map<dynamic, dynamic> loadFileYaml(String path) {
    final File file = File(path);
    final String yamlString = file.readAsStringSync();
    return loadYaml(yamlString);
  }
}
