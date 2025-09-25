import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/Settings/languageProvider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LanguageProvider>();
    final selectedLang = provider.selectedLang;
    final languages = ["Indonesia", "English"];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        title: const Text(
          "Bahasa",
          style: TextStyle(fontFamily: 'Righteous', color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: languages.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final lang = languages[index];
          final isSelected = lang == selectedLang;

          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => provider.setLanguage(lang),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? const Color(0xFFBF3131) : Colors.grey.shade300,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.language,
                    color: isSelected ? const Color(0xFFBF3131) : Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      lang,
                      style: TextStyle(
                        fontFamily: 'Righteous',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? const Color(0xFFBF3131) : Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: isSelected ? const Color(0xFFBF3131) : Colors.grey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}