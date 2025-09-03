import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/addressProvider.dart'; // sesuaikan path jika perlu

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final labelController = TextEditingController();
  final detailController = TextEditingController();

  // state for zip dropdown (mirror of provider.selectedDomestic zip)
  String? selectedZipValue;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<AddressProvider>(context, listen: false).loadProvinces();
    });
  }

  @override
  void dispose() {
    labelController.dispose();
    detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBF3131),
        foregroundColor: Colors.white,
        title: const Text(
          "Tambah Alamat",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<AddressProvider>(
        builder: (context, provider, _) {
          // sinkronisasi label otomatis
          final auto = provider.autoLabel;
          if (labelController.text != auto) {
            labelController.text = auto;
          }

          // sinkronisasi selectedZipValue saat provider.selectedDomestic berubah
          final currentZip =
              provider.selectedDomestic?['zip_code']?.toString() ??
              provider.selectedDomestic?['zip']?.toString();
          if (currentZip != null && currentZip != selectedZipValue) {
            selectedZipValue = currentZip;
          }
          // if domestics got cleared, reset selectedZipValue
          if (provider.domestics.isEmpty) {
            selectedZipValue = null;
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Label Alamat (otomatis)
                  TextFormField(
                    controller: labelController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Label Alamat (otomatis)',
                    ),
                  ),
                  const SizedBox(height: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Provinsi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBF3131),
                          fontFamily: 'Righteous',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 6),
                              spreadRadius: 0,
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          value: provider.selectedProvince,
                          hint: const Text("Pilih Provinsi"),
                          isExpanded: true,
                          items:
                              provider.provinces.map((prov) {
                                return DropdownMenuItem(
                                  value: prov['id'].toString(),
                                  child: Text(prov['name']),
                                );
                              }).toList(),
                          onChanged: (val) {
                            if (val == null) return;
                            provider.selectProvince(val);
                            provider.loadCities(val);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          validator: (v) => v == null ? 'Harus dipilih' : null,
                        ),
                      ),
                    ],
                  ),

                  // Kota
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        "Kota",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBF3131),
                          fontFamily: 'Righteous',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 6),
                              spreadRadius: 0,
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          value: provider.selectedCity,
                          hint: const Text("Pilih Kota"),
                          isExpanded: true,
                          items:
                              provider.cities.map((city) {
                                return DropdownMenuItem(
                                  value: city['id'].toString(),
                                  child: Text(city['name']),
                                );
                              }).toList(),
                          onChanged: (val) {
                            if (val == null) return;
                            provider.selectCity(val);
                            provider.loadDistricts(val);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          validator: (v) => v == null ? 'Harus dipilih' : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // ganti bagian Kecamatan & Kelurahan
                  Row(
                    children: [
                      // Kecamatan
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Kecamatan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFBF3131),
                                fontFamily: 'Righteous',
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 6),
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                value: provider.selectedDistrict,
                                hint: const Text("Pilih Kecamatan"),
                                isExpanded: true,
                                items:
                                    provider.districts.map((dist) {
                                      return DropdownMenuItem(
                                        value: dist['id'].toString(),
                                        child: Text(dist['name']),
                                      );
                                    }).toList(),
                                onChanged: (val) {
                                  if (val == null) return;
                                  provider.selectDistrict(val);
                                  provider.loadSubdistricts(val);
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                validator:
                                    (v) => v == null ? 'Harus dipilih' : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Kelurahan
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Kelurahan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFBF3131),
                                fontFamily: 'Righteous',
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0, 6),
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: DropdownButtonFormField<String>(
                                value: provider.selectedSubdistrict,
                                hint: const Text("Pilih Kelurahan"),
                                isExpanded: true,
                                items:
                                    provider.subdistricts.map((sub) {
                                      return DropdownMenuItem(
                                        value: sub['id'].toString(),
                                        child: Text(sub['name']),
                                      );
                                    }).toList(),
                                onChanged: (val) {
                                  if (val == null) return;
                                  provider.selectSubdistrict(val);
                                },
                                decoration: const InputDecoration(
                                  border:
                                      InputBorder.none, // <-- garis bawah ilang
                                ),
                                validator:
                                    (v) => v == null ? 'Harus dipilih' : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Row: Kode Domestik & ZIP Code
                  if (provider.domestics.isNotEmpty)
                    Row(
                      children: [
                        // Domestik
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 6),
                                  spreadRadius: 0,
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child:
                                DropdownButtonFormField<Map<String, dynamic>>(
                                  value: provider.selectedDomestic,
                                  hint: const Text("Kode Domestik"),
                                  isExpanded: true,
                                  items:
                                      provider.domestics.map((dom) {
                                        final idText =
                                            dom['kode_domestik']?.toString() ??
                                            dom['id'].toString();
                                        final zipText =
                                            dom['zip_code']?.toString() ??
                                            dom['zip']?.toString() ??
                                            '';
                                        return DropdownMenuItem(
                                          value: dom,
                                          child: Text(
                                            zipText.isNotEmpty
                                                ? "$idText - $zipText"
                                                : idText,
                                          ),
                                        );
                                      }).toList(),
                                  onChanged: (val) {
                                    if (val == null) return;
                                    provider.selectDomestic(val);
                                    selectedZipValue =
                                        val['zip_code']?.toString() ??
                                        val['zip']?.toString();
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Domestik',
                                  ),
                                  validator: (v) => v == null ? 'Wajib' : null,
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // ZIP Code
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 6),
                                  spreadRadius: 0,
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: DropdownButtonFormField<String>(
                              value: selectedZipValue,
                              hint: const Text("Kode Pos"),
                              isExpanded: true,
                              items:
                                  provider.subdistricts
                                      .map(
                                        (sub) =>
                                            sub['zip_code']?.toString() ?? "",
                                      )
                                      .where((zip) => zip.isNotEmpty)
                                      .toSet()
                                      .map(
                                        (zip) => DropdownMenuItem(
                                          value: zip,
                                          child: Text(zip),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (val) {
                                if (val == null) return;
                                setState(() {
                                  selectedZipValue = val;
                                });
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'ZIP',
                              ),
                              validator:
                                  (v) =>
                                      v == null || v.isEmpty ? 'Wajib' : null,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    const Text(
                      "Pilih Kelurahan untuk mencari Kode POS dan Domestik",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Righteous',
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 12),

                  const Divider(height: 1, color: Colors.grey),
                  const SizedBox(height: 12),

                  // Detail Alamat (opsional)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Detail Alamat (opsional)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBF3131),
                          fontFamily: 'Righteous',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 6),
                              spreadRadius: 0,
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: detailController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Contoh: Rumah, RT/RW, Blok, No. Rumah",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Preview label
                  if (provider.autoLabel.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Label Alamat: ${provider.autoLabel}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                  // Simpan
                  ElevatedButton(
                    onPressed:
                        provider.selectedSubdistrict != null &&
                                provider.selectedDomestic != null &&
                                _formKey.currentState!.validate()
                            ? () async {
                              final success = await provider.saveAddressToApi(
                                // <-- ganti ini
                                detailAlamat: detailController.text,
                              );

                              if (success && context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Alamat berhasil disimpan ke server',
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              } else if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Gagal simpan alamat ke server',
                                    ),
                                  ),
                                );
                              }
                            }
                            : null,
                    child: const Text('Simpan Alamat'),
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
