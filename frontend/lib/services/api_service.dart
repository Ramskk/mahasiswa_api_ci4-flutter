// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mahasiswa.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2/mahasiswa_api/public';

  /// GET semua mahasiswa
  static Future<List<Mahasiswa>> getMahasiswa() async {
    final response = await http.get(Uri.parse('$baseUrl/mahasiswa'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List list = jsonData['data'];
      return list.map((e) => Mahasiswa.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data mahasiswa');
    }
  }

  /// CREATE mahasiswa
  static Future<void> createMahasiswa(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mahasiswa'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menambah mahasiswa');
    }
  }

  /// UPDATE mahasiswa
  static Future<void> updateMahasiswa(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/mahasiswa/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal update mahasiswa');
    }
  }

  /// DELETE mahasiswa
  static Future<void> deleteMahasiswa(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/mahasiswa/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal hapus mahasiswa');
    }
  }
}
