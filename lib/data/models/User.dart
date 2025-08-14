class UserModel {
  final int id;
  final String name;
  final String email;
  final String noTelp;
  final String? fotoProfil;
  final String? namaRole;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.noTelp,
    this.fotoProfil,
    this.namaRole,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      noTelp: json['no_telp'],
      fotoProfil: json['foto_profil'],
      namaRole: json['nama_role'],
    );
  }
}
