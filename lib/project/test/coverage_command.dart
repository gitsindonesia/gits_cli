import 'dart:io';

import 'package:gits_cli_command/constants.dart';
import 'package:gits_cli_command/dependency_manager.dart';
import 'package:gits_cli_command/extensions/extensions.dart';
import 'package:gits_cli_command/helper/helper.dart';

class CoverageCommand extends Command {
  CoverageCommand() {
    argParser.addOptionGitsYaml();
  }

  @override
  String get name => 'coverage';

  @override
  String get description =>
      'Run Flutter test coverage for the current project & all modules.';

  @override
  String get category => Constants.project;

  final pathCoverageHelper = 'test/coverage_helper_test.dart';

  @override
  void run() async {
    final argGitsYaml = argResults.getOptionGitsYaml();

    YamlHelper.validateGitsYaml(argGitsYaml);
    final gitsYaml = YamlHelper.loadFileYaml(argGitsYaml);

    if (!gitsYaml.containsKey('coverage')) {
      StatusHelper.failed('gits.yaml not contain coverage config!');
    }

    final list = find('pubspec.yaml').toList();

    for (var pathPubspec in list) {
      final path = pathPubspec.replaceAll('/pubspec.yaml', '');
      final packageName = getYaml(pathPubspec)['name'];
      await createCoverageHelperTest(path, packageName);
    }

    MelosHelper.run('melos run coverage');

    final pathCoverageLcov = 'coverage/lcov.info';
    if (!exists(pathCoverageLcov)) {
      touch(pathCoverageLcov, create: true);
    }

    for (var pathPubspec in list) {
      final path = pathPubspec.replaceAll('/pubspec.yaml', '');
      try {
        delete('$path/$pathCoverageHelper');
      } catch (e) {
        StatusHelper.warning('$path/$pathCoverageHelper not exists!');
      }

      final pathReplace = path.replaceAll('$current/', '');
      if (path != current) {
        replace('$path/$pathCoverageLcov', 'SF:lib/', 'SF:$pathReplace/lib/');
      }

      read('$path/$pathCoverageLcov').forEach((line) {
        pathCoverageLcov.append(line);
      });
    }

    if (Platform.isWindows) {
      print(
          'you must install perl and lcov then lcov remove file will be ignore to coverage manually & generate report to html manually.');
    }

    if (which('lcov').notfound) {
      StatusHelper.failed(
          'lcov not found, failed to remove ignore file to test.');
    }

    final lcovDir = gitsYaml['coverage']['lcov_dir'];
    final outputHtmlDir = gitsYaml['coverage']['output_html_dir'];
    final removeFile = (gitsYaml['coverage']['remove'] as List).join(' ');

    print("lcov --remove $lcovDir $removeFile -o $lcovDir");

    "lcov --remove $lcovDir $removeFile -o $lcovDir".run;

    if (which('genhtml').notfound) {
      StatusHelper.failed('failed cannot generate report lcov html.');
    }
    'genhtml $lcovDir -o $outputHtmlDir'.run;

    StatusHelper.success();
  }

  Map<dynamic, dynamic> getYaml(String path) {
    final File file = File(path);
    final String yamlString = file.readAsStringSync();
    return loadYaml(yamlString);
  }

  Future<void> createCoverageHelperTest(String path, String packageName) async {
    final cwd = Directory(path).uri;
    final libDir = Directory.fromUri(cwd.resolve('lib'));
    final testDir = Directory.fromUri(cwd.resolve('test'));
    final buffer = StringBuffer();

    DirectoryHelper.createDir(testDir.path);

    var files = libDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) =>
            file.path.endsWith('.dart') &&
            !file.path.contains('.freezed.') &&
            !file.path.contains('.g.') &&
            !file.path.endsWith('generated_plugin_registrant.dart') &&
            !file.readAsLinesSync().any((line) => line.startsWith('part of')))
        .toList();

    buffer.writeln('// GENERATED GITS COVERAGE HELPER TEST');
    buffer.writeln();
    buffer.writeln('// ignore_for_file: unused_import');
    buffer.writeln("import 'package:flutter_test/flutter_test.dart';");

    for (var file in files) {
      final fileLibPath =
          file.uri.toFilePath().substring(libDir.uri.toFilePath().length);
      buffer.writeln('import \'package:$packageName/$fileLibPath\';');
    }

    buffer.writeln();
    buffer.writeln('''void main() {
  test('generated helper test', () {
    expect(1, 1);
  });
    }''');
    buffer.writeln();

    final output = File(cwd.resolve(pathCoverageHelper).toFilePath());
    await output.writeAsString(buffer.toString());
  }
}
