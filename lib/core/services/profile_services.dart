import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../data/models/User.dart';
import '../utils/constants.dart';
import '../utils/shared_prefs.dart';

class ProfileService {
  /// Helper untuk fix URL localhost biar jalan di emulator
  String fixLocalhostUrl(String url) {
    if (url.contains('127.0.0.1')) {
      return url.replaceFirst('127.0.0.1', '10.0.2.2');
    } else if (url.contains('localhost')) {
      return url.replaceFirst('localhost', '10.0.2.2');
    }
    return url;
  }

  ImageProvider getProfileImage({
    File? localFile,
    String? fotoProfil,
  }) {
    if (localFile != null) {
      return FileImage(localFile);
    }

    if (fotoProfil != null && fotoProfil.isNotEmpty) {
      String url = fotoProfil;

      if (!url.startsWith('http')) {
        // kalau backend cuma kirim path (misal "upload/pfp/xxx.png")
        url = "${Constants.baseUrl}/$url";
      }

      // fix URL supaya bisa diakses dari emulator
      url = fixLocalhostUrl(url);

      return NetworkImage(url);
    }

    return const AssetImage('assets/images/default.png');
  }
  
  /// Ambil profil user
  Future<UserModel?> getProfile() async {
    final token = await SharedPrefs.getToken();

    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserModel.fromJson(data['data']);
      } else {
        print('Gagal mengambil profil. Status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getProfile: $e');
      return null;
    }
  }

  /// Update profil user
  Future<UserModel?> updateProfile({
    String? name,
    String? email,
    String? noTelp,
    String? password,
    int? roleId,
    File? fotoProfil,
  }) async {
    final token = await SharedPrefs.getToken();

    try {
      final uri = Uri.parse('${Constants.baseUrl}/profile');
      final request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.fields['_method'] = 'PUT'; // Laravel method spoofing

      if (name != null) request.fields['name'] = name;
      if (email != null) request.fields['email'] = email;
      if (noTelp != null) request.fields['no_telp'] = noTelp;
      if (password != null) request.fields['password'] = password;
      if (roleId != null) request.fields['role_id'] = roleId.toString();

      if (fotoProfil != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'foto_profil', // Pastikan sama persis dengan Laravel
          fotoProfil.path,
          filename: fotoProfil.path.split('/').last,
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return UserModel.fromJson(data['data']);
      } else {
        print('Gagal update profil: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error updateProfile: $e');
      return null;
    }
  }
}
