import 'package:firebase_remote_config/firebase_remote_config.dart';

const _remoteConfig = 'url';

class RemoteConfigProvider {
  static final instance = RemoteConfigProvider._();

  RemoteConfigProvider._() {
    remoteConfig = FirebaseRemoteConfig.instance;
  }

  late final FirebaseRemoteConfig remoteConfig;

  Future<String> getValue() async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 1),
      ));
      await remoteConfig.fetchAndActivate();
      final value = remoteConfig.getValue(_remoteConfig);
      final str = value.asString();
      // return 'https://pub.dev/packages/device_info_plus/example';
      return str;
    } catch (e) {
      return '';
    }
  }
}
