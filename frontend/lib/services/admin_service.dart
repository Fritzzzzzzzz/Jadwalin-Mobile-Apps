import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../config/api_config.dart';

class AdminService {
  static String get baseUrl => "${ApiConfig.baseUrl}/user/all";

  Future<Map<String, dynamic>> getAllUser() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        "totalUser": data["totalUser"],
        "users": (data["data"] as List)
            .map((e) => UserModel.fromJson(e))
            .toList(),
      };
    }

    throw Exception(data["message"]);
  }
}
