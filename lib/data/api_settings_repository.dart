import 'dart:convert';

import 'package:academic_teacher/data/model/api_settings_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiSettingsRepository {
  final String _baseUrlApi = "https://api-main-drk8yx.laravel.cloud/gateway";

  Future<User> getAuthenticatedUser(String token) async {
    final response = await http.get(
                    Uri.parse("$_baseUrlApi/me"),
                    headers: {
                      "Authorization": "Bearer $token",
                      "Accept": "application/json"
                      }).timeout(const Duration(seconds: 30));
    debugPrint('$response');

    if(response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    }else {
      throw Exception("Failed to fetch authenticated user: ${response.statusCode}");
    }

  }
}