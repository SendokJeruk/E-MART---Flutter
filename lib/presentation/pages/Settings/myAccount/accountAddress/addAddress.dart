import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/Address/addressProvider.dart'; // sesuaikan path

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final labelController = TextEditingController();
  final detailController = TextEditingController();

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

          // sinkronisasi zip dari provider.selectedDomestic
          final currentZip =
              provider.selectedDomestic?['zip_code']?.toString() ??
              provider.selectedDomestic?['zip']?.toString();
          if (currentZip != null && currentZip != selectedZipValue) {
            selectedZipValue = currentZip;
          }
          if (provider.searchResults.isEmpty) {
            selectedZipValue = null;
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Label otomatis
                  TextFormField(
                    controller: labelController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Label Alamat (otomatis)',
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Provinsi
                  _buildDropdownContainer(
                    title: "Provinsi",
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
                  const SizedBox(height: 12),

                  // Kota
                  _buildDropdownContainer(
                    title: "Kota",
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
                  const SizedBox(height: 12),

                  // Kecamatan + Kelurahan
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownContainer(
                          title: "Kecamatan",
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
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDropdownContainer(
                          title: "Kelurahan",
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
                              border: InputBorder.none,
                            ),
                            validator:
                                (v) => v == null ? 'Harus dipilih' : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tombol cari kode domestik
                  ElevatedButton(
                    onPressed: () async {
                      await provider.cariKodeDomestik();
                      if (provider.selectedDomestic == null &&
                          context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data domestik tidak ditemukan"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBF3131),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("Cari Kode Domestik & ZIP"),
                  ),
                  const SizedBox(height: 12),

                  // Domestik + ZIP
                  if (provider.showKodeDomestik &&
                      provider.searchResults.isNotEmpty)
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownContainer(
                            title: "Kode Domestik",
                            child:
                                DropdownButtonFormField<Map<String, dynamic>>(
                                  value: provider.selectedDomestic,
                                  hint: const Text("Kode Domestik"),
                                  isExpanded: true,
                                  items:
                                      provider.searchResults.map((dom) {
                                        final idText =
                                            dom['kode_domestik']?.toString() ??
                                            dom['id'].toString();
                                        return DropdownMenuItem(
                                          value: dom,
                                          child: Text(idText),
                                        );
                                      }).toList(),
                                  onChanged: (val) {
                                    if (val == null) return;
                                    provider.selectDomestic(val);
                                    setState(() {
                                      selectedZipValue =
                                          val['zip_code']?.toString();
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  validator: (v) => v == null ? 'Wajib' : null,
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDropdownContainer(
                            title: "ZIP Code",
                            child: TextFormField(
                              readOnly: true,
                              controller: TextEditingController(
                                text: selectedZipValue ?? "",
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
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
                      "Klik tombol di atas untuk mencari Kode Domestik & ZIP",
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

                  // Detail alamat opsional
                  _buildDropdownContainer(
                    title: "Detail Alamat (opsional)",
                    child: TextFormField(
                      controller: detailController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Contoh: Rumah, RT/RW, Blok, No. Rumah",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (provider.autoLabel.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        "Label Alamat: ${provider.autoLabel}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                  ElevatedButton(
                    onPressed:
                        provider.selectedSubdistrict != null &&
                                provider.selectedDomestic != null &&
                                _formKey.currentState!.validate()
                            ? () async {
                              final success = await provider.saveAddressToApi(
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

  Widget _buildDropdownContainer({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFBF3131),
            fontFamily: 'Righteous',
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: _boxDecoration(),
          child: child,
        ),
      ],
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
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
    );
  }
}
