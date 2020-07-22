import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class StorageApiProvider {
  ///singleton class
  static final StorageApiProvider _storageApiProvider =
      new StorageApiProvider._internal();

  factory StorageApiProvider() {
    return _storageApiProvider;
  }

  StorageApiProvider._internal();

  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  static String _token;

  Future<String> getToken() async {
    if (_token == null) {
      _token = await _flutterSecureStorage.read(key: "token");
    }
    return _token;
  }

  set token(String value) {
    _token = value;
    _flutterSecureStorage.write(key: "token", value: value);
  }

  static String _user;

  Future<String> getUser() async {
    if (_user == null) {
      await _flutterSecureStorage.read(key: "user");
    }
    return _user;
  }

  set user(String value) {
    _user = value;
    _flutterSecureStorage.write(key: "user", value: value);
  }

  Future<String> readValue({@required String key}) async =>
      await _flutterSecureStorage.read(key: key);

  Future<void> writeValue({
    @required String key,
    @required String value,
  }) async =>
      await _flutterSecureStorage.write(key: key, value: value);

  Future<void> deleteValue({@required String key}) async =>
      await _flutterSecureStorage.delete(key: key);

  Future<void> deleteAllValue() async =>
      await _flutterSecureStorage.deleteAll();
}

final storageApiProvider = StorageApiProvider();
