import 'package:gits_cli/constants.dart';
import 'package:gits_cli/dependency_manager.dart';
import 'package:gits_cli/extensions/extensions.dart';
import 'package:gits_cli/helper/helper.dart';

class FirebaseCommand extends Command {
  FirebaseCommand() {
    argParser.addOptionFlavor(defaultsTo: Constants.dev);
    argParser.addOptionGitsYaml();
  }

  @override
  String get name => 'firebase';

  @override
  String get description => 'Generate google service both android & ios.';

  @override
  String get category => Constants.generate;

  @override
  void run() {
    final argFlavor = argResults.getOptionFlavor(defaultTo: Constants.dev);
    final argGitsYaml = argResults.getOptionGitsYaml();

    YamlHelper.validateGitsYaml(argGitsYaml);

    final config = FirebaseHelper.getFirebaseConfig(argGitsYaml);
    if (config.isEmpty) {
      StatusHelper.warning(
          'Cannot setup flavor firebase, You don\'t have config "firebase" in gits.yaml');
    } else {
      final devDir = config['google_service_dev_dir'];
      final stagDir = config['google_service_stag_dir'];
      final prodDir = config['google_service_prod_dir'];
      final outputAndroid = config['output_android_dir'];
      final outputIos = config['output_ios_dir'];

      switch (argFlavor) {
        case Constants.prod:
          moveAndroidGoogleService(prodDir, outputAndroid, argFlavor);
          moveIosGoogleService(prodDir, outputIos, argFlavor);
          break;
        case Constants.stag:
          moveAndroidGoogleService(stagDir, outputAndroid, argFlavor);
          moveIosGoogleService(stagDir, outputIos, argFlavor);
          break;
        default:
          moveAndroidGoogleService(devDir, outputAndroid, argFlavor);
          moveIosGoogleService(devDir, outputIos, argFlavor);
      }
    }
  }

  void moveAndroidGoogleService(
      String googleServiceDir, String outputDir, String flavor) {
    final pathGoogleService =
        join(current, googleServiceDir, 'google-services.json');
    final pathOutputGoogleService =
        join(current, outputDir, 'google-services.json');

    if (exists(pathGoogleService)) {
      copy(
        pathGoogleService,
        pathOutputGoogleService,
        overwrite: true,
      );
      StatusHelper.success('Firebase $flavor config android');
    } else {
      StatusHelper.warning(
          'google-services.json in $pathGoogleService not found.');
    }
  }

  void moveIosGoogleService(
      String googleServiceDir, String outputDir, String flavor) {
    final pathGoogleService =
        join(current, googleServiceDir, 'GoogleService-Info.plist');

    final pathOutputGoogleService =
        join(current, outputDir, 'GoogleService-Info.plist');

    if (exists(pathGoogleService)) {
      copy(
        pathGoogleService,
        pathOutputGoogleService,
        overwrite: true,
      );
      StatusHelper.success('Firebase $flavor config ios');
    } else {
      StatusHelper.warning(
          'GoogleService-Info.plist in $pathGoogleService not found.');
    }
  }
}
