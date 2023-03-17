# Gits CLI

Gits CLI is dart command line interface for Gits Flutter Project.

## Table of Contents

- [Gits CLI](#gits-cli)
  - [Table of Contents](#table-of-contents)
  - [Requirement](#requirement)
  - [IDE Recommendation](#ide-recommendation)
  - [Installations](#installations)
  - [Usage](#usage)
  - [Command List](#command-list)
    - [General Commands](#general-commands)
      - [Version](#version)
      - [Help](#help)
      - [Changelog](#changelog)
      - [Doctor](#doctor)
    - [Project Commands](#project-commands)
      - [Init](#init)
      - [Config](#config)
      - [Get](#get)
      - [Upgrade](#upgrade)
      - [Run](#run)
      - [Analyze](#analyze)
      - [Test](#test)
      - [Drive](#drive)
      - [Test-Drive](#test-drive)
      - [Coverage](#coverage)
      - [Format](#format)
      - [Clean](#clean)
      - [Cucumber](#cucumber)
    - [Build Project Commands](#build-project-commands)
      - [Android APK File Format](#android-apk-file-format)
      - [Android App Bundle](#android-app-bundle)
      - [IOS IPA File Format](#ios-ipa-file-format)
      - [IOS App Bundle](#ios-app-bundle)
      - [Build Project Options](#build-project-options)
    - [Generate Commands](#generate-commands)
      - [Firebase](#firebase)
      - [l10n (Languages)](#l10n-languages)

## Requirement

- Dart SDK 2.17 or latest version

## IDE Recommendation

- VSCode

## Installations

Install gits_cli by this command :

```dart
dart pub global activate gits_cli
```

Make sure gits_cli was installed, you can check by this command :

```dart
gits_cli -v
```

If this directory is missing from your PATH, locate the file for your platform and add it.

| Platform       | Cache location               |
|----------------|------------------------------|
| macOS or Linux | HOME/.pub-cache/bin          |
| Windows*       | %LOCALAPPDATA%\Pub\Cache\bin |

## Usage

To use the Gits CLI, you must run the `gits_cli` command from the terminal on your project directory.

## Command List

### General Commands

#### Version

This command is used to check the CLI version.

```bash
gits_cli -v
```

Alternative:

```bash
gits_cli --version
```

#### Help

This command is used to view the list contained in the CLI.

```bash
gits_cli -h
```

Alternative:

```bash
gits_cli --help
```

#### Changelog

This command is used to get latest changelog.

```bash
gits_cli changelog
```

#### Doctor

This command is used to show information about the installed tooling.

```bash
gits_cli doctor
```

### Project Commands

#### Init

This command is used to initialize the project to generate project configuration files in the form of `gits.yaml` files.

```bash
gits_cli init
```

This command only works if the `gits.yaml` files do not exist.

#### Config

This command is used to generate the `.vscode/launch.json` and `.vscode/task.json` files according to the configuration in the `gits.yaml` file.

```bash
gits_cli config
```

![VSCode Config](https://raw.githubusercontent.com/gitsindonesia/gits_cli/main/assets/file_generated.png)

This command is specific to VSCode IDE user.

#### Get

This command gets all the dependencies listed in `the pubspec.yaml` file in the current working directory, as well as their transitive dependencies.

```bash
gits_cli get
```

#### Upgrade

This command is used to upgrade the current package's dependencies to latest versions.

```bash
gits_cli upgrade
```

Options :

```bash
gits_cli upgrade [argument]
```

| Argument | Alternative    | Description                                                                  |
| -------- | -------------- | ---------------------------------------------------------------------------- |
| `-a`     | `--all`        | Upgrade all project package's dependencies to latest versions                |
| `-d`     | `--dependency` | Upgrade all dependency_manager package's dependencies to latest versions     |
| `-g`     | `--gits_cli`   | Upgrade all gits_library package's dependencies to latest versions (Default) |

#### Run

This command has a function to run our project. With this command we can adjust which project environment and which application version we want to run according to the project configuration in the `gits.yaml` file. By default this command will run the project on **the dev environment release version**.

```bash
gits_cli run
```

Options :

```bash
gits_cli run [flavor/environment] [app_version] [custom_target]
```

- Flavor/Environment :  
  
| Flavor/Environment | Alternative | Description |
|----------|-------------|-------------|
| `-f dev` | `--flavor dev` | Run project on dev environment (Default) |
| `-f stag` | `--flavor stag` | Run project on staging environment|
| `-f prod` | `--flavor prod` | Run project on production environment |

- App Version :
  
| App Version | Description |
|----------|-------------|
| `--debug` |Run project on debug mode (Default) |
| `--profile` | Run project on profile mode|
| `--release` | Run project on release mode (Default) |

- Custom Target :
  
| Custom Target | Alternative | Description |
|----------|-------------|-------------|
| `-t [url_file]` | `--target [url_file]` | This command is used to run the application in a specific file, by default it will run the `lib/main.dart` file. |

Example :

```bash
gits_cli run --release -f stag
```

This following command will run your app on staging environment with release mode.

#### Analyze

This command is used to analyze code in all packages.

```bash
gits_cli analyze
```

#### Test

This command is used to run all unit tests in our project.

```bash
gits_cli test
```

#### Drive

This command is used to run an integration test on our device, make sure the device/emulator is available.

```bash
gits_cli drive
```

#### Test-Drive

This command is used to run all integration tests on our device, make sure the device/emulator is available.

```bash
gits_cli test-drive
```

#### Coverage

This command is used to calculate our code coverage based on the tests that have been made. Code coverage will not be generated if all the tests we make have not been passed.

```bash
gits_cli coverage
```

#### Format

This command is used to perform automatic `.dart` file formatting, where the code that we have created will be adjusted, for example by removing unused import lines and adding cons.

```bash
gits_cli format
```

#### Clean

This command is used to delete the l10n, build/ and .dart_tool/ in main, core & features directories.

```bash
gits_cli clean
```

#### Cucumber

First you need to download `gherkin` executable in this [release](https://github.com/gitsindonesia/gits_cli/releases/tag/cucumber)

make sure `gherkin` was export in your machine.

For setup your gits_cucumber please follow [documentation](https://pub.dev/packages/gits_cucumber):

Once your done setup, then run command:

```console
gits_cli cucumber
```

or your need to be specific feature you can do run command:

```console
gits_cli cucumber login
```

or multiple

```console
gits_cli cucumber login,register,home
```

by default run `integration_test/cucumber_test.dart` by flavor dev. if you want to running flavor stag or prod just add argument `--flavor stag` or `--flavor prod`

### Build Project Commands

#### Android APK File Format

```bash
gits_cli build apk
```

This command is used to build the project in the form of an `.apk` file. By default this command will build the project with the release version staging flavor. After the building process is complete, we can check the `.apk` file in the `build/app/outputs/apk/` and `build/app/outputs/flutter-apk/` folders.

Options :

```bash
gits_cli build apk [flavor/environment] [app_version] [custom_target] [build_number] [build_name] [[no-]obfuscate] [split-debug-info]
```

You can check all options on [this section.](#build-project-options)

Examples :

- Building application with dev environment profile mode
  
  ```bash
  gits_cli build apk --profile -f dev
  ```

- Building application with prod environment release mode with custom name `my_app`
  
  ```bash
  gits_cli build apk --release -f prod --build-name my_app
  ```

#### Android App Bundle

```bash
gits_cli build appbundle
```

This command is used to build the project in the form of an `.abb` file. By default this command will build the project with the release version staging flavor. After the building process is complete, we can check the `.abb` file in the `build/app/outputs/appbundle/` and `build/app/outputs/flutter-appbundle/` folders.

Options :

```bash
gits_cli build appbundle [flavor/environment] [app_version] [custom_target] [build_number] [build_name] [[no-]obfuscate] [split-debug-info]
```

You can check all options on [this section.](#build-project-options)

Examples :

- Building application with dev environment profile mode
  
  ```bash
  gits_cli build appbundle --profile -f dev
  ```

- Building application with prod environment release mode with custom name `my_app`
  
  ```bash
  gits_cli build appbundle --release -f prod --build-name my_app
  ```

#### IOS IPA File Format

```bash
gits_cli build ipa
```

This command is used to build the project in the form of an `.ipa` file. By default this command will build the project with the release version staging flavor. After the building process is complete, we can check the `.ipa` file in the `build/ios/ipa/` or we can use the archive file in `build/ios/archive/` folders.

Options :

```bash
gits_cli build ipa [flavor/environment] [app_version] [custom_target] [build_number] [build_name] [[no-]obfuscate] [split-debug-info]
```

You can check all options on [this section.](#build-project-options)

Examples :

- Building application with dev environment profile mode
  
  ```bash
  gits_cli build ipa --profile -f dev
  ```

- Building application with prod environment release mode with custom name `my_app`
  
  ```bash
  gits_cli build ipa --release -f prod --build-name my_app
  ```

#### IOS App Bundle

```bash
gits_cli build ios
```

This command is used to build ios application bundle, this command only work on Max OS X. By default this command will build the project with the release version staging flavor. After the building process is complete, we can check the `.ipa` file in the `build/ios/ipa/` or we can use the archive file in `build/ios/archive/` folders.

Options :

```bash
gits_cli build ios [flavor/environment] [app_version] [custom_target] [build_number] [build_name] [[no-]obfuscate] [split-debug-info]
```

You can check all options on [this section.](#build-project-options)

Examples :

- Building application with dev environment profile mode
  
  ```bash
  gits_cli build ios --profile -f dev
  ```

- Building application with prod environment release mode with custom name `my_app`
  
  ```bash
  gits_cli build ios --release -f prod --build-name my_app
  ```

#### Build Project Options

- Flavor/Environment :  
  
| Flavor/Environment | Alternative | Description |
|----------|-------------|-------------|
| `-f dev` | `--flavor dev` | Build project on dev environment (Default) |
| `-f stag` | `--flavor stag` | Build project on staging environment|
| `-f prod` | `--flavor prod` | Build project on production environment |

- App Version :

| App Version | Description |
|----------|-------------|
| `--debug` | Build project on debug mode (Default) |
| `--profile` | Build project on profile mode|
| `--release` | Build project on release mode (Default) |

- Custom Target :
  
| Custom Target | Alternative | Description |
|----------|-------------|-------------|
| `-t [url_file]` | `--target [url_file]` | This command is used to build the application in a specific file, by default it will run the `lib/main.dart` file. |

- Custom Build Name :
  
| Build Name | Description |
|----------|-------------|
| `--build-name [build_number]` | This command is used to build application with a specific name.|

- Custom Build Number :
  
| Build Number | Description |
|----------|-------------|
| `--build-number [build_number]` | This command is used to build application with a specific version number.|

- No Obfuscate :

| Build Number | Description |
|----------|-------------|
| `--[no-]obfuscate` | In a release build, this flag removes identifiers and replaces them with randomized values for the purposes of source code obfuscation. This flag must always be combined with "--split-debug-info" option, the mapping between the values and the original identifiers is stored in the symbol map created in the specified directory. For an app built with this flag, the "flutter symbolize" command with the right program symbol file is required to obtain a human readable stack trace. (defaults to on)|

- Split Debug Info :
  
| Build Number | Description |
|----------|-------------|
| `--split-debug-info` | In a release build, this flag reduces application size by storing Dart program symbols in a separate file on the host rather than in the application. The value of the flag should be a directory where program symbol files can be stored for later use. These symbol files contain the information needed to symbolize Dart stack traces. For an app built with this flag, the "flutter symbolize" command with the right program symbol file is required to obtain a human readable stack trace. This flag cannot be combined with "--analyze-size". (defaults to "./.symbols/") |

### Generate Commands

#### Firebase

This command is used to generate firebase files in the `firebase/` folder to each platform folder.

```bash
gits_cli firebase
```

Ensure that the `google-services.json` file and the `GoogleService-Info.plist` file in the `firebase/` folder are aligned

#### l10n (Languages)

This command is used to generate the l10n file at the path `assets/assets/l1on/` so that we can use it in the project.

```bash
gits_cli l10n
```

Tips :

- Use this command when there is a change in the l10n file.
- Especially for vscode users, to make it easier to process l10n files, we can use the extension **[i10n arb editor](https://marketplace.visualstudio.com/items?itemName=innwin.i18n-arb-editor)**, don't forget to save and use the command above after making changes. (This tips only works for non spesific `.arb` or fingle `.arb` file)
