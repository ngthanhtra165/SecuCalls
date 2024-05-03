import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

String extendTokenExpiry(String token, int minutes) {
  Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
  if (decodedToken.containsKey('exp')) {
    // Extend expiration time by 30 minutes
    DateTime expiryTime = DateTime.fromMillisecondsSinceEpoch(
        (decodedToken['exp'] * 1000) + (minutes * 60 * 1000));
    decodedToken['exp'] = expiryTime.millisecondsSinceEpoch ~/ 1000;

    // Encode the payload to create a new token
    String newToken = base64Url.encode(utf8.encode(json.encode(decodedToken)));
    print('new token is $newToken');
    return newToken;
  }
  return token; // Return the original token if expiration time is not present
}

bool isTokenExpired(String token) {
  Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
  if (decodedToken.containsKey('exp')) {
    int expiryTime = decodedToken['exp'];
    int nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return nowInSeconds > expiryTime;
  }
  return true; // Return true if expiry time is not set in the token
}
