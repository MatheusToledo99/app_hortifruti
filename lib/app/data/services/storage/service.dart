import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  final _storage = GetStorage();
  final _token = RxnString();
  String? get token => _token.value;

  @override
  onInit() {
    _token.value = _storage.read(StorageKey.token.toString());
    _storage.listenKey(StorageKey.token.toString(), (value) {
      _token.value = value;
    });

    super.onInit();
  }

  Future<void> saveToken(String token) async {
    await _storage.write(StorageKey.token.toString(), token);
  }
}

enum StorageKey { token }
