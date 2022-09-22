import 'dart:developer';

import 'package:localstorage/localstorage.dart';

class DayDietLocalProvider {
  static final instance = DayDietLocalProvider._();
  DayDietLocalProvider._() {
    storage = LocalStorage('day_diet');
  }

  late final LocalStorage storage;

  Future<void> setTOLocalStorage(String key, Map<String, dynamic> map) async {
    await storage.setItem(key, map);
    log('Set Data: $map');
  }

  Future<Map<String, dynamic>> getFromLocalStorage(String key) async {
    final ready = await storage.ready;

    if (!ready) return {};

    final items = await storage.getItem(key);

    if (items == null) return {};

    log('Get Data: $items');
    return items;
  }
}
