import 'package:encrypt/encrypt.dart' as encrypt;

const encryptionKey =
    '2Qw5T8w1Z4b7E0d3'; // Replace with your own encryption key

String encrypted(String data) {
  final key = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromUtf8('16byteslengthiv.');

  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  try {
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  } catch (e) {
  //  print('Encryption error: $e');
    return '';
  }
}

String decrypted(String encryptedData) {
  final key = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromUtf8('16byteslengthiv.');

  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  try {
    final encrypted = encrypt.Encrypted.fromBase64(encryptedData);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  } catch (e) {
   // print('Decryption error: $e');
    return '';
  }
}
