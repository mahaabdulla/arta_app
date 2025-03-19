import 'package:encrypt/encrypt.dart' as encrypt;

import '../../constants/global_constants.dart';
import 'local_storage.dart';

class SecureStorage {
  String getKeyEncryption() {
    String key = LocalStorage.getStringFromDisk(key: EncryptedKey);
    return key;
  }

  String encryptPassword(String password, String base64Key) {
    final key = encrypt.Key.fromBase64(base64Key);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypted = encrypter.encrypt(password, iv: iv);
    return '${encrypted.base64}:${iv.base64}';
  }

  String decryptPassword(String encryptedPasswordWithIv, String base64Key) {
    final key = encrypt.Key.fromBase64(base64Key);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final parts = encryptedPasswordWithIv.split(':');
    if (parts.length != 2) {
      throw ArgumentError('Invalid encrypted password format');
    }
    final encryptedPassword = parts[0];
    final iv = encrypt.IV.fromBase64(parts[1]);
    return encrypter.decrypt64(encryptedPassword, iv: iv);
  }

  Future<void> saveEncryptedPassword(String encryptedPasswordWithIv) async {
    await LocalStorage.saveStringToDisk(
      key: LOGINPASSWORD,
      value: encryptedPasswordWithIv,
    );
  }

  Future<String?> getEncryptedPassword() async {
    return LocalStorage.getStringFromDisk(key: LOGINPASSWORD);
  }
}
