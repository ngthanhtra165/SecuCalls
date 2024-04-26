import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class APIService {
  static const String baseURL =
      "https://fa64a424-8f27-45e3-aefd-b026498a4ed8.mock.pstmn.io";
  static final shared = APIService();

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    const String apiUrl =
        '$baseURL/user/login'; // Replace '/login' with your API endpoint

    // Map<String, String> headers = {
    //   "Content-Type": "application/json",
    // };
    final response = await http.post(Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': "0969263497",
          'password': "wj7M\$uKih\$",
        }));

    if (response.statusCode == 201) {
      // If the server returns a 200 OK response, parse the JSON response
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw responseData["msg"];
    }
  }

  Future<Map<String, dynamic>> forgetPassword(String email) async {
    const String apiUrl =
        '$baseURL/user/forgot-password'; // Replace '/login' with your API endpoint

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: {
      'email': email,
    });

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw responseData["msg"];
    }
  }

  Future<Map<String, dynamic>> otpValidation(String email) async {
    const String apiUrl =
        '$baseURL/user/verify-otp'; // Replace '/login' with your API endpoint

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: {
      'email': email,
    });

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw responseData["msg"];
    }
  }
}
