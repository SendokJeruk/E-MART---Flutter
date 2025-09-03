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
  Future<List<Map<String, dynamic>>> getDomestics(String subdistrictId) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/rajaongkir/domestic?search=$subdistrictId"),
      );
      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body)['data'] ?? [];
        return data.map<Map<String, dynamic>>((e) {
          return {
            "id": e['id'],
            "name": e['name'],
            "kode_domestik": e['id'], // kode unik domestik
            "zip_code":
                e['zip_code']?.toString() ??
                "", // <-- langsung ambil zip_code di sini
          };
        }).toList();
      }
    } catch (e) {
      print("Error getDomestics: $e");
    }
    return [];
  }

  Future<bool> saveAddress(Map<String, dynamic> addressData) async {
    final token = await SharedPrefs.getToken();
    if (token == null) return false;

    final response = await http.post(
      Uri.parse("${Constants.baseUrl}/addresses"),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(addressData),
    );

    print("SAVE ADDRESS STATUS: ${response.statusCode}");
    print("SAVE ADDRESS BODY: ${response.body}");

    return response.statusCode == 201;
  }

  Future<List<Map<String, dynamic>>> getAddresses() async {
    final token = await SharedPrefs.getToken();
    if (token == null) return [];

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}/addresses"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['data']);
    }
    return [];
  }
}
