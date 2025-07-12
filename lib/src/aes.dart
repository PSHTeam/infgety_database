import 'package:encrypt/encrypt.dart' as enc;

class AES {
  final String keyHex;
  final String ivHex;
  final String? encoding;

  AES({required this.keyHex, required this.ivHex, this.encoding});

  String encrypt(String plainText) {
    final key = enc.Key.fromBase16(keyHex);
    final iv = enc.IV.fromBase16(ivHex);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    switch (encoding) {
      case 'base64':
        return encrypted.base64;
      case 'base16':
        return encrypted.base16;
      default:
        return encrypted.base64;
    }
  }

  String decrypt(String cipherText) {
    final key = enc.Key.fromBase16(keyHex);
    final iv = enc.IV.fromBase16(ivHex);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));

    late final enc.Encrypted encrypted;

    switch (encoding) {
      case 'base64':
        encrypted = enc.Encrypted.fromBase64(cipherText);
        break;
      case 'base16':
        encrypted = enc.Encrypted.fromBase16(cipherText);
        break;
      case 'utf8':
        encrypted = enc.Encrypted.fromUtf8(cipherText);
        break;
      default:
        encrypted = enc.Encrypted.fromBase64(cipherText);
    }

    return encrypter.decrypt(encrypted, iv: iv);
  }
}
