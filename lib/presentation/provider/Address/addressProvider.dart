import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/address_services.dart';
import '../../../core/utils/shared_prefs.dart';
import '../../../core/utils/constants.dart';

class AddressProvider with ChangeNotifier {
  final AddressService service = AddressService();

  List<Map<String, dynamic>> provinces = [],
      cities = [],
      districts = [],
      subdistricts = [],
      searchResults = [];

  List<Map<String, dynamic>> addressList = [];

  // === data pilihan alamat
  String? selectedProvince, selectedCity, selectedDistrict, selectedSubdistrict;
  Map<String, dynamic>? selectedDomestic;
  Map<String, dynamic>? selectedAddress; // <--- alamat yang dipilih user

  // === state loading
  bool loadingProvinces = false,
      loadingCities = false,
      loadingDistricts = false,
      loadingSubdistricts = false;

  bool showKodeDomestik = false;

  // === daftar kurir (ambil dari RajaOngkir)
  final List<Map<String, String>> kurirList = [
    {'kode': 'jne', 'nama': 'Jalur Nugraha Ekakurir (JNE)'},
    {'kode': 'pos', 'nama': 'POS Indonesia (POS)'},
    {'kode': 'sicepat', 'nama': 'SiCepat Express (SICEPAT)'},
    {'kode': 'lion', 'nama': 'Lion Parcel (LION)'},
    {'kode': 'ninja', 'nama': 'Ninja Xpress (NINJA)'},
    {'kode': 'jnt', 'nama': 'J&T Express (J&T)'},
    {'kode': 'anteraja', 'nama': 'AnterAja (ANTERAJA)'},
  ];

  // === hasil ongkir
  int ongkir = 0;
  String? selectedService;
  String? selectedCourier;

  // --- helpers
  String? _findName(List<Map<String, dynamic>> list, String? id) =>
      id == null ? null : list.firstWhere((e) => e['id'].toString() == id, orElse: () => {})['name'];

  void _resetSelections({
    bool province = false,
    bool city = false,
    bool district = false,
    bool subdistrict = false,
  }) {
    if (province) {
      selectedProvince = null;
      cities.clear();
    }
    if (city) {
      selectedCity = null;
      districts.clear();
    }
    if (district) {
      selectedDistrict = null;
      subdistricts.clear();
    }
    if (subdistrict) {
      selectedSubdistrict = null;
    }
    selectedDomestic = null;
    searchResults.clear();
    showKodeDomestik = false;
  }

  Map<String, dynamic> _buildAddress(String? detailAlamat) {
    return {
      "label": autoLabel,
      "province_name": _findName(provinces, selectedProvince) ?? "",
      "city_name": _findName(cities, selectedCity) ?? "",
      "district_name": _findName(districts, selectedDistrict) ?? "",
      "subdistrict_name": _findName(subdistricts, selectedSubdistrict) ?? "",
      "kode_domestik": selectedDomestic?['kode_domestik'] ?? "",
      "zip_code": selectedDomestic?['zip_code'] ?? "",
      "detail_alamat": detailAlamat ?? "",
    };
  }

  // --- load data
  Future<void> loadProvinces() async {
    loadingProvinces = true;
    notifyListeners();
    provinces = await service.getProvinces();
    _resetSelections(province: true, city: true, district: true, subdistrict: true);
    loadingProvinces = false;
    notifyListeners();
  }

  Future<void> loadCities(String provinceId) async {
    loadingCities = true;
    notifyListeners();
    cities = await service.getCities(provinceId);
    _resetSelections(city: true, district: true, subdistrict: true);
    loadingCities = false;
    notifyListeners();
  }

  Future<void> loadDistricts(String cityId) async {
    loadingDistricts = true;
    notifyListeners();
    districts = await service.getDistricts(cityId);
    _resetSelections(district: true, subdistrict: true);
    loadingDistricts = false;
    notifyListeners();
  }

  Future<void> loadSubdistricts(String districtId) async {
    loadingSubdistricts = true;
    notifyListeners();
    subdistricts = await service.getSubdistricts(districtId);
    _resetSelections(subdistrict: true);
    loadingSubdistricts = false;
    notifyListeners();
  }

