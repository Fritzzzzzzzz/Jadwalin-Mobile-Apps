import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AdminService {
  static const String baseUrl = "http://192.168.1.8:3000/api/user/all";

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
