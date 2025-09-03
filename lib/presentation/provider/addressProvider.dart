import 'package:flutter/material.dart';
import '../../core/services/address_services.dart';

class AddressProvider with ChangeNotifier {
  final AddressService service = AddressService();

  List<Map<String, dynamic>> addressList = [];
  List<Map<String, dynamic>> provinces = [], cities = [], districts = [], subdistricts = [], domestics = [], zips = [];
List<Map<String, dynamic>> zipCodes = [];
Map<String, dynamic>? selectedZipCode;


  String? selectedProvince, selectedCity, selectedDistrict, selectedSubdistrict;
  Map<String, dynamic>? selectedDomestic;

  // flags loading
  bool loadingProvinces = false, loadingCities = false, loadingDistricts = false, loadingSubdistricts = false, loadingDomestics = false;

  // ---------- Helpers ----------
  String? _findName(List<Map<String, dynamic>> list, String? id) =>
      id == null ? null : list.firstWhere((e) => e['id'].toString() == id)['name'];

  void _resetSelections({bool province = false, bool city = false, bool district = false, bool subdistrict = false}) {
    if (province) { selectedProvince = null; cities.clear(); }
    if (city) { selectedCity = null; districts.clear(); }
    if (district) { selectedDistrict = null; subdistricts.clear(); }
    if (subdistrict) { selectedSubdistrict = null; domestics.clear(); }
    selectedDomestic = null;
  }

  

Map<String, dynamic> _buildAddress(String? detailAlamat, {String? selectedZipValue}) {
  return {
    "label": autoLabel,
    "province_name": _findName(provinces, selectedProvince) ?? "",
    "city_name": _findName(cities, selectedCity) ?? "",
    "district_name": _findName(districts, selectedDistrict) ?? "",
    "subdistrict_name": _findName(subdistricts, selectedSubdistrict) ?? "",
    "kode_domestik": selectedDomestic?['kode_domestik']?.toString() ?? selectedDomestic?['id']?.toString() ?? "",
    "zip_code": selectedDomestic?['zip_code']?.toString() ?? "", // <-- zip diambil dari dropdown ZIP
    "detail_alamat": detailAlamat ?? "",
  };
}

  // ---------- Load Data ----------
  Future<void> loadProvinces() async {
    loadingProvinces = true; notifyListeners();
    provinces = await service.getProvinces();
    _resetSelections(province: true, city: true, district: true, subdistrict: true);
    loadingProvinces = false; notifyListeners();
  }

  Future<void> loadCities(String provinceId) async {
    loadingCities = true; notifyListeners();
    cities = await service.getCities(provinceId);
    _resetSelections(city: true, district: true, subdistrict: true);
    loadingCities = false; notifyListeners();
  }

  Future<void> loadDistricts(String cityId) async {
    loadingDistricts = true; notifyListeners();
    districts = await service.getDistricts(cityId);
    _resetSelections(district: true, subdistrict: true);
    loadingDistricts = false; notifyListeners();
  }

Future<void> loadSubdistricts(String districtId) async {
  loadingSubdistricts = true; notifyListeners();
  subdistricts = await service.getSubdistricts(districtId);
  _resetSelections(subdistrict: true);
  loadingSubdistricts = false; notifyListeners();
}

Future<void> loadDomestics(String subdistrictId) async {
  loadingDomestics = true; notifyListeners();
  domestics = await service.getDomestics(subdistrictId);

  if (domestics.isEmpty) {
    domestics = subdistricts
        .where((s) => s['id'].toString() == subdistrictId)
        .map((s) => {
              "id": s['id'],
              "name": s['name'],
              "zip_code": s['zip'] ?? s['zip_code'] ?? "00000", // fallback default
              "kode_domestik": s['kode_domestik'] ?? s['id'],
            })
        .toList();
  }

  selectedDomestic = domestics.length == 1 ? domestics.first : null;
  loadingDomestics = false; notifyListeners();
}

  // ---------- Selectors ----------
  void selectProvince(String id) { selectedProvince = id; _resetSelections(city: true, district: true, subdistrict: true); notifyListeners(); }
  void selectCity(String id) { selectedCity = id; _resetSelections(district: true, subdistrict: true); notifyListeners(); }
  void selectDistrict(String id) { selectedDistrict = id; _resetSelections(subdistrict: true); notifyListeners(); }
  void selectSubdistrict(String id) { selectedSubdistrict = id; loadDomestics(id); notifyListeners(); }
  void selectDomestic(Map<String, dynamic> d) { selectedDomestic = d; notifyListeners(); }

  // ---------- Public ----------
  String get autoLabel {
    final prov = _findName(provinces, selectedProvince);
    final city = _findName(cities, selectedCity);
    final dist = _findName(districts, selectedDistrict);
    final subd = _findName(subdistricts, selectedSubdistrict);
    final zip = selectedDomestic?['zip_code'] ?? selectedDomestic?['zip'] ?? "";
    if ([prov, city, dist, subd].contains(null)) return "";
    return "$subd, $dist, $city, $prov${zip != "" ? " ($zip)" : ""}";
  }

  Future<bool> addAddress({String? detailAlamat}) async {
    try {
      final addr = _buildAddress(detailAlamat);
      addressList.add(addr);
      notifyListeners();
      return true;
    } catch (_) { return false; }
  }

Future<bool> saveAddressToApi({String? detailAlamat, String? zipValue}) async {
  try {
    final addr = _buildAddress(detailAlamat, selectedZipValue: zipValue);
    final success = await service.saveAddress(addr);
    if (success) {
      addressList.add(addr);
      notifyListeners();
    }
    return success;
  } catch (e) {
    print("Error saveAddressToApi: $e");
    return false;
  }
}

  Future<void> loadAddressesFromApi() async {
    addressList = await service.getAddresses();
    notifyListeners();
  }
}