  // --- cari kode domestik
  Future<void> cariKodeDomestik() async {
    if (autoLabel.isEmpty) {
      selectedDomestic = null;
      searchResults.clear();
      showKodeDomestik = false;
      notifyListeners();
      return;
    }
    final results = await service.searchDomestics(autoLabel);
    if (results.isEmpty) {
      selectedDomestic = null;
      searchResults.clear();
      showKodeDomestik = false;
    } else {
      selectedDomestic = results.first;
      searchResults = results.length > 1 ? results : [];
      showKodeDomestik = true;
    }
    notifyListeners();
  }

  // --- selectors
  void selectProvince(String id) {
    selectedProvince = id;
    _resetSelections(city: true, district: true, subdistrict: true);
    notifyListeners();
  }

  void selectCity(String id) {
    selectedCity = id;
    _resetSelections(district: true, subdistrict: true);
    notifyListeners();
  }

  void selectDistrict(String id) {
    selectedDistrict = id;
    _resetSelections(subdistrict: true);
    notifyListeners();
  }

  void selectSubdistrict(String id) {
    selectedSubdistrict = id;
    notifyListeners();
  }

  void selectDomestic(Map<String, dynamic> d) {
    selectedDomestic = d;
    notifyListeners();
  }

  // simpan alamat yang dipilih user
  void setSelectedAddress(Map<String, dynamic> alamat) {
    selectedAddress = alamat;
    notifyListeners();
  }

  // --- label otomatis
  String get autoLabel {
    final prov = _findName(provinces, selectedProvince);
    final city = _findName(cities, selectedCity);
    final dist = _findName(districts, selectedDistrict);
    final subd = _findName(subdistricts, selectedSubdistrict);
    final zip = selectedDomestic?['zip_code'] ?? "";
    if ([prov, city, dist, subd].contains(null)) return "";
    return "$subd, $dist, $city, $prov${zip != "" ? " ($zip)" : ""}";
  }

  // --- save address
  Future<bool> saveAddressToApi({String? detailAlamat}) async {
    try {
      final addr = _buildAddress(detailAlamat);
      final http.Response response = await service.saveAddress(addr);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          addressList.add(Map<String, dynamic>.from(data['data']));
          notifyListeners();
        }
        return true;
      } else {
        debugPrint("SAVE ADDRESS STATUS: ${response.statusCode}");
        debugPrint("SAVE ADDRESS BODY: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Error saveAddressToApi: $e");
      return false;
    }
  }

  // --- load address list
  Future<void> loadAddressesFromApi() async {
    try {
      addressList = await service.getAddresses();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loadAddressesFromApi: $e");
    }
  }

  Future<bool> deleteAddress(int id) async {
    try {
      final success = await service.deleteAddress(id);
      if (success) {
        addressList.removeWhere((a) => a['id'] == id);
        notifyListeners();
      }
      return success;
    } catch (e) {
      debugPrint("Error deleteAddress: $e");
      return false;
    }
  }

  // --- hitung ongkir
  Future<void> getOngkirByAddress({
    required String origin,
    required String destination,
    required int weight,
    required String courier,
    required String kodeTransaksi,
  }) async {
    try {
      final results = await service.getOngkir(
        origin: origin,
        destination: destination,
        weight: weight,
        courier: courier,
      );

      if (results.isEmpty) {
        ongkir = 0;
        selectedService = null;
        notifyListeners();
        return;
      }

      // cari ongkir terendah
      Map<String, dynamic> lowest = results[0];
      for (var s in results) {
        if ((s['cost'] ?? 9999999) < (lowest['cost'] ?? 9999999)) {
          lowest = s;
        }
      }

      ongkir = lowest['cost'] ?? 0;
      selectedService = lowest['service'];

      // update transaksi di backend
      await http.put(
        Uri.parse("${Constants.baseUrl}/transaction/$kodeTransaksi"),
        headers: {
          'Authorization': 'Bearer ${await SharedPrefs.getToken()}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"total_ongkir": ongkir}),
      );

      notifyListeners();
    } catch (e) {
      print("Error getOngkirByAddress: $e");
      ongkir = 0;
      selectedService = null;
      notifyListeners();
    }
  }
}