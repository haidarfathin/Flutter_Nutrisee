import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrisee/core/config/config.dart';
import 'package:nutrisee/core/data/model/firestore/user_data.dart';
import 'package:nutrisee/di/injection.dart';

class Session {
  final prefs = getIt<FlutterSecureStorage>();
  read(String key) async {
    return json.decode(await prefs.read(key: key) ?? 'null');
  }

  save(String key, value) async {
    await prefs.write(key: key, value: json.encode(value));
  }

  Future<void> remove(String key) async {
    await prefs.delete(key: key);
  }

  Future<UserData?> readProfile() async {
    try {
      final raw = await prefs.read(key: Config.getUser);
      if (raw == null) return null;
      final data = json.decode(raw);
      return UserData.fromMap(data as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
}
