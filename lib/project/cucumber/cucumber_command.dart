import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/extensions/extensions.dart';
import 'package:gits_cli/helper/helper.dart';

class CucumberCommand extends Command {
  CucumberCommand() {
    argParser.addOptionFlavor(defaultsTo: Constants.dev);
    argParser.addOptionGitsYaml();
  }
  @override
  String get name => 'cucumber';

  @override
  String get description =>
      'Generate integration test from gherkin in .feature';

  @override
  String get category => Constants.project;

  @override
  void run() {
    if (which('gherkin').notfound) {
      StatusHelper.failed('gherkin not found in your machine');
    }

    final now = DateTime.now();

    final specificFeature =
        argResults?.rest.firstOrNull?.replaceAll('.feature', '').split(',');

    final argFlavor = argResults.getOptionFlavor(defaultTo: Constants.dev);
    final argGitsYaml = argResults.getOptionGitsYaml();

    YamlHelper.validateGitsYaml(argGitsYaml);

    'gits_cli l10n --gits-yaml "$argGitsYaml"'.run;

    final flavor = FlavorHelper.byFlavor(argFlavor, argGitsYaml);
    FirebaseHelper.run(argFlavor, argGitsYaml);
    List<String> dartDefines = [];
    flavor.forEach((key, value) {
      dartDefines.add('${Constants.dartDefine} "$key=$value"');
    });

    String pattern =
        specificFeature?.map((e) => '$e.feature').join('|') ?? '*.feature';

    final features = find(
      pattern,
      workingDirectory: join(current, 'integration_test', 'features'),
    ).toList();

    List<Map<String, String>> ndjsons = [];

    for (var element in features) {
      final console = 'gherkin "$element"'.start(progress: Progress.capture());
      ndjsons.add({'ndjson': console.lines.join('\n')});
    }

    final pathNdjson = join(current, 'integration_test', 'ndjson');
    DirectoryHelper.createDir(pathNdjson);
    join(pathNdjson, 'ndjson_gherkin.json').write(jsonEncode(ndjsons));

    StatusHelper.generated(pathNdjson);

    print('Starting cucumber integration test....');

    FlutterHelper.start(
      'test integration_test/cucumber_test.dart ${dartDefines.join(' ')} --dart-define "INTEGRATION_TEST=true" --no-pub',
      progress: Progress((line) {
        if (line.contains('cucumber-report')) {
          final dir = join(current, 'integration_test', 'report');
          DirectoryHelper.createDir(dir);

          final cucumberReport = line.replaceAll('cucumber-report: ', '');
          join(dir, 'cucumber-report.json').write(cucumberReport);

          if (which('npm').found) {
            if (Platform.isWindows) {
              'npm.cmd install'.start(
                workingDirectory: join(current, 'integration_test', 'report'),
                progress: Progress.devNull(),
              );
            } else {
              'npm install'.start(
                workingDirectory: join(current, 'integration_test', 'report'),
                progress: Progress.devNull(),
              );
            }

            'node index.js'.start(
              workingDirectory: join(current, 'integration_test', 'report'),
              progress: Progress.devNull(),
            );

            print(
                '🚀 Cucumber HTML report cucumber-report.html generated successfully 👍');
          }
        } else if (line.contains('gits-cucumber-stdout')) {
          final message = line.replaceAll('gits-cucumber-stdout: ', '');
          print(message);
        }
      }),
    );

    final totalTime = DateTime.now().difference(now);
    print('⏰ Total Time: ${formatDurationInHhMmSs(totalTime)}');
  }

  String formatDurationInHhMmSs(Duration duration) {
    final hh = (duration.inHours).toString().padLeft(2, '0');
    final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$hh:$mm:$ss';
  }
}
