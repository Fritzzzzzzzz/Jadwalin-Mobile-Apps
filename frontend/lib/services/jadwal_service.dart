import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/jadwal_model.dart';

class JadwalService {
  static const String baseUrl = "http://192.168.1.3:3000/api/jadwal";

  Future<List<JadwalModel>> getJadwal() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.get(
      Uri.parse(baseUrl),

      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List jadwalList = data["data"];

      return jadwalList.map((e) => JadwalModel.fromJson(e)).toList();
    } else {
      throw Exception(data["message"]);
    }
  }

  Future<void> tambahJadwal(JadwalModel jadwal) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.post(
      Uri.parse(baseUrl),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "namaMatkul": jadwal.namaMatkul,

        "hari": jadwal.hari,

        "jamMulai": jadwal.jamMulai,

        "jamSelesai": jadwal.jamSelesai,

        "ruangan": jadwal.ruangan,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 201) {
      throw Exception(data["message"]);
    }
  }

  Future<void> hapusJadwal(int id) async {
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

  Future<void> editJadwal(JadwalModel jadwal) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");

    final response = await http.patch(
      Uri.parse("$baseUrl/${jadwal.id}"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "namaMatkul": jadwal.namaMatkul,

        "hari": jadwal.hari,

        "jamMulai": jadwal.jamMulai,

        "jamSelesai": jadwal.jamSelesai,

        "ruangan": jadwal.ruangan,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(data["message"]);
    }
  }
}
