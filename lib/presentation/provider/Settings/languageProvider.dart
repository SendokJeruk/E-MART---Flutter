import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _selectedLang = "Indonesia";

  String get selectedLang => _selectedLang;

  void setLanguage(String lang) {
    _selectedLang = lang;
    notifyListeners();
  }
}