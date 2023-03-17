import 'package:gits_cli/dependency_manager.dart';

abstract class CucumberHelper {
  static void removeNdjsonGherkin() {
    final path =
        join(current, 'integration_test', 'ndjson', 'ndjson_gherkin.json');
    if (exists(path)) {
      delete(path);
    }
  }
}
