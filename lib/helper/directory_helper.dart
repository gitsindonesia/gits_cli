import 'package:gits_cli_command/dependency_manager.dart' as dependency_manager;

abstract class DirectoryHelper {
  static void createDir(String path, {bool recursive = false}) {
    if (!dependency_manager.exists(path)) {
      dependency_manager.createDir(path, recursive: true);
    }
  }
}
