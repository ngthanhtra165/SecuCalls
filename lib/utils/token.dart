import 'package:jwt_decode/jwt_decode.dart';
import 'package:secucalls/service/hive.dart';
import '../service/api_service.dart';

bool isTokenExpired(String token) {
  Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
  if (decodedToken.containsKey('exp')) {
    int expiryTime = decodedToken['exp'];
    int nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return nowInSeconds > expiryTime;
  }
  return true; // Return true if expiry time is not set in the to
}

Future<String> getAccessToken() async {
  final accessToken = await getString("token", "access_token") ?? "";
  if (isTokenExpired(accessToken)) {
    final response = await APIService.shared.refreshAccessToken();
    print("new token is ${response['access_token']}");
    return response['access_token'];
  }

  return accessToken;
}
