import 'dart:convert';

import 'package:crypto/crypto.dart' as _Crypto;

enum CryptoAlg { md5, sha1, sha256, sha512 }

class Crypto {
  /// Hash Method
  static hash(String arg, CryptoAlg alg) {
    /// If MD5
    if (CryptoAlg.md5 == alg) {
      final bytes = utf8.encode(arg);

      final digest = _Crypto.md5.convert(bytes);

      final hash = digest.toString();
      return hash;
    }

    if (CryptoAlg.sha256 == alg) {}

    if (CryptoAlg.sha512 == alg) {}
  }
}
