import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/matkul_model.dart';
import '../config/api_config.dart';

class MatkulService {
  static String get baseUrl => "${ApiConfig.baseUrl}/matkul";

  // GET
  Future<List<MatkulModel>> getMatkul() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse(baseUrl),

      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List matkulList = data["data"];

      return matkulList.map((e) => MatkulModel.fromJson(e)).toList();
    } else {
      throw Exception(data["message"]);
    }
  }

  // TAMBAH
  Future<void> tambahMatkul(MatkulModel matkul) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.post(
      Uri.parse(baseUrl),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "nama": matkul.nama,

        "dosen": matkul.dosen,

        "semester": matkul.semester,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 201) {
      throw Exception(data["message"]);
    }
  }

  // EDIT
  Future<void> editMatkul(MatkulModel matkul) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.patch(
      Uri.parse("$baseUrl/${matkul.id}"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "nama": matkul.nama,

        "dosen": matkul.dosen,

        "semester": matkul.semester,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(data["message"]);
    }
  }

  // HAPUS
  Future<void> hapusMatkul(int id) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.delete(
      Uri.parse("$baseUrl/$id"),

      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(data["message"]);
    }
  }
}
