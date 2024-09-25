import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<String> fetchCountryCode() async {
    await _remoteConfig.fetchAndActivate();
    return _remoteConfig.getString('country_code');
  }
}
