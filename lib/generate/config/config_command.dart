import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/extensions/extensions.dart';
import 'package:gits_cli/helper/helper.dart';

class ConfigCommand extends Command {
  ConfigCommand() {
    argParser.addOptionTarget();
    argParser.addOptionGitsYaml();
  }

  @override
  String get name => 'config';

  @override
  String get description =>
      'Generate launch.json & tasks.json related with config.';

  @override
  String get category => Constants.generate;

  @override
  void run() {
    final argTarget = argResults.getOptionTarget();
    final argGitsYaml = argResults.getOptionGitsYaml();

    YamlHelper.validateGitsYaml(argGitsYaml);
    List<String> dartDefinesDev = [];
    List<String> dartDefinesStag = [];
    List<String> dartDefinesProd = [];
    FlavorHelper.dev(argGitsYaml).forEach((key, value) {
      dartDefinesDev.add('"${Constants.dartDefine}"');
      dartDefinesDev.add('"$key=$value"');
    });
    FlavorHelper.stag(argGitsYaml).forEach((key, value) {
      dartDefinesStag.add('"${Constants.dartDefine}"');
      dartDefinesStag.add('"$key=$value"');
    });
    FlavorHelper.prod(argGitsYaml).forEach((key, value) {
      dartDefinesProd.add('"${Constants.dartDefine}"');
      dartDefinesProd.add('"$key=$value"');
    });

    if (!exists(join(current, '.vscode'))) {
      createDir(join(current, '.vscode'), recursive: true);
    }

    join(current, '.vscode', 'launch.json').write('''{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Gits Debug Dev",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "preLaunchTask": "build-dev",
            "program": "$argTarget",
            "args": [
                ${dartDefinesDev.join(',\n\t\t\t\t')}
            ]
        },
        {
            "name": "Gits Debug Stag",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "preLaunchTask": "build-stag",
            "program": "$argTarget",
            "args": [
                ${dartDefinesStag.join(',\n\t\t\t\t')}
            ]
        },
        {
            "name": "Gits Debug Prod",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "preLaunchTask": "build-prod",
            "program": "$argTarget",
            "args": [
                ${dartDefinesProd.join(',\n\t\t\t\t')}
            ]
        },
        {
            "name": "Gits Profile Dev",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile",
            "preLaunchTask": "build-dev",
            "program": "$argTarget",
            "args": [
                ${dartDefinesDev.join(',\n\t\t\t\t')}
            ]
        },
        {
            "name": "Gits Profile Stag",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile",
            "preLaunchTask": "build-stag",
            "program": "$argTarget",
            "args": [
                ${dartDefinesStag.join(',\n\t\t\t\t')}
            ]
        },
        {
            "name": "Gits Profile Prod",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile",
            "preLaunchTask": "build-prod",
            "program": "$argTarget",
            "args": [
                ${dartDefinesProd.join(',\n\t\t\t\t')}
            ]
        },
        {
            "name": "Gits Release Dev",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "preLaunchTask": "build-dev",
            "program": "$argTarget",
            "args": [
                ${dartDefinesDev.join(',\n\t\t\t\t')}
            ]
        },
        {
            "name": "Gits Release Stag",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "preLaunchTask": "build-stag",
            "program": "$argTarget",
            "args": [
                ${dartDefinesStag.join(',\n\t\t\t\t')}
            ]
        },
        {
            "name": "Gits Release Prod",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "preLaunchTask": "build-prod",
            "program": "$argTarget",
            "args": [
                ${dartDefinesProd.join(',\n\t\t\t\t')}
            ]
        }
    ]
}''');

    join(current, '.vscode', 'tasks.json').write('''{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "gits-format",
            "command": "gits format",
            "type": "shell"
        },
        {
            "label": "gits-config",
            "command": "gits config",
            "type": "shell"
        },
        {
            "label": "firebase-dev",
            "command": "gits firebase -f dev",
            "type": "shell"
        },
        {
            "label": "firebase-stag",
            "command": "gits firebase -f stag",
            "type": "shell"
        },
        {
            "label": "firebase-prod",
            "command": "gits firebase -f prod",
            "type": "shell"
        },
        {
            "label": "build-dev",
            "dependsOn": [
                "gits-format",
                "gits-config",
                "firebase-dev",
            ],
        },
        {
            "label": "build-stag",
            "dependsOn": [
                "gits-format",
                "gits-config",
                "firebase-stag",
            ],
        },
        {
            "label": "build-prod",
            "dependsOn": [
                "gits-format",
                "gits-config",
                "firebase-prod",
            ],
        },
    ]
}''');

    StatusHelper.generated(join(current, '.vscode', 'launch.json'));
    StatusHelper.generated(join(current, '.vscode', 'tasks.json'));

    StatusHelper.success('gits config');
  }
}
