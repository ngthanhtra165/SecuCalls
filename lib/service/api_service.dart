import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:secucalls/service/hive.dart';

class APIService {
  static const String baseURL = "http://157.119.251.238";
  static final shared = APIService();

  Future<Map<String, dynamic>> loginUser(String phone, String password) async {
    const String apiUrl =
        '$baseURL/user/login'; // Replace '/login' with your API endpoint

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'phone': phone,
          'password': password,
        },
      ),
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      throw responseData["msg"];
    }
  }

  Future<Map<String, dynamic>> registerUser(String firstName, String lastName,
      String email, String phone, String password) async {
    const String apiUrl =
        '$baseURL/user/register'; // Replace '/login' with your API endpoint

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          "phone": phone,
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password,
        },
      ),
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    if (responseData['status'] == 'success') {
      // If the server returns a 200 OK response, parse the JSON response
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      throw responseData["msg"];
    }
  }

  Future<Map<String, dynamic>> forgetPassword(String email) async {
    const String apiUrl =
        '$baseURL/user/forgot-password'; // Replace '/login' with your API endpoint

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'email': email,
      },
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      throw responseData["msg"];
    }
  }

  Future<Map<String, dynamic>> otpValidation(String otp) async {
    const String apiUrl =
        '$baseURL/user/verify-otp'; // Replace '/login' with your API endpoint

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: {
      'otp': otp,
    });
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      throw responseData["msg"];
    }
  }

  Future<Map<String, dynamic>> setPassword(
      String? otp_token, String password, String reEnterPassword) async {
    const String apiUrl =
        '$baseURL/user/set-password'; // Replace '/login' with your API endpoint

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: {
      "otp_token": otp_token ?? "",
      "new_password": password,
      "re_enter_password": reEnterPassword
    });
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      throw responseData["msg"];
    }
  }

  Future<Map<String, dynamic>> logoutUser() async {
    const String apiUrl =
        '$baseURL/user/logout'; // Replace '/login' with your API endpoint

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final access_token = await getString("token", "access_token");
    print("access token is $access_token");
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Authorization': 'Bearer $access_token',
      },
    );
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      throw responseData["msg"];
    }
  }
}
