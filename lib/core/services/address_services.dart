import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../utils/shared_prefs.dart';

class AddressService {
  final String baseUrl =
      "https://sendokjeruk.github.io/wilaijah-repoeblik-indonesia/api";

  Future<List<Map<String, dynamic>>> getProvinces() async {
    try {
      final res = await http.get(Uri.parse("$baseUrl/provinces.json"));
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data
            .map<Map<String, dynamic>>(
              (e) => {"id": e["id"], "name": e["name"]},
            )
            .toList();
      }
    } catch (e) {
      // ignore
    }
    return [];
  }
  
  Future<List<Map<String, dynamic>>> getCities(String provinceId) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/regencies/$provinceId.json"),
      );
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data
            .map<Map<String, dynamic>>(
              (e) => {"id": e["id"], "name": e["name"]},
            )
            .toList();
      }
    } catch (e) {}
    return [];
  }

  Future<List<Map<String, dynamic>>> getDistricts(String cityId) async {
    try {
      final res = await http.get(Uri.parse("$baseUrl/districts/$cityId.json"));
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data
            .map<Map<String, dynamic>>(
              (e) => {"id": e["id"], "name": e["name"]},
            )
            .toList();
      }
    } catch (e) {}
    return [];
  }

  /// Ambil "kelurahan" (villages) dari districtId.
  /// Response biasanya list of villages: { id, district_id, name, zip? }
  Future<List<Map<String, dynamic>>> getSubdistricts(String districtId) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/villages/$districtId.json"),
      );
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data.map<Map<String, dynamic>>((e) {
          return {
            "id": e['id'],
            "name": e['name'],
            "zip_code":
                e['postal_code']?.toString() ??
                e['zip']?.toString() ??
                e['zip_code']?.toString() ??
                "",
            "kode_domestik":
                e['kode_domestik'] ??
                e['id'], // tetap simpan kode domestik juga
          };
        }).toList();
      }
    } catch (e) {
      print("Error getSubdistricts: $e");
    }
    return [];
  }

  /// Ambil "domestics" — beberapa repo/endpoint menyimpan kombinasi kode/domestik/zip
  /// dalam file villages/{something}.json. Kita coba fetch that endpoint.
  Future<List<Map<String, dynamic>>> searchDomestics(String searchQuery) async {
  try {
    final res = await http.get(
      Uri.parse("${Constants.baseUrl}/rajaongkir/domestic?search=$searchQuery"),
      headers: {'Accept': 'application/json'},
    );
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final List data = body['data'] ?? [];
      return data.map<Map<String, dynamic>>((e) {
        return {
          "id": e['id'],
          "name": e['name'],
          "kode_domestik": e['id'],
          "zip_code": e['zip_code']?.toString() ?? "",
        };
      }).toList();
    }
  } catch (e) {
    print("Error searchDomestics: $e");
  }
  return [];
}

  Future<http.Response> saveAddress(Map<String, dynamic> addressData) async {
  final token = await SharedPrefs.getToken();
  if (token == null) {
    throw Exception("Token tidak tersedia, user belum login");
  }

  final response = await http.post(
    Uri.parse("${Constants.baseUrl}/alamat"),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(addressData),
  );

  // Debug log
  print("SAVE ADDRESS STATUS: ${response.statusCode}");
  print("SAVE ADDRESS BODY: ${response.body}");

  return response; // <--- ganti, bukan bool lagi
}

Future<List<Map<String, dynamic>>> getAddresses() async {
  final token = await SharedPrefs.getToken();
  if (token == null) return [];

  final response = await http.get(
    Uri.parse("${Constants.baseUrl}/alamat"),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  print("DEBUG STATUS: ${response.statusCode}");
  print("DEBUG BODY: ${response.body}");

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    if (data is Map && data.containsKey('data')) {
      final innerData = data['data'];
      if (innerData is Map && innerData.containsKey('data')) {
        // ✅ kasus pagination Laravel (pakai resource collection)
        return List<Map<String, dynamic>>.from(innerData['data']);
      } else if (innerData is List) {
        // ✅ kasus data langsung array
        return List<Map<String, dynamic>>.from(innerData);
      }
    } else if (data is List) {
      return List<Map<String, dynamic>>.from(data);
    }
  }
  return [];
}

Future<bool> deleteAddress(int id) async {
  final token = await SharedPrefs.getToken();
  if (token == null) return false;

  final res = await http.delete(
    Uri.parse("${Constants.baseUrl}/alamat/$id"),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  print("DELETE STATUS: ${res.statusCode}");
  print("DELETE BODY: ${res.body}");

  return res.statusCode == 200 || res.statusCode == 204;
}

Future<List<Map<String, dynamic>>> getOngkir({
  required String origin,
  required String destination,
  required int weight,
  required String courier,
}) async {
  final token = await SharedPrefs.getToken();
  if (token == null) return [];

  try {
    final res = await http.post(
      Uri.parse("${Constants.baseUrl}/rajaongkir/cost"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "courier": courier,
        "price": "lowest", // sama kayak Vue
      }),
    );

    print("ONGKIR STATUS: ${res.statusCode}");
    print("ONGKIR BODY: ${res.body}");

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      final List data = body['data'] ?? [];
      return List<Map<String, dynamic>>.from(data);
    }
  } catch (e) {
    print("Error getOngkir: $e");
  }
  return [];
}
}
