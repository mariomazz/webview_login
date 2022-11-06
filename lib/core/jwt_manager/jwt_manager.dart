import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtManager {
  String generateJWT(Duration expiresIn, Map<String, dynamic> payload) {
    final p = <String, dynamic>{
      'id': 123,
      'server': {
        'id': '3e4fc296',
        'loc': 'euw-2',
      },
    };
    p.addAll(payload);

    final jwt = JWT(
      payload,
      issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
    );
    return jwt.sign(
      SecretKey('secret passphrase'),
      expiresIn: expiresIn,
    );
  }

  bool jwtIsExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  Map<String, dynamic> decodeJWT(String token) {
    return JwtDecoder.decode(token);
  }
}
