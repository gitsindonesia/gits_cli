import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/helper.dart';

abstract class FirebaseHelper {
  static void run(String flavor, String pathGitsYaml) {
    'gits firebase -f $flavor --gits-yaml "$pathGitsYaml"'.run;
  }

  static Map<dynamic, dynamic> getFirebaseConfig(String pathGitsYaml) {
    try {
      final yaml = YamlHelper.loadFileYaml(pathGitsYaml);
      return yaml['firebase'];
    } catch (e) {
      return {};
    }
  }
}
