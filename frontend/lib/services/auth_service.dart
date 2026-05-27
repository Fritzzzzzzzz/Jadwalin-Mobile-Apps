import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class AuthService {
  static const String baseUrl = "http://192.168.1.3:3000/api";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);

    if (data["success"]) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("token", data["data"]["token"]);
    }

    return data;
  }

  static Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse("$baseUrl/user/profile"),

      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception("Gagal ambil profile");
  }

  static Future<void> updateProfile(String nama, String email) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.put(
      Uri.parse("$baseUrl/user/profile"),

      headers: {
        "Authorization": "Bearer $token",

        "Content-Type": "application/json",
      },

      body: jsonEncode({"nama": nama, "email": email}),
    );

    if (response.statusCode != 200) {
      throw Exception("Gagal update profile");
    }
  }

  static Future<void> uploadFotoProfile(File image) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    var request = http.MultipartRequest(
      "PUT",

      Uri.parse("$baseUrl/user/foto-profil"),
    );

    request.headers["Authorization"] = "Bearer $token";

    request.files.add(
      await http.MultipartFile.fromPath(
        "fotoProfil",

        image.path,

        contentType: MediaType("image", "jpeg"),
      ),
    );

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception("Upload gagal");
    }
  }

  static Future<Map<String, dynamic>> changePassword(
    String oldPassword,

    String newPassword,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.patch(
      Uri.parse("$baseUrl/user/change-password"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "oldPassword": oldPassword,

        "newPassword": newPassword,
      }),
    );

    final data = jsonDecode(response.body);

    return data;
  }

  Future<Map<String, dynamic>> register(
    String nama,

    String email,

    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"nama": nama, "email": email, "password": password}),
    );

    final data = jsonDecode(response.body);

    return data;
  }
}
