import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  String? _autoAddress; // alamat dari GPS
  String _manualAddress = ''; // alamat dari dropdown manual

  Position? get currentPosition => _currentPosition;

  // Getter untuk alamat yang akan ditampilkan
  String get address => _manualAddress.isNotEmpty ? _manualAddress : (_autoAddress ?? 'Alamat tidak tersedia');

  /// Ambil lokasi otomatis via GPS
  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("Service tidak aktif");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) {
        print("Permission denied forever");
        return;
      }

      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await _getAddressFromLatLng();
      notifyListeners();
    } catch (e) {
      print("Error saat ambil lokasi: $e");
    }
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      if (_currentPosition != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        );

        if (placemarks.isNotEmpty) {
          final place = placemarks[0];
          _autoAddress =
              '${place.street}, ${place.subLocality}, ${place.administrativeArea}, ${place.postalCode}';
          print("Alamat ditemukan: $_autoAddress");
        } else {
          print("Tidak ditemukan placemark");
        }
      }
    } catch (e) {
      print("Error saat ambil alamat: $e");
    }
  }

  /// Setter untuk alamat manual dari dropdown
  void setManualAddress(String manualAddress) {
    _manualAddress = manualAddress;
    notifyListeners();
  }
}