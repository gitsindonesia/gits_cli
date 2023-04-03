import 'dart:async';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/helper/helper.dart';

abstract class GitsModularHelper {
  static const int defaultConcurrent = 6;

  static Future<void> execute(
    List<String> commands, {
    int concurrent = defaultConcurrent,
    void Function(String)? customCommand,
    void Function(String line)? stdout,
  }) async {
    final workingDirectoryFlutter = find('pubspec.yaml', workingDirectory: '.')
        .toList()
        .map((e) => e.replaceAll('${separator}pubspec.yaml', ''))
        .sorted((a, b) =>
            b.split(separator).length.compareTo(a.split(separator).length));

    List<Future Function()> futures = [];

    for (var e in workingDirectoryFlutter) {
      futures.add(() async {
        final path = e.replaceAll(current, '.');
        try {
          print('🚀 $path: ${commands.join(', ')}');
          for (var command in commands) {
            command.start(
              workingDirectory: e,
              progress: Progress(
                (line) {
                  stdout?.call(line);
                },
                stderr: (line) {
                  if (line.isEmpty) return;
                  if (line.contains('Waiting for another flutter command')) {
                    return;
                  }
                  printerr(red(line));
                },
              ),
            );
          }
          customCommand?.call(e);
          print('✅  $path: ${commands.join(', ')}');
        } catch (e) {
          print('❌  $path: ${commands.join(', ')}');
          rethrow;
        }
      });
    }

    int runnable = 0;
    final length = futures.length;
    print('📦 Total Packages: $length');
    print('---------------------------------------');
    for (runnable = 0; runnable < length; runnable += concurrent) {
      int take =
          runnable + concurrent > length ? length % concurrent : concurrent;
      final isolate = futures
          .getRange(runnable, runnable + take)
          .map((e) => Isolate.run(e));
      await Future.wait(isolate);
    }
  }

  static Future<void> analyze({int concurrent = defaultConcurrent}) => execute(
        ['${FlutterHelper.getCommandFlutter()} analyze . --no-pub'],
        concurrent: concurrent,
        stdout: (line) {
          if (line.isEmpty) return;
          if (line.contains(RegExp(r'error'))) {
            printerr(red(line));
          }
          if (line.contains(RegExp(r'info'))) {
            printerr(blue(line));
          }
          if (line.contains(RegExp(r'warning'))) {
            printerr(orange(line));
          }
        },
      );
  static Future<void> clean({int concurrent = defaultConcurrent}) => execute(
        ['${FlutterHelper.getCommandFlutter()} clean'],
        customCommand: (workingDirectory) {
          final path = join(workingDirectory, 'pubspec.lock');
          if (exists(path)) {
            delete(path);
          }
        },
        concurrent: concurrent,
      );
  static Future<void> format() =>
      execute(['${FlutterHelper.getCommandDart()} format .']);
  static Future<void> get({int concurrent = defaultConcurrent}) => execute(
        ['${FlutterHelper.getCommandFlutter()} pub get'],
        concurrent: concurrent,
      );
  static Future<void> coverage({int concurrent = defaultConcurrent}) => execute(
        ['${FlutterHelper.getCommandFlutter()} test --coverage --no-pub'],
        concurrent: concurrent,
        stdout: (line) {
          if (line.isEmpty || line.contains(RegExp(r'\d{2}:\d{2}'))) return;
          print(red(line));
        },
      );
  static Future<void> test({int concurrent = defaultConcurrent}) => execute(
        ['${FlutterHelper.getCommandFlutter()} test --no-pub'],
        concurrent: concurrent,
        stdout: (line) {
          if (line.isEmpty || line.contains(RegExp(r'\d{2}:\d{2}'))) return;
          print(red(line));
        },
      );
  static Future<void> upgrade({int concurrent = defaultConcurrent}) => execute(
        [
          '${FlutterHelper.getCommandFlutter()} packages upgrade',
          '${FlutterHelper.getCommandFlutter()} packages get',
        ],
        concurrent: concurrent,
      );
}
