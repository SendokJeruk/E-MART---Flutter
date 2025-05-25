import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RajaOngkirService {
  final String apiKey = 'gBXP8M1xc490bbd12374960aDCYAYrc8';
  final String baseUrl = 'https://rajaongkir.komerce.id/api/v1/destination/domestic-destination';

  Future<List<dynamic>> getDestinations({String search = 'bandung'}) async {
    final url = Uri.parse('$baseUrl?search=$search');

    final response = await http.get(
      url,
      headers: {
        'key': apiKey,
        'Accept': 'application/json',
      },
    );

    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['data'] ?? [];
    } else {
      throw Exception("Failed to load destinations: ${response.body}");
    }
  }
}