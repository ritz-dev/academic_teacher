import 'dart:convert';
import 'dart:async';
import 'package:academic_teacher/storage/web_auth_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiProvider {

  static const String _baseUrlApi = "https://api-main-drk8yx.laravel.cloud/gateway";

  final WebAuthStorage storage = WebAuthStorage();

  Future<String> login(String email,String password) async{
    // if(email == "superadmin@example.com" && password == "superpassword")
    // {
      
    // }
    // saveToken('token');
    // return 'token';
      try{
        debugPrint("This is login");
        final response = await http.post(
          Uri.parse("$_baseUrlApi/login"),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode({"email":email,"password":password})
        ).timeout(const Duration(seconds: 30));
        debugPrint("Response Body ${response.body}");

        final Map<String, dynamic> data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          await storage.saveToken(data['token']);
          return data['token'];
        } else {
          throw Exception(data['message']);
        }
      }on http.ClientException {
        throw Exception("Failed to connect to the server.");
      } on TimeoutException {
        throw Exception("Connection timeout. Please try again.");
      }catch(e){
        debugPrint("Error is $e");
        throw Exception("An unexpected error occurred: ");
      }
  }

  Future<void> saveAuthToken(String token) async => storage.saveToken(token);
  Future<String?> getAuthToken() async => storage.getToken();
  Future<void> deleteAuthToken() async => storage.deleteToken();
  Future<bool> isAuthenticated() async => (await getAuthToken()) != null;
}
