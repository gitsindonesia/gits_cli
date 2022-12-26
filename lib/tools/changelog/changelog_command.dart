import 'dart:io';

import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';

class ChangelogCommand extends Command {
  ChangelogCommand() {
    argParser.addOption(
      'path',
      help: 'Path changelog file',
    );
  }

  @override
  String get name => 'changelog';

  @override
  String get description => 'get latest changelog';

  @override
  String get category => Constants.tools;

  String getLatestChangelog(String changelog) {
    final regex = RegExp(r'(#+)(\s+)?(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)');
    final match = regex.allMatches(changelog).take(2).toList();
    if (match.length == 2) {
      return changelog.substring(match[0].start, match[1].start);
    } else {
      return changelog;
    }
  }

  @override
  void run() {
    final pathArgs = argResults?['path'] ?? 'CHANGELOG.md';
    String changelog = '';
    final path = join(current, pathArgs);

    if (exists(join(current, path))) {
      changelog = File(path).readAsStringSync();
    }
    print(getLatestChangelog(changelog));
  }
}
