import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/tugas_model.dart';

class TugasService {
  static const String baseUrl = "http://192.168.1.8:3000/api/tugas";

  Future<List<TugasModel>> getTugas() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse(baseUrl),

      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List tugasList = data["data"];

      return tugasList.map((e) => TugasModel.fromJson(e)).toList();
    } else {
      throw Exception(data["message"]);
    }
  }

  Future<void> tambahTugas(TugasModel tugas) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.post(
      Uri.parse(baseUrl),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "judul": tugas.judul,

        "deskripsi": tugas.deskripsi,

        "deadline": tugas.deadline,

        "status": tugas.status,

        "matkulId": tugas.matkulId,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 201) {
      throw Exception(data["message"]);
    }
  }

  Future<void> editTugas(TugasModel tugas) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.patch(
      Uri.parse("$baseUrl/${tugas.id}"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "judul": tugas.judul,

        "deskripsi": tugas.deskripsi,

        "deadline": tugas.deadline,

        "status": tugas.status,

        "matkulId": tugas.matkulId,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(data["message"]);
    }
  }

  Future<void> hapusTugas(int id) async {
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
