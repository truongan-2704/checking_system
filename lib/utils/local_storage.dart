import 'package:hive/hive.dart';

final LocalStorage = HiveLocalStorage();

class HiveLocalStorage {

  // 👉 Không tạo box sớm
  Box get box => Hive.box('AppLocalStorage');

  void open() {
    Hive.openBox('AppLocalStorage');
  }

  String getString(String key, {String? defaultValue}) {
    try {
      return box.get(key, defaultValue: defaultValue ?? '');
    } catch (_) {
      return '';
    }
  }

  int getInt(String key, {int? defaultValue}) {
    try {
      return box.get(key, defaultValue: defaultValue ?? -1);
    } catch (_) {
      return -1;
    }
  }

  bool getBool(String key, {bool? defaultValue}) {
    try {
      return box.get(key, defaultValue: defaultValue ?? false);
    } catch (_) {
      return false;
    }
  }

  dynamic getObject(String key) {
    try {
      return box.get(key);
    } catch (_) {
      return null;
    }
  }

  void save(String key, dynamic value) {
    box.put(key, value);
  }

  void clearUserInfo() {
    save(LocalStorageKey.name, '');
    save(LocalStorageKey.access_token, '');
    save(LocalStorageKey.refresh_token, '');
    save(LocalStorageKey.phoneNumber, '');
    save(LocalStorageKey.position, '');
    save(LocalStorageKey.departmentName, '');
    save(LocalStorageKey.departmentCode, '');
    save(LocalStorageKey.typeUser, '');
    save(LocalStorageKey.isLogin, false);
  }

  void saveUserInfo({
    String? name,
    String? accessToken,
    String? refreshToken,
    String? phoneNumber,
    String? position,
    String? departmentName,
    String? departmentCode,
    String? typeUser,
    String? tokenType,
  }) {
    save(LocalStorageKey.name, name ?? '');
    save(LocalStorageKey.access_token, accessToken ?? '');
    save(LocalStorageKey.refresh_token, refreshToken ?? '');
    save(LocalStorageKey.phoneNumber, phoneNumber ?? '');
    save(LocalStorageKey.position, position ?? '');
    save(LocalStorageKey.departmentName, departmentName ?? '');
    save(LocalStorageKey.departmentCode, departmentCode ?? '');
    save(LocalStorageKey.typeUser, typeUser ?? '');
    save(LocalStorageKey.tokenType, tokenType ?? '');
    save(LocalStorageKey.isLogin, true);
  }
}

class LocalStorageKey {
  static const String name = 'name';
  static const String access_token = 'access_token';
  static const String refresh_token = 'refresh_token';
  static const String phoneNumber = 'phoneNumber';
  static const String position = 'position';
  static const String departmentName = 'departmentName';
  static const String departmentCode = 'departmentCode';
  static const String typeUser = 'typeUser';
  static const String tokenType = 'tokenType';
  static const String isLogin = 'isLogin';
}
